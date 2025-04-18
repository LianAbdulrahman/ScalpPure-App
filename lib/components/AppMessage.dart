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
}
