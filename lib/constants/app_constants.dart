class AppSettings {
  static const int TimeOutDuration = 5; // 5초
  static const int SnackBarDuration = 1; // 1초
  static const int SnackBarDuration4Login = 3; // 3초
  static const int SnackBarDurationMil = 1000; // 1초 (milliseconds)
}

class RoutePaths {
  static const String Splash = 'splash';
  static const String Login = 'login';
  static const String Profile = '/';
  static const String Register = 'register';
  static const String Setting = 'setting';
}

class HttpStatus {
  static const int Success = 200;
  static const int UnAuthorized = 401;
  static const int NotFound = 404;
  static const int TimeOut = 408;
  static const int ServerError = 500;
}
