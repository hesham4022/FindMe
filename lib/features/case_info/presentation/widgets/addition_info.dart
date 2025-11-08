import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/widgets.dart';

class AdditionInfo extends StatelessWidget {
  const AdditionInfo({super.key, this.text, this.title});
  final String? text;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpace(5),
        Text(
          title ?? '',
          style: TextStyle(
            fontSize: 14,
            height: 1.2,
            color: AppColors.mainColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        VSpace(2),
        Text(
          text ?? '',
          style: TextStyle(
            fontSize: 12,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
