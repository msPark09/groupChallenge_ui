import 'package:argon_flutter/constants/app_constants.dart';
import 'package:argon_flutter/screens/login.dart';
import 'package:argon_flutter/screens/profile.dart';
import 'package:argon_flutter/screens/register-user.dart';
import 'package:argon_flutter/screens/splash.dart';
import 'package:argon_flutter/screens/user-edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Profile:
        return MaterialPageRoute(builder: (_) => Profile());
      case RoutePaths.Splash:
        return MaterialPageRoute(builder: (_) => Splash());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => Login(), maintainState: true);
      case RoutePaths.RegisterUser:
        return MaterialPageRoute(
            builder: (_) => RegisterUser(), maintainState: true);
      case RoutePaths.Setting:
        return MaterialPageRoute(
            builder: (_) => UserEdit(), maintainState: true);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('${settings.name} : 라우트 정의가 존재하지 않음 '),
                  ),
                ));
    }
  }
}
