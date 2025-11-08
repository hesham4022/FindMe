import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationSettingsView extends StatefulWidget {
  const NotificationSettingsView({super.key});

  @override
  State<NotificationSettingsView> createState() =>
      _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends State<NotificationSettingsView> {
  bool generalNotification = false;
  bool sound = true;
  bool soundCall = true;
  bool vibrate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'Notification Setting',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GeneralNotificationSwitchItem(
              text: "General Notification",
              value: generalNotification,
              onChanged: (value) {
                setState(() {
                  generalNotification = value;
                });
              },
            ),
            VSpace(20),
            GeneralNotificationSwitchItem(
              text: "Sound",
              value: sound,
              onChanged: (value) {
                setState(() {
                  sound = value;
                });
              },
            ),
            VSpace(20),
            GeneralNotificationSwitchItem(
              text: "Sound call",
              value: soundCall,
              onChanged: (value) {
                setState(() {
                  soundCall = value;
                });
              },
            ),
            VSpace(20),
            GeneralNotificationSwitchItem(
              text: "Vibarte",
              value: vibrate,
              onChanged: (value) {
                setState(() {
                  vibrate = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GeneralNotificationSwitchItem extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String text;

  const GeneralNotificationSwitchItem({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        CupertinoSwitch(
          activeTrackColor: AppColors.mainColor,
          inactiveTrackColor: AppColors.secondColor,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
