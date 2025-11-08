enum Gender { male, female }

extension GenderExtension on Gender {
  static fromValue(String value) {
    switch (value) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return Gender.male;
    }
  }

  int get value {
    switch (this) {
      case Gender.male:
        return 0;
      case Gender.female:
        return 1;
    }
  }

  String get name {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
    }
  }

  bool get toBool {
    switch (this) {
      case Gender.male:
        return true;
      case Gender.female:
        return false;
    }
  }
}

extension GenderFromInt on String {
  Gender get toGender {
    switch (this) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;

      default:
        return Gender.male;
    }
  }
}
