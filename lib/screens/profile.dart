import 'dart:ui';

import 'package:argon_flutter/constants/Image_url.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/constants/app_constants.dart';
import 'package:argon_flutter/model/view/user_info.model.dart';
import 'package:argon_flutter/screens/widget/profile/group-list-x.widget.dart';
import 'package:argon_flutter/screens/widget/profile/summary-today.widget.dart';
import 'package:argon_flutter/screens/widget/profile/user-info.widget.dart';
import 'package:argon_flutter/service/helper/http.helper.dart';
import 'package:argon_flutter/widgets/base-menu.dart';
import 'package:argon_flutter/widgets/base.widget.dart';
//widgets
import 'package:argon_flutter/widgets/navibar.dart';
import 'package:argon_flutter/widgets/profile-divider.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

// 메인화면
class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final url = '${HttpHelper.endpoint}/api/v1/files'; // TODO : url check

    return BaseWidget<UserInfoModel>(
        model: UserInfoModel(
            api: Provider.of(context),
            authService: Provider.of(context),
            jwtHelper: Provider.of(context)),
        onModelReady: (model) => model.loadUserProfile(_scaffoldKey, context),
        builder: (context, model, child) => Scaffold(
            extendBodyBehindAppBar: true,
            appBar: Navibar(
              rightOptions: true,
              settingOptions: true,
              settingOnTap: () {
                Navigator.pushNamed(context, RoutePaths.Setting);
              },
              alertOptions: true,
              alertOnTap: () {
                print(' >>> alertOnTap');
              },
            ),
            backgroundColor: ArgonColors.bgColorScreen,
            drawer: BaseMenu(currentPage: "Profile"),
            body: Stack(children: <Widget>[
              // background
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.topCenter,
                          image: AssetImage(ImageUrl.profileScreenBg),
                          fit: BoxFit.fitWidth))),
              // background

              SafeArea(
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 90.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(children: <Widget>[
                          Container(
                            // 뒷 박스
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
                            // 뒷 박스

                            // 정보영역
                            child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: .0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 25,
                                      left: 25,
                                      top: 85.0,
                                      bottom: 20.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            UserInfoWidget(
                                              userInfoDto: model.userInfoDto,
                                            ), // 사용자 정보
                                            ProfileDividerWidget(),
                                            GroupListXWidget(
                                              jwtToken: model.jwtToken,
                                            ), // 그룹리스트
                                            ProfileDividerWidget(),
                                            SummaryTodayWidget() // 오늘의 목표
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            // 정보영역
                          ),

                          // 사용자 사진
                          FractionalTranslation(
                              translation: Offset(0.0, -0.5),
                              child: Align(
                                child: CircleAvatar(
                                  backgroundImage: model
                                              .userInfoDto?.profileImageUrl !=
                                          null
                                      ? NetworkImage(
                                          '$url/${model.userInfoDto.profileImageUrl.fileId ?? 0}',
                                          headers: {
                                              'Accept': '*/*',
                                              'Authorization':
                                                  ' Bearer ${model.jwtToken}'
                                            })
                                      : AssetImage(
                                          ImageUrl.profileScreenAvatar),
                                  radius: 85.0,
                                  // maxRadius: 200.0,
                                ),
                                alignment: FractionalOffset(0.5, 0.0),
                              ))
                          // 사용자 사진
                        ]),
                      ],
                    ),
                  ),
                ]),
              )
            ])));
  }
}
