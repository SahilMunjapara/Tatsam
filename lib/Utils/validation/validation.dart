class Validator {
  static String? nameValidationMsg(String? username) {
    if (username?.isEmpty ?? true) {
      return "Name is required";
    } else if (!validCharacters.hasMatch(username!)) {
      return "Special Characters are not allowed";
    } else {
      return null;
    }
  }

  static String? mobileValidationMsg(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if ((value?.length ?? 0) == 0) {
      return 'Please enter mobile number';
    } else if (value!.length > 10) {
      return 'Mobile Number must be of 10 digit';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static String? emailValidationMsg(String? email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (email == null || email.isEmpty) {
      return "Email is required";
    } else if (!regex.hasMatch(email)) {
      return "Please provide a valid email";
    } else {
      return null;
    }
  }

  static final validCharacters = RegExp(r'^[a-zA-Z0-9 \-,\.]+$');

  static final validOtp = RegExp('^([0-9]{6})\$');

  static final RegExp emailCharacter = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static final RegExp mobileCharacter = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  static final RegExp passwordCharacter =
      RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)');
}
