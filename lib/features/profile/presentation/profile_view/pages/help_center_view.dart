import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/menu_Item_widget.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/widgets_help_center/fQA-tab.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/widgets_help_center/help_view_header.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/widgets_help_center/selected_tab.dart';
import 'package:flutter/material.dart';

class HelpCenterView extends StatefulWidget {
  const HelpCenterView({super.key});

  @override
  State<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> {
  Color fAQColor = AppColors.secondColor;
  Color contactUsColor = AppColors.secondColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HelpViewHeader(),
            VSpace(10),
            Expanded(
              child: SelectableButtonsWithBody(
                selectedColor: AppColors.mainColor,
                unselectedColor: AppColors.secondColor,
                labels: ["FAQ", "Contact Us"],
                bodies: [
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: const [
                      FAQITab(
                        question: "Lorem ipsum dolor sit amet?",
                        answer:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque...",
                      ),
                      FAQITab(
                        question: "Question 2?",
                        answer: "Answer 2...",
                      ),
                      FAQITab(
                        question: "Question 3?",
                        answer: "Answer 3...",
                      ),
                      FAQITab(
                        question: "Lorem ipsum dolor sit amet?",
                        answer:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque...",
                      ),
                      FAQITab(
                        question: "Question 2?",
                        answer: "Answer 2...",
                      ),
                      FAQITab(
                        question: "Question 3?",
                        answer: "Answer 3...",
                      ),
                      FAQITab(
                        question: "Lorem ipsum dolor sit amet?",
                        answer:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque...",
                      ),
                      FAQITab(
                        question: "Question 2?",
                        answer: "Answer 2...",
                      ),
                      FAQITab(
                        question: "Question 3?",
                        answer: "Answer 3...",
                      ),
                    ],
                  ),

                  //    contact us Tab

                  SingleChildScrollView(
                    child: Column(
                      children: [
                        MenuItemWidget(
                          isContainer: true,
                          title: "Customer Service",
                          icon: Icons.headphones,
                          onTap: () {},
                        ),
                        MenuItemWidget(
                          isContainer: true,
                          title: "Website",
                          icon: Icons.headphones,
                          onTap: () {},
                        ),
                        MenuItemWidget(
                          isContainer: true,
                          title: "Whatsapp",
                          icon: Icons.headphones,
                          onTap: () {},
                        ),
                        MenuItemWidget(
                          isContainer: true,
                          title: "FaceBooK",
                          icon: Icons.headphones,
                          onTap: () {},
                        ),
                        MenuItemWidget(
                          isContainer: true,
                          title: "Instagram",
                          icon: Icons.headphones,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
