import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_layout.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/admin_home_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_product.dart';

import '../../../../utils/custom_widgets/custom_stackbar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is CreateBannersErrorState) {
            return CustomSnackBar.showMessage(
              context,
              message: 'حدث خطأ',
              messageColor: Colors.red,
            );
          }
          if (state is CreateBannersSucessState) {
            return CustomSnackBar.showMessage(
              context,
              message: 'تمت الاضافة بنجاح',
              messageColor: Colors.green,
            );
          }
        },
        builder: (context, state) {
          var cubit2 = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              title: Text(
                'المنتجات',
                style: GoogleFonts.tajawal(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (cubit2.productModel2 != null &&
                      cubit2.productModel2!.data != null)
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: cubit2.productModel2!.data!.length,
                      itemBuilder: (context, index) {
                        var product = cubit2.productModel2!.data![index];
                        return Stack(
                          children: [
                            CustomProduct(
                              width: 180.w,
                              image: product.image!.url!,
                              text1: product.title!,
                              text2: '',
                            ),
                            IconButton(
                              onPressed: () {
                                print(cubit2.productModel2!.data![index].sId!);
                                cubit2.CreateBanner(
                                        productId: cubit2
                                            .productModel2!.data![index].sId!,
                                        context: context)
                                    .then((value) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AdminHomeLayout();
                                      },
                                    ),
                                    (route) => false,
                                  );
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  if (cubit2.productModel2 == null ||
                      cubit2.productModel2!.data == null ||
                      cubit2.productModel2!.data!.isEmpty)
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow.shade800,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
