import 'package:easy_localization/easy_localization.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/features/app/data/source/app_local.dart';

class DateTimeHelper {
  static get formatter =>
      DateFormat('MMM dd, yyyy', sl<AppLocal>().getCachedLanguage());
  static get formatterCustom =>
      DateFormat('yyyy MMM dd', sl<AppLocal>().getCachedLanguage());
  static get formatterCustom2 => DateFormat(
      'dd MMM yyyy', sl<AppLocal>().getCachedLanguage() == "en" ? "en_US" : "ar_SA");
  static get dayMonthFormat =>
      DateFormat('dd MMM', sl<AppLocal>().getCachedLanguage());
  static get formatterCustom3 =>
      DateFormat('dd/MM/yyyy', sl<AppLocal>().getCachedLanguage());
  static get formatterCustom4 =>
      DateFormat('d-M-yyyy', sl<AppLocal>().getCachedLanguage());
  static get formatterCustomForApi =>
      DateFormat('dd/MM/yyyy', sl<AppLocal>().getCachedLanguage());
  static get formatterCustomTime =>
      DateFormat('HH:mm', sl<AppLocal>().getCachedLanguage());
  static get formatterCustomTime2 =>
      DateFormat('hh:mm:ss', sl<AppLocal>().getCachedLanguage());
  static get formatterCustomDay =>
      DateFormat('EEEE', sl<AppLocal>().getCachedLanguage());
  static get formatterCustomDayNum =>
      DateFormat('dd', sl<AppLocal>().getCachedLanguage());
  static get formatterCustomMonthName =>
      DateFormat('MMMM', sl<AppLocal>().getCachedLanguage());

  static String formatToArabicTime(String time) {
    // Parse the input time string
    final parsedTime = DateFormat("HH:mm").parse(time);

    // Format the time to 12-hour format with Arabic AM/PM
    final formattedTime = DateFormat("hh:mm a", "ar").format(parsedTime);

    // Replace "AM/PM" with Arabic equivalents
    return formattedTime.replaceAll("AM", "ص").replaceAll("PM", "م");
  }

  static String convertAndFormatTime(String timeString) {
    final arabicAmPmPattern = RegExp(r'(\d{1,2}):(\d{2})\s*([ص|م])');
    final match = arabicAmPmPattern.firstMatch(timeString.trim());

    if (match != null) {
      final hour = int.parse(match.group(1)!);
      final minute = int.parse(match.group(2)!);
      final period = match.group(3);

      // Convert Arabic period indicators to AM/PM
      String periodEnglish;
      if (period == 'ص') {
        periodEnglish = 'AM';
      } else if (period == 'م') {
        periodEnglish = 'PM';
      } else {
        throw FormatException("Invalid period format");
      }

      // Create a DateTime object
      int hour24 = hour;
      if (periodEnglish == 'PM' && hour != 12) {
        hour24 = hour + 12;
      } else if (periodEnglish == 'AM' && hour == 12) {
        hour24 = 0;
      }

      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day, hour24, minute);

      // Format the DateTime object to a string
      final format = DateFormat('hh:mm a'); // Format as 'hh:mm AM/PM'
      return format.format(dt).toUpperCase(); // Convert to lowercase
    } else {
      throw const FormatException("Invalid time string format");
    }
  }



  static String getTimeZone(DateTime dateTime) => DateFormat.jm().format(dateTime);

  static String? convertTimeTo12Hours(String? timeString) {
    if (timeString == null) {
      return null;
    }

    try {
      final DateFormat format = DateFormat('H:mm:ss');
      final DateTime dateTime = format.parse(timeString);
      final String formattedTime = DateFormat('h:mm a').format(dateTime);
      return formattedTime;
    } catch (e) {
      return null; // Return null for invalid input
    }
  }
}
