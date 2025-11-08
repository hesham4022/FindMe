enum AppSupportedOS { android, ios }

//----------------------------- CURRENCY -----------------------------

// const currencyList = [
//   AppCurrency.sar,
//   AppCurrency.usd,
// ];

enum AppCurrency { sar, usd }

extension AppCurrencyExtension on AppCurrency {
  String get value {
    switch (this) {
      case AppCurrency.sar:
        return "Saudi Riyal (SAR)";
      case AppCurrency.usd:
        return "American Dollar (USD)";
    }
  }

  static AppCurrency fromValue(String value) {
    switch (value) {
      case 'sar':
        return AppCurrency.sar;
      case 'usd':
        return AppCurrency.usd;
      default:
        return AppCurrency.sar;
    }
  }
}
