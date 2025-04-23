class TValidator {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "يرجى ادخال اسم المستخدم";
    }

    if (value.length < 3) {
      return "يجب ان يكون اسم المستخدن 3 حروف على الاقل";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى ادخال الرمز السري';
    }

    // Check for minimum password length
    if (value.length < 3) {
      return 'يجب ان يكون الرمز السري 3 حروف على الاقل';
    }
    return null;
  }
}
