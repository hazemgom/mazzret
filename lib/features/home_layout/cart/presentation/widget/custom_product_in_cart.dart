// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mozart_flutter_app/config/app_assets.dart';
// import 'package:mozart_flutter_app/config/app_routes.dart';
// import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
// import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
// import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
// import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
// import 'package:mozart_flutter_app/utils/styles/colors.dart';
// import 'package:mozart_flutter_app/utils/styles/fonts.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class CustomProductInCart extends StatefulWidget {
//   CustomProductInCart(
//       {Key? key,
//       required this.image,
//       required this.text,
//       required this.text2,
//       required this.text3,
//       required this.test,
//       required this.updatedText,
//       required this.index,
//       this.counter,
//       this.quantity = 1})
//       : super(key: key);
//   String image;
//   String text;
//   String text2;
//   String text3;
//   int test;
//   String updatedText;
//   int quantity;
//   int? counter;
//   int index;
//
//   @override
//   State<CustomProductInCart> createState() => _CustomProductInCartState();
// }
//
// class _CustomProductInCartState extends State<CustomProductInCart> {
//   int? newCount;
//   String? imagePath;
//
//   Future<void> _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         imagePath = pickedFile.path;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     newCount = widget.test;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {
//         if (state is UploadImageToAdminSuccessState) {
//           CustomSnackBar.showMessage(
//             context,
//             message: AppLocalizations.of(context)!
//                 .thesuggestedimagehasbeenuploadedsuccessfully,
//             messageColor: AppColors.primaryColor,
//           );
//           imagePath = '';
//         } else if (state is UploadImageToAdminErrorState) {
//           CustomSnackBar.showMessage(context,
//               message: 'Faliur', messageColor: Colors.red);
//         }
//       },
//       builder: (context, state) {
//         var homeCubit = HomeCubit.get(context);
//
//         return BlocConsumer<UserCartCubit, UserCartState>(
//           listener: (context, state) async {
//             if (state is DeleteOneProductFromCartSuccessState ||
//                 state is DeleteAllProductsFromCartSuccessState) {
//               await BlocProvider.of<UserCartCubit>(context)
//                   .getAllUserCartFunction();
//             }
//           },
//           builder: (context, state) {
//             var userCartCubit = UserCartCubit.get(context);
//             var userCartList = userCartCubit.userCartModel;
//
//             return Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.h),
//               child: Container(
//                 height: 170.h,
//                 width: 380.w,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5.r),
//                     border: Border.all(width: 0.2.w, color: AppColors.grey)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Padding(
//                     //   padding: EdgeInsets.only(
//                     //       top: 5.h, left: 16.w, right: 16.w, bottom: 5.h),
//                     //   child: Column(
//                     //     children: [
//                     //       // SvgPicture.asset(AppAssets.deleteIcon),
//                     //       const Spacer(),
//                     //       SvgPicture.asset(AppAssets.fullLoveIcon, color: Colors.transparent),
//                     //       // Text(empty)
//                     //     ],
//                     //   ),
//                     // ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 16.w, right: 11.w),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Navigator.pushNamed(
//                                     context,
//                                     RouteName.uploadScreenRoute,
//                                     arguments: userCartList!.data!
//                                         .cartItems![widget.index].product!.sId,
//                                   );
//                                 },
//                                 icon: Icon(
//                                   Icons.upload,
//                                   color: Colors.green,
//                                   size: 24.sp,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   userCartCubit.deleteOnProductFromCart(
//                                     cartId: userCartList!
//                                         .data!.cartItems![widget.index].sId!,
//                                   );
//                                 },
//                                 icon: Icon(
//                                   Icons.delete_forever_rounded,
//                                   color: Colors.red,
//                                   size: 24.sp,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 112.w,
//                                 child: Text(
//                                   widget.text,
//                                   textAlign: TextAlign.end,
//                                   style: GoogleFonts.cairo(
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w700),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: 210.w,
//                             child: Text(
//                               widget.text2,
//                               textAlign: TextAlign.end,
//                               style: GoogleFonts.cairo(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 210.w,
//                             child: Text(
//                               // "${newCount ?? widget.test}",
//                               "${AppLocalizations.of(context)!.quan} ${widget.test}",
//                               textAlign: TextAlign.end,
//                               style: GoogleFonts.cairo(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.normal),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               // newCount != widget.test
//                               //     ? InkWell(
//                               //         onTap: () {
//                               //           userCartCubit.updateUserCartFunction(
//                               //             productId: userCartList!.data!
//                               //                 .cartItems![widget.index].sId!,
//                               //             // .cartItems![index].sId!,
//                               //             quantity: newCount!,
//                               //           );
//                               //         },
//                               //         child: Container(
//                               //           padding: EdgeInsets.symmetric(
//                               //               horizontal: 5.w, vertical: 2.h),
//                               //           decoration: BoxDecoration(
//                               //             color: AppColors.primaryColor,
//                               //             borderRadius:
//                               //                 BorderRadius.circular(12.r),
//                               //           ),
//                               //           child: Text(
//                               //             widget.updatedText,
//                               //             style: GoogleFonts.cairo(
//                               //                 color: Colors.white,
//                               //                 fontSize: 16.sp,
//                               //                 fontWeight: FontWeight.normal),
//                               //           ),
//                               //         ),
//                               //       )
//                               //     : Container(),
//                               IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       newCount = (newCount! + 1);
//                                     });
//                                     userCartCubit.updateUserCartFunction(
//                                       productId: userCartList!
//                                           .data!.cartItems![widget.index].sId!,
//                                       // .cartItems![index].sId!,
//                                       quantity: newCount!,
//                                     );
//                                   },
//                                   icon: Icon(Icons.add)),
//                               Text(
//                                 newCount.toString(),
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.cairo(
//                                     color: Colors.black38,
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       if (newCount! <= 1) {
//                                         CustomSnackBar.showMessage(context,
//                                             message: AppLocalizations.of(
//                                                     context)!
//                                                 .thereisanirreversibleproblem,
//                                             messageColor: Colors.red);
//                                       } else {
//                                         newCount = (newCount! - 1);
//                                       }
//                                     });
//                                     userCartCubit.updateUserCartFunction(
//                                       productId: userCartList!
//                                           .data!.cartItems![widget.index].sId!,
//                                       // .cartItems![index].sId!,
//                                       quantity: newCount!,
//                                     );
//                                   },
//                                   icon: Icon(Icons.remove)),
//                               Text(
//                                 '${widget.text3} ${AppLocalizations.of(context)!.egp}',
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.cairo(
//                                   color: AppColors.primaryColor,
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // Row(
//                           //   children: [
//                           //     GestureDetector(
//                           //       onTap: () {
//                           //         setState(() {
//                           //           widget.quantity++;
//                           //         });
//                           //       },
//                           //       child: Card(
//                           //         elevation: 1,
//                           //         child: Container(
//                           //           height: 25.h,
//                           //           width: 25.w,
//                           //           decoration: BoxDecoration(
//                           //             color: AppColors.primaryColor,
//                           //             borderRadius: BorderRadius.circular(5.r),
//                           //           ),
//                           //           child: Center(
//                           //             child: Icon(
//                           //               Icons.add,
//                           //               color: AppColors.white,
//                           //             ),
//                           //           ),
//                           //         ),
//                           //       ),
//                           //     ),
//                           //     SizedBox(
//                           //       width: 5.w,
//                           //     ),
//                           //     Text(
//                           //       "${widget.quantity}",
//                           //       style: GoogleFonts.cairo(fontSize: 18.sp),
//                           //     ),
//                           //     SizedBox(
//                           //       width: 5.w,
//                           //     ),
//                           //     GestureDetector(
//                           //       onTap: () {
//                           //         setState(() {
//                           //           widget.quantity--;
//                           //         });
//                           //       },
//                           //       child: Card(
//                           //         elevation: 1,
//                           //         child: Container(
//                           //           height: 25.h,
//                           //           width: 25.w,
//                           //           decoration: BoxDecoration(
//                           //             color: AppColors.blue,
//                           //             borderRadius: BorderRadius.circular(5.w),
//                           //           ),
//                           //           child: const Center(
//                           //             child: Icon(Icons.remove),
//                           //           ),
//                           //         ),
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//                           // SizedBox(
//                           //   width: 210.w,
//                           //   child: Text(
//                           //     '${widget.text3} جنيه',
//                           //     textAlign: TextAlign.center,
//                           //     style: GoogleFonts.cairo(
//                           //         color: AppColors.primaryColor,
//                           //         fontSize: 16.sp,
//                           //         fontWeight: FontWeight.normal),
//                           //   ),
//                           // ),
//                           const SizedBox(),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 165.h,
//                       width: 127.w,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.r),
//                           border:
//                               Border.all(width: 0.2.w, color: AppColors.grey)),
//                       // child: Image.asset(widget.image),
//                       child: CachedImage(
//                         link: widget.image,
//                         fit: BoxFit.cover,
//                         borderRadius: 12.r,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomProductInCart extends StatefulWidget {
  CustomProductInCart(
      {Key? key,
        required this.image,
        required this.text,
        required this.text2,
        required this.text3,
        required this.test,
        required this.index,
        this.counter,
        this.quantity = 1})
      : super(key: key);
  String image;
  String text;
  String text2;
  String text3;
  int test;
  int quantity;
  int? counter;
  int index;

  @override
  State<CustomProductInCart> createState() => _CustomProductInCartState();
}

class _CustomProductInCartState extends State<CustomProductInCart> {
  int? newCount;
  String? imagePath;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    newCount = widget.test;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is UploadImageToAdminSuccessState) {
          CustomSnackBar.showMessage(
            context,
            message: AppLocalizations.of(context)!
                .thesuggestedimagehasbeenuploadedsuccessfully,
            messageColor: AppColors.primaryColor,
          );
          imagePath = '';
        } else if (state is UploadImageToAdminErrorState) {
          CustomSnackBar.showMessage(context,
              message: 'Faliur', messageColor: Colors.red);
        }
      },
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);

        return BlocConsumer<UserCartCubit, UserCartState>(
          listener: (context, state) async {
            if (state is DeleteOneProductFromCartSuccessState ||
                state is DeleteAllProductsFromCartSuccessState) {
              await BlocProvider.of<UserCartCubit>(context)
                  .getAllUserCartFunction();
            }
          },
          builder: (context, state) {
            var userCartCubit = UserCartCubit.get(context);
            var userCartList = userCartCubit.userCartModel;

            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 12.h,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: AppColors.grey, width: 1.5.w),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: CachedImage(
                            link: widget.image,
                            fit: BoxFit.cover,
                            borderRadius: 12.r,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Text(
                          widget.text,
                          style: GoogleFonts.cairo(
                              fontSize: 16.sp, fontWeight: FontWeight.w700),
                          overflow: TextOverflow.clip,
                        ),
                        Row(
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
                              widget.counter.toString(),
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
                                          message: AppLocalizations.of(
                                              context)!
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
                  SizedBox(width: 4.w),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteName.uploadScreenRoute,
                                  arguments: userCartList!.data!
                                      .cartItems![widget.index].product!.sId,
                                );
                              },
                              child: Icon(
                                Icons.upload,
                                color: Colors.green,
                                size: 24.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                  userCartCubit.deleteOnProductFromCart(
                                    cartId: userCartList!
                                        .data!.cartItems![widget.index].sId!,
                                  );
                              },
                              child: Icon(
                                Icons.delete_forever_rounded,
                                color: Colors.red,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${widget.text3} ${AppLocalizations.of(context)!.egp}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            color: AppColors.primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
