import 'dart:ui';

import 'package:argon_flutter/constants/Image_url.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/model/dto/group.dto.dart';
import 'package:argon_flutter/model/view/group-list.model.dart';
import 'package:argon_flutter/service/helper/http.helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';

class GroupListXWidget extends StatelessWidget {
  final String jwtToken;

  GroupListXWidget({this.jwtToken});

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final url = '${HttpHelper.endpoint}/api/v1/files'; // TODO : url check

    GroupListModel model = GroupListModel(
        api: Provider.of(context), authService: Provider.of(context));

    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(right: 1.0, left: 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Group",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: ArgonColors.text),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
              iconSize: 20,
            )
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
          height: 130,
          child: PagewiseGridView<GroupDto>.count(
              pageSize: model.PAGE_SIZE,
              crossAxisSpacing: 1,
              crossAxisCount: 1,
              scrollDirection: Axis.horizontal,
              retryBuilder: (context, retryCallback) =>
                  SizedBox.fromSize(), // retry 없음으로 처리
              itemBuilder: (context, item, i) {
                return Column(
                  children: [
                    GestureDetector(
                      // 이벤트 걸어주는 widget
                      onTap: () {
                        print(' >>> ${item.groupId}');
                      },
                      child: CircleAvatar(
                        backgroundImage: item.mainPhoto != null
                            ? NetworkImage('$url/${item.mainPhoto.fileId ?? 0}',
                                headers: {
                                    'Accept': '*/*',
                                    'Authorization': ' Bearer ${this.jwtToken}'
                                  })
                            : AssetImage(ImageUrl.proBackground),
                        radius: 40,
                      ),
                    ),
                    Text(item.name ?? '',
                        style: TextStyle(
                            color: Color.fromRGBO(50, 50, 93, 1),
                            fontSize: 16.0))
                  ],
                );
              },
              pageFuture: (pageIndex) async => await model.searchGroupList(
                  pageIndex, _scaffoldKey, context)))
    ]);
  }
}
