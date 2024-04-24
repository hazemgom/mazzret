import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    this.borderRadius,
    this.link,
    this.width,
    this.height,
    this.fit,
  });
  final double? borderRadius;
  final String? link;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 50.r),
      child: link != null
          ? CachedNetworkImage(
        errorWidget: (context, url, error) {
          return SvgPicture.asset(AppAssets.emptyImage);
        },
        imageUrl: link!,
        width: width ?? 30,
        height: height ?? 30,
        fit: fit, )
          : Container(
        width: width ?? 30,
        height: height ?? 30,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}