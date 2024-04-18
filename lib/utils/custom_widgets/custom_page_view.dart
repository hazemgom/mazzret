import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';

class CustomPageView extends StatefulWidget {
  const CustomPageView({
    Key? key,
    required this.onPageChanged,
    required this.pageController,
  }) : super(key: key);
  final PageController pageController;
  final void Function(int)? onPageChanged;

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  final GlobalKey<CarouselSliderState> _sliderKey = GlobalKey();

  List<String> images = [
 "assets/images/rectangle.png",
 "assets/images/rectangle.png",
 "assets/images/rectangle.png",
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 141.h,
          width: 330.w,
          child: CarouselSlider(
            key: _sliderKey,
            items: images.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.asset(imageUrl,);
                },
              );
            }).toList(),
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16/9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              viewportFraction: 0.8,
            ),
          ),
        ),
      ],
    );
  }
}