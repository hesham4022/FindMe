import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/resources/colors.dart';

/// Cache Network Image, handle error and placeholder
class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.isCircle = false,
    this.radius,
    this.topRightRadius = 10,
    this.topLeftRadius = 10,
    this.bottomRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.placeholder = Icons.account_circle_rounded,
    this.accessToken,
    this.fit = BoxFit.contain,
  });

  final String? image;
  final double? width;
  final double? height;
  final bool isCircle;
  final double? radius;
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final IconData? placeholder;
  final String? accessToken;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final finalHeight = width == height ? height?.w : height?.h;
    final finalWidth = width?.w;

    final finalImage = image != null
        ? (image?.contains('http') == true ? image : "http://$image")
        : null;

    return GestureDetector(
      // onTap: () {
      //   final memCacheHeight = height != double.maxFinite && height != null
      //       ? height?.h.pr.round()
      //       : null;
      //   final memCacheWidth = width != double.maxFinite && width != null
      //       ? width?.w.pr.round()
      //       : null;

      //   log(1.pr.toString());
      //   log("height:$height, width:$width");
      //   log("cached width:$memCacheWidth, cached height:$memCacheHeight");
      // },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: AppColors.saltBox50,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: !isCircle
                ? radius != null
                    ? BorderRadius.circular(radius!).r
                    : BorderRadius.only(
                        topLeft: Radius.circular(topLeftRadius).r,
                        topRight: Radius.circular(topRightRadius).r,
                        bottomLeft: Radius.circular(bottomLeftRadius).r,
                        bottomRight: Radius.circular(bottomRightRadius).r,
                      )
                : null),
        child: finalImage != null
            ? CachedNetworkImage(
                httpHeaders: accessToken != null
                    ? {'Authorization': 'Bearer $accessToken'}
                    : null,
                errorWidget: (_, __, ___) => Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                    ),
                    child: Icon(
                      placeholder ?? Icons.image_rounded,
                      size: height?.h,
                      color: AppColors.saltBox50,
                    ),
                  ),
                ),
                imageUrl: finalImage,
                fit: fit,
                height: finalHeight,
                width: finalWidth,
                // memCacheHeight: height != double.maxFinite && height != null
                //     ? finalHeight?.pr.round()
                //     : null,
                // memCacheWidth: width != double.maxFinite && width != null
                //     ? finalWidth?.pr.round()
                //     : null,
              )
            : Container(
                height: finalHeight,
                width: finalWidth,
                decoration: BoxDecoration(
                  shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                ),
                child: Icon(
                  placeholder ?? Icons.image_rounded,
                  size: finalHeight,
                  color: AppColors.saltBox400,
                ),
              ),
      ),
    );
  }
}
