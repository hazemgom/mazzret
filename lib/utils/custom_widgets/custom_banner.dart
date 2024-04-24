import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/utils/constants/constants.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_shimmer.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderHome extends StatelessWidget {
  const SliderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);

        var model = homeCubit.bannerModel;

        return state is GetBannersLoadingState || homeCubit.bannerModel == null
            ? Padding(
                padding: EdgeInsets.all(20.sp),
                child: const ShimmerHomeVideoWidget(),
              )
            : homeCubit.bannerModel!.data == null ||
                    homeCubit.bannerModel!.data!.images == null
                ? Container(height: 50.h)
                : Container(
                    height: MediaQuery.of(context).size.height * 0.262,
                    alignment: AlignmentDirectional.center,
                    margin: EdgeInsets.all(20.sp),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2.w),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: const Offset(0, 1),
                          blurRadius: 20.r,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.grey.shade100,
                          offset: const Offset(0, 1),
                          blurRadius: 20.r,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          offset: const Offset(0, 1),
                          blurRadius: 20.r,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.grey.shade100,
                          offset: const Offset(0, 1),
                          blurRadius: 20.r,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        CarouselSlider.builder(
                          itemBuilder:
                              (BuildContext context, int index, int i) {
                            return homeCubit.bannerModel!.data!.images!.isEmpty
                                ? const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Empty'),
                                    ],
                                  )
                                : CachedImage(
                                    link: homeCubit
                                        .bannerModel!.data!.images![index].url,
                                    width: 400.w,
                                    borderRadius: 25.r,
                                    fit: BoxFit.cover,
                                  );
                          },
                          itemCount:
                              homeCubit.bannerModel!.data!.images!.length,
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            onPageChanged: homeCubit.onPageChangedSlider,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        AnimatedSmoothIndicator(
                          activeIndex: homeCubit.currentIndexSlider,
                          count: homeCubit.bannerModel!.data!.images!.length,
                          effect: WormEffect(
                            dotHeight: 5.h,
                            dotWidth: 35.w,
                            spacing: 8.w,
                            dotColor: Colors.grey.shade300,
                            activeDotColor: AppColors.primaryColor,
                            type: WormType.thinUnderground,
                            paintStyle: PaintingStyle.fill,
                          ),
                        )
                      ],
                    ),
                  );
      },
    );
  }
}
