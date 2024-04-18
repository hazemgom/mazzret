import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/admin_home_screen.dart';
import '../../../../../../config/app_routes.dart';
import '../../../../../home_layout/home/managers/home_cubit.dart';
import '../../../../../home_layout/home/presentation/product/presentation/details_product.dart';

class BannerAdminScreen extends StatelessWidget {
  BannerAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getBanners(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          if (state is GetBannersSuccessState && cubit.dataList.isNotEmpty) {
            return CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: cubit.dataList.map((banner) {
                int index = cubit.dataList.indexOf(banner);
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsProduct(
                                  productId: cubit.dataList[index].id,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Image.network(
                              banner.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () {
                            cubit.deleteBannerProduct(cubit.dataList[index].id);
                            Navigator.pushNamed(
                                context, RouteName.adminHomeLayoutRoute);
                            print(cubit.dataList[index].id);
                          },
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            );
          }
          if (state is GetBannersSuccessState && cubit.dataList.isEmpty ||
              cubit.dataList.length == 0) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('No banners uploaded'),
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
