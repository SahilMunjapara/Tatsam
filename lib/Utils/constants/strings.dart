class Strings {
  static const String appName = 'TATSAM';
  static const String fontFamily = 'AlegreyaSans';
  static const String secondFontFamily = 'JosefinSans';
  static const String login = 'Login';
  static const String logout = 'Logout';
  static const String signup = 'Sign Up';
  static const String newUser = 'New User? ';
  static const String mobileNo = 'Mobile No.';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String name = 'Name';
  static const String sign = 'Sign';
  static const String up = 'Up';
  static const String phoneCode = '+91 ';
  static const String otpScreenDetail =
      'We sent otp code to verify your number';
  static const String resendOtp = 'Resend Otp';
  static const String verify = 'Verify';
  static const String profile = 'Profile';
  static const String businessScreenHeader = 'Business Page';
  static const String contactsScreenHeader = 'Contacts';
  static const String businessFormScreenHeader = 'Business Form';
  static const String businessFormEditScreenHeader = 'Business Edit';
  static const String businessType = 'Business Type';
  static const String uploadLogo = 'Upload a logo';
  static const String utilitiesScreenHeader = 'Utilities';
  static const String instantScreenHeader = 'Instant';
  static const String resendOtpDetail = 'Resend Otp in ';
  static const String twoMinute = '2:00';
  static const String fullName = 'Full Name :';
  static const String contactNum = 'Contact Num:';
  static const String emailId = 'Email :';
  static const String nameHint = 'Type Name...';
  static const String workNameHint = 'Type Work Name...';
  static const String contactHint = 'Type Contact Number...';
  static const String emailHint = 'xyz@gmail.com';
  static const String backToLogin = 'Back To Login';
  static const String workName = 'Work Name';
  static const String submit = 'Submit';
  static const String urgentHelp = 'Urgent Help';
  static const String selectPlus = 'Select  +';
  static const String send = 'Send ➜';
  static const String drawerHome = 'Home';
  static const String drawerContacts = 'Contacts';
  static const String drawerBusiness = 'Business';
  static const String drawerUtilities = 'Utilites';
  static const String drawerInstant = 'Instant';
  static const String drawerNotification = 'Notification';
  static const String drawerLogout = 'Log out';
  static const String sessionExpireTitle = 'Whoops, Your session has expired';
  static const String sessionExpireSubtitle =
      'Your session has expired due to your inactivity. No worry, simply login again';
  static const String logoutSubtitle = 'Are you sure, do you want to logout?';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String update = 'Update';
  static const String instantDeleteMsg = 'Instant Deleted Successfully';
  static const String only5InstnatAllow = 'You can add only 5 Instant';
  static const String alreadySelected =
      'You Already Select this instant select another Instant';
  static const String instantSuccessMSGSend = 'Message Send To Instants.';
  static const String instantErrorSms =
      'Somthing Went Wrong Please Send SMS Again.';
  static const String architecture = 'Architecture';
  static const String doctor = 'Doctor';
  static const String plumber = 'Plumber';
  static const String ui = 'Ui';

  /// Message For Instant That Send By User Change SMS text here
  static const String instantMSG = 'This is tatsam testing sms';
}

class ValidatorString {
  static const String allFieldRequired = 'All fields are must be required.';
  static const String mobileRequire = 'Please Enter Mobilenumber';
  static const String validName = 'Enter valid Name.';
  static const String validMobile = 'Enter valid MobileNumber.';
  static const String validEmail = 'Enter valid Email.';
  static const String validPassword =
      'Enter valid Password.(Password must contain capital alphabets, digit and special character)';
  static const String otpRequired = 'Otp is required.';
  static const String validOtp = 'Enter Valid Otp.';
  static const String validWorkName = 'Enter valid Workname.';
  static const String businessImageRequired = 'Business Image Required.';
  static const String smsPermissionRequired = 'SMS Permission Required.';
  static const String alreadyBusinessTypeSelected =
      'Business Type Already Selected';
}

class FirebaseCollectionString {
  static const String users = 'Users';
}

class FirebaseErrorCodeString {
  static const String sessionExpired = 'session-expired';
  static const String invalidCode = 'invalid-verification-code';
  static const String networkFailed = 'network-request-failed';
}

class FirebaseErrorMessageString {
  static const String otpExpired = 'Otp Expired, Resend Otp.';
  static const String otpMismatch = 'Otp Mismatch, Enter Correct Otp.';
  static const String noInternet = 'No Internet Connection Available';
}

class ResponseString {
  static const String unauthorized = 'Unauthorized';
}

class StringDigits {
  static const String one = '1';
  static const String two = '2';
  static const String three = '3';
  static const String four = '4';
}

List<String> businessTypeList = [
  Strings.architecture,
  Strings.doctor,
  Strings.plumber,
  Strings.ui,
];
