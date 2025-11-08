extension RemoveTrailingZero on double {
  /// Remove Zeros after sign If found
  String removeTrailingZero() {
    String numberString = toString();
    return numberString.replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');
    // return toStringAsFixed(truncateToDouble() == this ? 0 : 2);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
