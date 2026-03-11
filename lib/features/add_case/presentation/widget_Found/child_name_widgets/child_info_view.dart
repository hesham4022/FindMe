import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/material.dart';

class ChildInfoView extends StatelessWidget {
  const ChildInfoView({
    super.key,
    this.header,
    required this.firstNameField,
    required this.lastNameField,
    required this.addressField,
    required this.ageField,
    required this.genderWidget,
    required this.weightHeightWidget,
    required this.otherDetailsField,
  });

  final Widget? header;
  final Widget firstNameField;
  final Widget lastNameField;
  final Widget addressField;
  final Widget ageField;
  final Widget genderWidget;
  final Widget weightHeightWidget;
  final Widget otherDetailsField;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(left: 6, right: 6, bottom: 40, top: 20),
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) header!,
          const VSpace(10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Child name:"),
          ),
          const VSpace(5),
          Row(
            children: [
              Expanded(child: firstNameField),
              const HSpace(5),
              Expanded(child: lastNameField),
            ],
          ),
          const VSpace(10),
          SizedBox(
            width: screenWidth * 0.42,
            child: addressField,
          ),
          const VSpace(10),
          SizedBox(
            width: screenWidth * 0.42,
            child: ageField,
          ),
          const VSpace(10),
          genderWidget,
          const VSpace(10),
          weightHeightWidget,
          const VSpace(10),
          SizedBox(
            width: screenWidth * 0.62,
            child: otherDetailsField,
          ),
        ],
      ),
    );
  }
}
