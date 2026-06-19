import 'package:easy_localization/easy_localization.dart';

String timeAgo(String? isoDate) {
  if (isoDate == null) return '';

  try {
    final date = DateTime.parse(isoDate);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return "dayAgo".tr(args: [difference.inDays.toString()]);
      }
      return "daysAgo".tr(args: [difference.inDays.toString()]);
    } else if (difference.inHours > 0) {
      if (difference.inHours == 1) {
        return "hourAgo".tr(args: [difference.inHours.toString()]);
      }
      return "hoursAgo".tr(args: [difference.inHours.toString()]);
    } else if (difference.inMinutes > 0) {
      if (difference.inMinutes == 1) {
        return "minuteAgo".tr(args: [difference.inMinutes.toString()]);
      }
      return "minutesAgo".tr(args: [difference.inMinutes.toString()]);
    } else {
      return 'justNow'.tr();
    }
  } catch (e) {
    return '';
  }
}
