import 'dart:ui';

import 'package:argon_flutter/model/view/auth.model.dart';
import 'package:argon_flutter/widgets/base.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: BaseWidget<AuthModel>(
              model: AuthModel(
                  jwtHelper: Provider.of(context),
                  authService: Provider.of(context)),
              onModelReady: (model) => model.loggedIn(context, _scaffoldKey),
              builder: (context, model, child) => Stack(children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/img/onboard-background.png"),
                                fit: BoxFit.cover))),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 73, left: 32, right: 32, bottom: 16),
                      child: Container(
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 48.0),
                                    child: Text.rich(TextSpan(
                                      text: "Design System",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 58,
                                          fontWeight: FontWeight.w600),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 24.0),
                                    child: Text(
                                        "Fully coded Flutter widgets and screens.",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w200)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ])),
        ));
  }
}
