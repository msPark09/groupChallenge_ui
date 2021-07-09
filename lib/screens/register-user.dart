import 'dart:ui';

import 'package:argon_flutter/constants/Image_url.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/constants/app_constants.dart';
import 'package:argon_flutter/util/confirm-util.dart';
import 'package:argon_flutter/widgets/base-input.dart';
import 'package:argon_flutter/widgets/base-text-button.dart';
//widgets
import 'package:argon_flutter/widgets/navibar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/Theme.dart';
import '../model/dto/user_info.dto.dart';
import '../model/view/user_info.model.dart';
import '../widgets/base.widget.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  bool _isObscure = true;

  final double height = window.physicalSize.height;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _sayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return BaseWidget<UserInfoModel>(
        model: UserInfoModel(
          api: Provider.of(context),
          authService: Provider.of(context),
          jwtHelper: Provider.of(context),
        ),
        onModelReady: (model) => model.userInfoDto = new UserInfoDto(),
        builder: (context, model, child) {
          return Scaffold(
              appBar: Navibar(
                rightOptions: false,
                backButton: true,
              ),
              extendBodyBehindAppBar: true, // body 위에 appbar
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 24.0, right: 24.0, bottom: 32),
                        child: Card(
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
                                          child: Text("Sign up",
                                              style: TextStyle(
                                                  color: ArgonColors.text,
                                                  fontSize: 16.0)),
                                        )),
                                      ],
                                    )),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.63,
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
                                                    placeholder: "Email",
                                                    controller:
                                                        _emailController,
                                                    onChanged: (email) => model
                                                        .userInfoDto
                                                        .email = email,
                                                    errorText:
                                                        model.errorEmailText,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: BaseInput(
                                                    obscure: _isObscure,
                                                    placeholder: "Password",
                                                    controller:
                                                        _passwordController,
                                                    onChanged: (password) =>
                                                        model.userInfoDto
                                                                .password =
                                                            password,
                                                    errorText:
                                                        model.errorPasswordText,
                                                    suffixIcon: IconButton(
                                                        icon: Icon(_isObscure
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off),
                                                        onPressed: () {
                                                          setState(() {
                                                            _isObscure =
                                                                !_isObscure;
                                                          });
                                                        }),
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: BaseInput(
                                                      placeholder: "Name",
                                                      controller:
                                                          _usernameController,
                                                      onChanged: (userName) =>
                                                          model.userInfoDto
                                                                  .userName =
                                                              userName,
                                                      errorText: model
                                                          .errorUsernameText,
                                                    )),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: BaseInput(
                                                      placeholder: "자기소개",
                                                      controller:
                                                          _sayController,
                                                      onChanged: (sayWord) =>
                                                          model.userInfoDto
                                                                  .sayWord =
                                                              sayWord,
                                                    )),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16, bottom: 16),
                                              child: Center(
                                                child: BaseTextButton(
                                                  buttonLabel: "가입",
                                                  onPressed: () async {
                                                    var isValid =
                                                        await model.validate();
                                                    if (isValid) {
                                                      var confirm = await ConfirmUtil
                                                          .confirmSave(ConfirmUtil(
                                                              context: context,
                                                              title: "회원가입",
                                                              message:
                                                                  "회원가입 하시겠습니까?"));
                                                      if (confirm) {
                                                        var result = await model
                                                            .saveUser(
                                                                _scaffoldKey,
                                                                context);
                                                        if (result) {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  RoutePaths
                                                                      .Login);
                                                        }
                                                      }
                                                    }
                                                  },
                                                  backgroundColor:
                                                      ArgonColors.primary,
                                                  textColor: ArgonColors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            )),
                      ),
                    ]),
                  )
                ],
              ));
        });
  }
}
