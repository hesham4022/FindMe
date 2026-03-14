import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/resources/strings.dart';

class AppValidators {
  static final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
  static final passwordRegex = RegExp(
      r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

  // static final nameRegex = RegExp(r'^[a-zA-Z]+$');
  static final nameRegex = RegExp(r"^[\u0600-\u06FF a-zA-Z]+$");
  static final tokenIDRegex = RegExp(r'^\d+$');
  static final numberRegex = RegExp(r'^\d+\.?\d{0,2}');
  // static final nameRegex = RegExp(r'[^a-zA-Z\u0600-\u06FF]');

  /// check empty or null text
  static String? generalValidate(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      return null;
    } else {
      return AppStrings.requiredField;
    }
  }

  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "textFieldIsRequired".ts;
    } else {
      bool nameValid = nameRegex.hasMatch(value);
      if (nameValid == false) {
        return AppStrings.notValidFirstName;
      }
      //
      else if (value.length < 3) {
        return AppStrings.first3Characters;
      }
      //
      else if (value.length > 50) {
        return AppStrings.first50Characters;
      }
    }
  }

  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.lastRequired;
    } else {
      bool nameValid = nameRegex.hasMatch(value);
      if (nameValid == false) {
        return AppStrings.notValidLastName;
      }
      //
      else if (value.length < 3) {
        return AppStrings.last3Characters;
      }
      //
      else if (value.length > 50) {
        return AppStrings.last50Characters;
      }
    }
    return null;
  }

  static String? validateWeightAndHieght(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "textFieldIsRequired".ts;
    } else {
      bool nameValid = nameRegex.hasMatch(value);
      if (nameValid == false) {
        return AppStrings.notValidFirstName;
      }
      //
      else if (value.length < 3) {
        return AppStrings.first3Characters;
      }
      //
      else if (value.length > 50) {
        return AppStrings.first50Characters;
      }
    }
    return null;
  }

  /// Validate Email text form field
  static String? validateEmail(String? email) {
    if (email != null && email.trim().isNotEmpty) {
      bool emailValid = emailRegex.hasMatch(email);
      if (emailValid == false) {
        return AppStrings.notValidEmail;
      } else {
        return null;
      }
    } else {
      return "textFieldIsRequired".ts;
    }
  }

  /// Validate Email text form field
  static String? validateTokenID(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      return null;
    } else {
      return AppStrings.tokenIDIsRequired;
    }
  }

  static String? validateSignInPassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return "textFieldIsRequired".ts;
    } else {
      return null;
    }
  }

  static String? validateNewPassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return AppStrings.passwordIsRequired;
    }
    // Check for minimum length of 8
    if (password.length < 8) {
      return AppStrings.passwordLengthNotLessThan8;
    }

    // Check for maximum length of 64
    if (password.length > 64) {
      return AppStrings.passwordLengthNotMoreThan64;
    }
    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return AppStrings.passwordMusthaveOneUppercase;
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return AppStrings.passwordMusthaveOneLowercase;
    }

    // Check for at least one digit
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return AppStrings.passwordMusthaveOneNumber;
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      return AppStrings.passwordMusthaveOneSpecialCharacter;
    }

    if (RegExp(r'^\s|\s$|\s{2,}').hasMatch(password)) {
      return AppStrings.passwordHasInvalidWhitespace;
    }

    if (RegExp(r'[^A-Za-z0-9!@#$&*~]').hasMatch(password)) {
      return AppStrings.passwordMusthaveSpecificSpecialCharacters;
    }

    return null;
  }

  /// Validate confirm password text form field
  static String? validateTwoPasswords(
    String? confirmPassword,
    String? password,
  ) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return "textFieldIsRequired".ts;
    }

    if (password != null && password.trim().isNotEmpty) {
      if (confirmPassword == password) {
        return null;
      }
    }
    return AppStrings.passwordAndConfirmPasswordMustBeSame;
  }

//------------------------ Phone Validation ------------------------------------
  /// Validate confirm password text form field
  static String? validatePhoneNumber(
    String? number,
  ) {
    if (number != null && number.trim().isNotEmpty) {
      if (number.length < 4 || number.length > 16) {
        return AppStrings.notValidPhone;
      } else {
        return null;
      }
    } else {
      return "textFieldIsRequired".ts;
    }
  }

  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Field is required";
    }

    final age = int.tryParse(value.trim());
    if (age == null) {
      return "Age must be a number";
    }

    if (age <= 0) {
      return "Age must be greater than 0";
    }

    if (age > 120) {
      return "Please enter a realistic age";
    }

    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Address is required";
    }
    if (value.trim().length < 5) {
      return "Address must be at least 5 characters";
    }
    return null; // ✅ مفيش خطأ
  }

  static String? validateRequestReason(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      if (value.length < 10) {
        return AppStrings.reasonNotValid;
      } else {
        return null;
      }
    } else {
      return "textFieldIsRequired".ts;
    }
  }

  static String? validatePickedFile(UploadFile? value) {
    // Check file size not more than 4MB
    if (value == null || value.size <= 4096) {
      return null;
    } else {
      return AppStrings.fileSizeLimit;
    }
  }

  static String? validateNumber(String? value) {
    // Check file size not more than 4MB
    if (value != null && value.trim().isNotEmpty) {
      final parsed = double.tryParse(value) ?? 0;
      if (parsed == 0 || parsed < 0) {
        return AppStrings.amountisNotValid;
      } else {
        return null;
      }
    } else {
      return "textFieldIsRequired".ts;
    }
  }
}

//------------------------------------------------------------------------------

bool validateAndSaveFormState(GlobalKey<FormState> key) {
  var state = key.currentState;
  //
  if (state != null) {
    if (state.validate()) {
      state.save();
      return true;
    } else {
      // Change Form widget AutoValidate option to user interaction
      return false;
    }
  }
  return false;
}
