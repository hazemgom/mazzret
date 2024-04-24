import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/custom_widgets/custom_shimmer.dart';
import '../../../../../home_layout/home/managers/home_cubit.dart';
import '../../../../../home_layout/home/presentation/product/presentation/details_product.dart';

class BannerScreen extends StatelessWidget {
  BannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getBanners(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          if(state is GetBannersLoadingState){
            return Padding(
              padding: EdgeInsets.all(20.sp),
              child: const ShimmerHomeVideoWidget(),
            );
          }
          if (state is GetBannersSuccessState && cubit.dataList.isNotEmpty) {
            return CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: cubit.dataList.map((banner) {
                int index = cubit.dataList.indexOf(banner);
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
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
                        padding: const EdgeInsets.all(4),
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
                    );
                  },
                );
              }).toList(),
            );
          }
          if (state is GetBannersSuccessState && cubit.dataList.isEmpty || cubit.dataList.length == 0) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text('No banners uploaded'),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
