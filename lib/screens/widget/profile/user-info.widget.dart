import 'package:argon_flutter/model/dto/user_info.dto.dart';
import 'package:argon_flutter/model/view/group.model.dart';
import 'package:argon_flutter/widgets/base.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoWidget extends StatelessWidget {
  final UserInfoDto userInfoDto;

  UserInfoWidget({this.userInfoDto});

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return BaseWidget<GroupModel>(
        model: GroupModel(
          api: Provider.of(context),
          authService: Provider.of(context),
        ),
        onModelReady: (model) => model.getMainGroupInfo(_scaffoldKey, context),
        builder: (context, model, child) => Column(
              children: [
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 10, 0),
                      child: Icon(Icons.emoji_events),
                    ),
                    Text(model.groupDto?.name ?? '메인그룹을 설정하세요.',
                        style: TextStyle(
                            color: Color.fromRGBO(82, 95, 127, 1),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(model.groupDto?.nowGoal?.now ?? '-',
                            style: TextStyle(
                                color: Color.fromRGBO(82, 95, 127, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        Text("Now",
                            style: TextStyle(
                                color: Color.fromRGBO(50, 50, 93, 1),
                                fontSize: 12.0))
                      ],
                    ),
                    Column(
                      children: [
                        Text(model.groupDto?.nowGoal?.goal ?? '-',
                            style: TextStyle(
                                color: Color.fromRGBO(82, 95, 127, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        Text("Goal",
                            style: TextStyle(
                                color: Color.fromRGBO(50, 50, 93, 1),
                                fontSize: 12.0))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                            '${(model.groupDto?.nowGoal?.goal ?? 0) - (model.groupDto?.nowGoal?.now ?? 0)}',
                            style: TextStyle(
                                color: Color.fromRGBO(82, 95, 127, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        Text("Fighting",
                            style: TextStyle(
                                color: Color.fromRGBO(50, 50, 93, 1),
                                fontSize: 12.0))
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Align(
                  child: Text(userInfoDto?.userName ?? 'Bubyabya',
                      style: TextStyle(
                          color: Color.fromRGBO(50, 50, 93, 1),
                          fontSize: 28.0)),
                ),
                SizedBox(height: 10.0),
                Align(
                  child: Text(userInfoDto?.sayWord ?? 'I can do it! I got it!',
                      style: TextStyle(
                          color: Color.fromRGBO(50, 50, 93, 1),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w200)),
                ),
                SizedBox(height: 10.0),
              ],
            ));
  }
}
