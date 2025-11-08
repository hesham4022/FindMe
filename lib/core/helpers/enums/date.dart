import 'package:easy_localization/easy_localization.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/strings.dart';

extension DateTimeExtension on DateTime {
  String get shortMonthName {
    switch (month) {
      case 1:
        return AppStrings.jan;
      case 2:
        return AppStrings.feb;
      case 3:
        return AppStrings.mar;
      case 4:
        return AppStrings.apr;
      case 5:
        return AppStrings.may;
      case 6:
        return AppStrings.jun;
      case 7:
        return AppStrings.jul;
      case 8:
        return AppStrings.aug;
      case 9:
        return AppStrings.sept;
      case 10:
        return AppStrings.oct;
      case 11:
        return AppStrings.nov;
      case 12:
        return AppStrings.dec;
      default:
        return 'Err';
    }
  }

  String get shortYear => year.toString().substring(2);

  bool isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isAfter(dateTime);
  }

  bool isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isBefore(dateTime);
  }

  bool isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final date = this;
    final isAfter = date.isAfterOrEqualTo(fromDateTime);
    final isBefore = date.isBeforeOrEqualTo(toDateTime);
    return isAfter && isBefore;
  }

  /// This method is used  Used to return the beginning of today's date
  DateTime get toDateOnly {
    return DateTime(year, month, day);
  }

  DateTime get toTimeOnly {
    return DateTime(0, 0, 0, hour, minute);
  }

  /// Hour:Minute:Second:Millisecond (ex: 09:18:22:200)
  String get toHMSMS {
    return '$hour:$minute:$second:$millisecond';
  }

  /// Hour:Minute (ex: 09:18)
  String get toHM {
    return '$hour:$minute';
  }

  //! Get DMY Format
  /// Get translated String date ex: 21 Sep 1991
  String get toDMYFormat {
    return '$day ${shortMonthName.ts}, $year';
  }

  //! Get DMY Format
  /// Get translated String date ex: 1991-09-21
  String get toYMDFormat {
    String formattedDate = DateFormat('yyyy-MM-dd', "En").format(this);
    return formattedDate;
  }

  String getAMOrPM() {
    if (hour == 24 || hour == 0) {
      return AppStrings.am;
    }
    if (hour == 12) {
      return AppStrings.pm;
    }
    if (hour < 12) {
      return AppStrings.am;
    }
    return AppStrings.pm;
  }

  String parseHour() {
    if (hour == 24 || hour == 0) {
      return "12";
    }
    if (hour < 12) {
      return hour.toString();
    }
    if (hour == 12) {
      return hour.toString();
    }
    return (hour - 12).toString();
  }

  String parseMinutes() {
    if (minute == 0) {
      return "00";
    }
    if (minute < 10) {
      return "0$minute";
    }
    return minute.toString();
  }

  /// ex: Yesterday / Today / Tomorrow / 20 Jan 2021
  String toSpecificFormat() {
    final today = DateTime.now().toDateOnly;
    final yesterday =
        DateTime.now().toDateOnly.subtract(const Duration(days: 1));
    final tomorrow = DateTime.now().toDateOnly.add(const Duration(days: 1));

    if (yesterday == toDateOnly) {
      return AppStrings.yesterday.tr();
    } else if (today == toDateOnly) {
      return AppStrings.today.tr();
    } else if (tomorrow == toDateOnly) {
      return AppStrings.tomorrow.tr();
    } else {
      return toDMYFormat;
    }
  }

  /// ex: 10:00 AM / 10:00 PM  translated
  String get hourAndMin {
    final hours = parseHour();
    final minutes = parseMinutes();
    return "$hours:$minutes ${getAMOrPM().tr()}";
  }

  String hourInZeroformat() {
    if (hour == 0) {
      return "00";
    }
    if (hour < 10) {
      return "0$hour";
    }
    return hour.toString();
  }

  String minutesInZeroFormat() {
    if (minute.remainder(60) == 0) {
      return "00";
    }
    if (minute.remainder(60) < 10) {
      return "0${minute.remainder(60)}";
    }
    return minute.remainder(60).toString();
  }

  String get shortDayName {
    switch (weekday) {
      case 1:
        return AppStrings.mon;
      case 2:
        return AppStrings.tue;
      case 3:
        return AppStrings.wed;
      case 4:
        return AppStrings.thu;
      case 5:
        return AppStrings.fri;
      case 6:
        return AppStrings.sat;
      case 7:
        return AppStrings.sun;
      default:
        return 'Err';
    }
  }

//------------------------------------------------------------------------------
//! Handle DateTime
  /// Returns a [DateTime] object that is converted according to the user's time zone.
  /// The method adds the user's active time zone to the current UTC time to convert it to the user's final date time.
  DateTime toActiveTimeZone() {
    return this;
    // if(offset == null) return toLocal();
    // return add(offset.toDuration());
  }
}

combineDateWithTime({
  required DateTime? date,
  required DateTime? time,
}) {
  if (date == null || time == null) {
    return null;
  }
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
    time.second,
  );
}

extension DurationExtension on Duration {
  String toMin() {
    int minutes = inMinutes;
    int seconds = inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  /// Ex: 3:46:36
  String formatDuration() {
    int hours = inHours;
    int minutes = inMinutes % 60;
    // int seconds = inSeconds % 60;

    if (hours == 0) {
      return minutes.toString();
    }

    return '$hours:${minutes.toString().padLeft(2, '0')}';
  }
}

/// Ex: From 9 to 14 April, 2024
String kFromToDate(DateTime from, DateTime to) {
  if (from.month == to.month && from.year == to.year) {
    if (from.day == to.day) {
      return '${from.day} ${from.shortMonthName.tr()}, ${from.year}';
    } else {
      return "${"From".ts} ${from.day} ${"to".ts} ${to.day} ${to.shortMonthName.tr()}, ${to.year}";
    }
  }
  return '${"From".ts} ${from.day} ${from.shortMonthName.tr()}, ${from.year} ${"to".ts} ${to.day} ${to.shortMonthName.tr()}, ${to.year}';
}
