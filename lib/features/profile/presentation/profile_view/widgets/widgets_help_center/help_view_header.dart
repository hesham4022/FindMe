import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HelpViewHeader extends StatelessWidget {
  const HelpViewHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 20),
      color: AppColors.mainColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Help Center",
                style: Theme.of(context).textTheme.kHeadingH5SemiBold.copyWith(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const VSpace(16),
          Text(
            "How Can We Help You ?",
            style: Theme.of(context).textTheme.kHeadingH5SemiBold.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const VSpace(10),
          CustomTextField(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            radius: 50,
            hint: "search...",
            prefixIcon: SvgPicture.asset(
              'assets/icons/search_icon_border.svg',
            ),
          ),
        ],
      ),
    );
  }
}
