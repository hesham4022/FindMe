import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/resources/images.dart';

class RatingStarsWidget extends StatelessWidget {
  const RatingStarsWidget({
    super.key,
    required this.rating,
    this.starSize = 44,
  });

  final String rating;
  final double? starSize;

  double? parseRating(String rating) => double.tryParse(rating);

  String _getStarIcon(int index, num rate) {
    if (index <= rate) {
      //  return AppImages.star;
      return '';
    } else if ((index - rate) < 1) {
      // return AppImages.halfStar;
      return '';
    } else {
      // return AppImages.starOulined;
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final rate = parseRating(rating);
    return rate != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              5,
              (i) => SvgPicture.asset(
                _getStarIcon(i + 1, rate),
                width: starSize?.sp,
                height: starSize?.sp,
                matchTextDirection: true,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
