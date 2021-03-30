import 'dart:ui';

import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/model/view/user_info.model.dart';
import 'package:argon_flutter/screens/widget/group-list-x.widget.dart';
import 'package:argon_flutter/screens/widget/summary-today.widget.dart';
import 'package:argon_flutter/screens/widget/user-info.widget.dart';
import 'package:argon_flutter/widgets/base.widget.dart';
import 'package:argon_flutter/widgets/drawer.dart';
//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/profile-divider.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ProfileDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return BaseWidget<UserInfoModel>(
        model: UserInfoModel(
            api: Provider.of(context),
            authService: Provider.of(context),
            jwtHelper: Provider.of(context)),
        onModelReady: (model) => model.loadUserInfo(_scaffoldKey),
        builder: (context, model, child) => Scaffold(
            extendBodyBehindAppBar: true,
            appBar: Navbar(
              title: "Profile",
              transparent: true,
              backButton: true,
            ),
            backgroundColor: ArgonColors.bgColorScreen,
            body: Stack(children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.topCenter,
                          image: AssetImage("assets/img/profile-screen-bg.png"),
                          fit: BoxFit.fitWidth))),
              SafeArea(
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 74.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: .0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 85.0, bottom: 20.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            UserInfoWidget(
                                              editable: true,
                                            ),
                                            ProfileDividerWidget(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ]),
              )
            ])));
  }
}
