import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomGetAllProduct extends StatefulWidget {
  CustomGetAllProduct({
    Key? key,
    required this.image,
    this.quantity = 1,
    required this.nameOfProduct,
    this.counter,
    required this.index,
    required this.onTap,
  }) : super(key: key);
  String image, nameOfProduct;
  int quantity;
  int? counter;
  int index;
  void Function()? onTap;

  @override
  State<CustomGetAllProduct> createState() => _CustomGetAllProductState();
}

class _CustomGetAllProductState extends State<CustomGetAllProduct> {
  int? newCount =  1;

  @override
  void initState() {
    super.initState();
    newCount = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCartCubit, UserCartState>(
      builder: (context, state) {
        var userCartCubit = UserCartCubit.get(context);
        var userCartList = userCartCubit.userCartModel;

        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            // color: Colors.red,
            // width: 220.w,
            // height: 250.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) {
                      return SvgPicture.asset(AppAssets.emptyImage);
                    },
                    imageUrl: widget.image,
                    width: 92.w,
                    height: 90.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: 80.w,
                  height: 47.h,
                  child: Row(
                    children: [
                      Text(
                        widget.nameOfProduct,
                        style: GoogleFonts.cairo(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            newCount = (newCount! + 1);
                          });
                          userCartCubit.updateUserCartFunction(
                            productId: userCartList!
                                .data!.cartItems![widget.index].sId!,
                            // .cartItems![index].sId!,
                            quantity: newCount!,
                          );
                        },
                        icon: Icon(Icons.add)),
                    Text(
                      '${widget.counter ?? 1}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                          color: Colors.black38,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (newCount! <= 1) {
                              CustomSnackBar.showMessage(context,
                                  message: AppLocalizations.of(context)!
                                      .thereisanirreversibleproblem,
                                  messageColor: Colors.red);
                            } else {
                              newCount = (newCount! - 1);
                            }
                          });
                          userCartCubit.updateUserCartFunction(
                            productId: userCartList!
                                .data!.cartItems![widget.index].sId!,
                            quantity: newCount!,
                          );
                        },
                        icon: Icon(Icons.remove)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
