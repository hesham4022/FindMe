import 'dart:ui';

import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/material.dart';

class FAQITab extends StatefulWidget {
  final String question;
  final String answer;

  const FAQITab({super.key, required this.question, required this.answer});

  @override
  State<FAQITab> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQITab> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xffECF1FF),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.question,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.mainColor,
                  size: 26,
                ),
              ],
            ),
          ),
        ),

        // Text Explain
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _expanded
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    widget.answer,
                    style: const TextStyle(color: Colors.black87),
                  ),
                )
              : const SizedBox.shrink(),
        ),

        const VSpace(12),
      ],
    );
  }
}
