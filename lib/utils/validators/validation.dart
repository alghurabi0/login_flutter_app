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

  static String? validateIraqiPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى ادخال رقم الهاتف';
    }

    // Check if the phone number matches the required format
    final iraqiPhoneRegex = RegExp(r'^009647\d{8}$');
    if (!iraqiPhoneRegex.hasMatch(value)) {
      return 'رقم الهاتف غير صحيح، يجب ان يكون بالصيغة 009647XXXXXXXX';
    }

    return null;
  }
}
