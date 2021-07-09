import 'dart:ui';

import 'package:argon_flutter/constants/Image_url.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/constants/app_constants.dart';
import 'package:argon_flutter/model/view/auth.model.dart';
import 'package:argon_flutter/widgets/base-input.dart';
import 'package:argon_flutter/widgets/base-text-button.dart';
import 'package:argon_flutter/widgets/base.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final double height = window.physicalSize.height;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AuthModel>(
        model: AuthModel(
          authService: Provider.of(context),
          jwtHelper: Provider.of(context),
        ),
        onModelReady: (model) => model.loadUsernameAndExtraInfo(context),
        builder: (context, model, child) {
          if (!model.busy &&
              model.username != null &&
              _emailController.text.isEmpty) {
            _emailController.text = model.username;
          }
          return Scaffold(
              body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageUrl.registerBg),
                        fit: BoxFit.cover)),
              ),
              SafeArea(
                child: ListView(children: [
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 24.0, right: 24.0, bottom: 32),
                    child: model.busy
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                                CircularProgressIndicator(
                                  strokeWidth:
                                      MediaQuery.of(context).size.width * 0.025,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white70),
                                ),
                              ])
                        : Card(
                            elevation: 5,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    decoration: BoxDecoration(
                                        color: ArgonColors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.5,
                                                color: ArgonColors.muted))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Center(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text("Login",
                                              style: TextStyle(
                                                  color: ArgonColors.text,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0)),
                                        )), // Divider()
                                      ],
                                    )),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.53,
                                    color: Color.fromRGBO(244, 245, 247, 1),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: BaseInput(
                                                      controller:
                                                          _emailController,
                                                      placeholder: "Email",
                                                      prefixIcon:
                                                          Icon(Icons.email)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: BaseInput(
                                                      controller:
                                                          _passwordController,
                                                      placeholder: "Password",
                                                      prefixIcon:
                                                          Icon(Icons.lock)),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Center(
                                                  child: Column(
                                                children: [
                                                  BaseTextButton(
                                                    buttonLabel: "LOGIN",
                                                    onPressed: () async {
                                                      var loginSuccess =
                                                          await model.login(
                                                              _emailController
                                                                  .text,
                                                              _passwordController
                                                                  .text,
                                                              _scaffoldKey,
                                                              context);
                                                      if (loginSuccess) {
                                                        Navigator.of(context)
                                                            .pushNamedAndRemoveUntil(
                                                                RoutePaths
                                                                    .Profile,
                                                                (Route<dynamic>
                                                                        route) =>
                                                                    false);
                                                        print(
                                                            '[$runtimeType] : Login success');
                                                      } else {
                                                        print(
                                                            '[$runtimeType] : Login failed');
                                                      }
                                                    },
                                                    backgroundColor:
                                                        ArgonColors.primary,
                                                    textColor:
                                                        ArgonColors.white,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextButton(
                                                          child: Text("회원가입"),
                                                          onPressed: () => {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    RoutePaths
                                                                        .RegisterUser)
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("|"),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        TextButton(
                                                          child: Text("계정찾기"),
                                                          onPressed: () => {},
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            )),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ]),
              )
            ],
          ));
        });
  }
}
