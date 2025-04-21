class AppMessage {
  static String successfulRequest = 'successful';
  static String unAuthorized = 'unAuthorized';
  static String serverExceptions = 'serverExceptions';
  static String socketException = 'socketException';
  static String timeoutException = 'timeoutException';
  static String formatException = 'formatException';
  static String initial = 'initial';
  static String loading = 'loading';
  static String loadingMore = 'loading more';
  static String loaded = 'loaded';

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static Map<String, String> headersWithToken({required String? token}) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
  static Map<String, String> headersMultiFile({required String? token}) => {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
  static String appName = 'Scalp Pure';
  static String productDetailsTitle = 'Scalp Building up Chemicals';
  static String mainTitle = 'Make right choices for your hair health!';

  static String signUpEmail = 'Sign up with email';
  static String signUpGoogle = 'Sign up with Google';
  static String youHaveAccount = 'You already have account?';
  static String login = ' LogIn';
  static String logInEmail = 'LogIn with email';
  static String logInGoogle = 'Continue with Google';
  static String youDoNotHaveAccount = 'You do not have account?';
  static String signUp = ' SignUp';
  static String noChemicals = 'No Building up Chemicals ';
  static String permission = 'Permission';
  static String cameraPermission =
      "please enable camera permission to continue";
  static String storagePermission =
      "please enable storage permission to continue";
  static String photoPermission = "please enable photo permission to continue";
  static String tryAgain = 'something went wrong please try again later';
  static String allowedExtensions = ' image allowed extensions are png or jpg';
  static String editPhoto = 'Edit Photo';
  static String mandatoryTx = 'required field';
  static String invalidEmail = 'email is invalid';
}
