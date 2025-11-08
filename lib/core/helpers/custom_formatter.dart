import 'package:flutter/services.dart';

// Custom Input Formatter to prevent leading zeros but allow zeros inside
class DisallowLeadingZeroFormatter extends TextInputFormatter {
  final disallowZero = FilteringTextInputFormatter.deny(
    RegExp(r'^0+'),
  );

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueText = newValue.text;
    if (newValueText.length > 1 && newValueText[0].trim() == '0') {
      newValue = disallowZero.formatEditUpdate(oldValue, newValue);
      if (newValue.text.isEmpty) {
        return oldValue;
      }
    }
    if (newValueText.isNotEmpty) {
      return int.tryParse(newValueText) != null ? newValue : oldValue;
    }
    return newValue;
  }
}

/// Custom input formatter to convert Arabic digits to English digits
class ArabicToEnglishDigitsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAllMapped(
      RegExp(r'[\u0660-\u0669]'),
      (match) => (match.group(0)!.codeUnitAt(0) - 0x660).toString(),
    );
    return newValue.copyWith(text: newText, selection: newValue.selection);
  }
}

List<TextInputFormatter> phoneNumberInputFormatters() {
  // final disallowZero = FilteringTextInputFormatter.deny(
  //   RegExp(r'^0+'),
  // );
  return [
    // FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
    ArabicToEnglishDigitsFormatter(),
    DisallowLeadingZeroFormatter(),
    // TextInputFormatter.withFunction(
    //     (TextEditingValue oldValue, TextEditingValue newValue) {
    //   final newValueText = newValue.text;
    //   if (newValueText.length > 1 && newValueText[0].trim() == '0') {
    //     newValue = disallowZero.formatEditUpdate(oldValue, newValue);
    //     if (newValue.text.isEmpty) {
    //       return oldValue;
    //     }
    //   }
    //   if (newValueText.isNotEmpty) {
    //     return int.tryParse(newValueText) != null ? newValue : oldValue;
    //   }
    //   return newValue;
    // })
  ];
}
