import 'dart:async';

import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/animations.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';

class ResendOTPWidget extends StatefulWidget {
  const ResendOTPWidget({
    super.key,
    required this.onResend,
    required this.isLoading,
    required this.isSuccess,
  });

  final Function onResend;
  final bool isLoading;
  final bool isSuccess;

  @override
  State<ResendOTPWidget> createState() => _ResendOTPWidgetState();
}

class _ResendOTPWidgetState extends State<ResendOTPWidget> {
  late Timer _timer;
  int start = 1 * 60;
  int time = 1 * 60;

  String toTimeField(int n) => n.toString().padLeft(2, '0');

  String getTimer() {
    var seconds = time % 60;
    var minutes = time ~/ 60;
    return '${toTimeField(minutes)}:${toTimeField(seconds)}';
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Stopwatch();
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time == 0) {
          timer.cancel();
        } else {
          time--;
        }

        setState(() {});
      },
    );
  }

  void refreshTimer() {
    _timer.cancel();
    time = 2 * 60;
    startTimer();

    setState(() {});
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ResendOTPWidget oldWidget) {
    if (widget.isSuccess) {
      refreshTimer();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFilledButton(
      // state: (time == 0) ? CustomState.active : CustomState.disabled,
      state: CustomState.active,
      color: AppColors.saltBox200,
      loading: widget.isLoading,
      loadingAnimation: AppAnimations.moveLoader,
      onPressed: () => widget.onResend(),
      width: 353,
      height: 50,
      title: (time == 0)
          ? Text(
              AppStrings.resendOTP.ts,
              style: Theme.of(context).textTheme.kParagraph01Regular.copyWith(
                    color: AppColors.saltBox800,
                  ),
            )
          : Text(
              "${AppStrings.resendOTP.ts} (${getTimer()})",
              style: Theme.of(context).textTheme.kParagraph01Regular.copyWith(
                    color: AppColors.saltBox500,
                  ),
            ),
    );
  }
}
