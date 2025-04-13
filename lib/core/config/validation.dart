import 'package:tasks_joddb/core/navigation/custom_navigation.dart';

import 'app_localization.dart';

class AppValidation {
  static String? isEmail(String email) {
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regExp = RegExp(p);
    if (email.isEmpty) {
      return AppLocalization.of(currentContext!).getTranslatedValues("validation_please_enter_your_email");
    } else if (!regExp.hasMatch(email)) {
      return AppLocalization.of(currentContext!).getTranslatedValues("validation_please_enter_valid_email");
    }
    return null;
  }

  static String? isPassword(String password) {
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\+/\\\$%^&*(),.?":{}|<>~\-\_]).{8,}$'; //(?=.*?[!@#\$&*~-])
    RegExp regExp = RegExp(p);
    if (password.isEmpty) {
      return AppLocalization.of(currentContext!).getTranslatedValues("validation_please_enter_password");
    } else if (!regExp.hasMatch(password)) {
      return AppLocalization.of(currentContext!).getTranslatedValues("validation_please_enter_valid_password");
    }
    return null;
  }

  static String? isConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return AppLocalization.of(currentContext!).getTranslatedValues("validation_please_enter_confirm_password");
    } else if (password != confirmPassword) {
      return AppLocalization.of(currentContext!).getTranslatedValues("validation_password_does_not_match");
    }
    return null;
  }

  static String? isValid(String value) {
    if (value.isEmpty) {
      return AppLocalization.of(currentContext!).getTranslatedValues("validation_this_field_is_required");
    }
    return null;
  }
}
