import 'package:argon_flutter/constants/app_constants.dart';
import 'package:argon_flutter/service/api.dart';
import 'package:argon_flutter/service/auth.service.dart';
import 'package:argon_flutter/service/helper/jwt.helper.dart';
import 'package:argon_flutter/util/myrouter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        // https://pub.dev/packages/provider 3.x => 4.x migration 참조
        providers: [
          Provider<Api>(create: (context) => Api()),
          Provider<JwtHelper>(create: (context) => JwtHelper()),
          // Provider<NavService>(create: (context) => NavService()),
          // Provider<PackageService>(create: (context) => PackageService()),
          // Provider<DeviceService>(create: (context) => DeviceService()),
          ProxyProvider<Api, AuthService>(
            update: (context, api, authService) => AuthService(api: api),
          )
        ],
        child: MaterialApp(
          title: '모두함께다이어트',
          theme: ThemeData(fontFamily: 'OpenSans'),
          debugShowCheckedModeBanner: false,
          initialRoute: RoutePaths.Splash,
          onGenerateRoute: MyRouter.generateRouter,
        ));
  }
}
