import 'dart:ui';

import 'package:find_me_app/core/resources/colors.dart';
import 'package:flutter/material.dart';

class AgeFilterApplyButton extends StatelessWidget {
  const AgeFilterApplyButton({
    super.key,
    required this.isLoading,
    required this.onApply,
    required this.pulseAnimation,
  });

  final bool isLoading;
  final VoidCallback onApply;
  final Animation<double> pulseAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: AnimatedBuilder(
        animation: pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: isLoading ? pulseAnimation.value : 1.0,
            child: ElevatedButton(
              onPressed: isLoading ? null : onApply,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                foregroundColor: Colors.white,
                disabledBackgroundColor:
                    const Color(0xFF534AB7).withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Applying filter...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome_rounded, size: 18),
                        SizedBox(width: 10),
                        Text(
                          'Apply Age Filter',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
