import 'package:argon_flutter/constants/Theme.dart';
import 'package:flutter/material.dart';

class Navibar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;

  final bool transparent; // 메뉴 변경
  final bool noShadow;

  final bool rightOptions; // 오른쪽 옵션
  final bool settingOptions; // 셋팅
  final bool alertOptions; // 알림
  final bool editOptions; // 수정
  final bool deleteOptions; // 삭제

  final Function settingOnTap;
  final Function alertOnTap;
  final Function editOnTap;
  final Function deleteOnTap;

  final Function getCurrentPage;
  final Color bgColor;

  Navibar({
    this.title = "",
    this.backButton = false,
    this.transparent = true,
    this.noShadow = false,
    this.rightOptions = false,
    this.settingOptions = false,
    this.alertOptions = false,
    this.editOptions = false,
    this.deleteOptions = false,
    this.settingOnTap,
    this.alertOnTap,
    this.editOnTap,
    this.deleteOnTap,
    this.getCurrentPage,
    this.bgColor = ArgonColors.white,
  });

  final double _prefferedHeight = 180.0;

  @override
  _NavibarState createState() => _NavibarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavibarState extends State<Navibar> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 102.0,
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? ArgonColors.initial
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: Offset(0, 5))
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                                !widget.backButton
                                    ? Icons.menu
                                    : Icons.arrow_back_ios,
                                color: !widget.transparent
                                    ? (widget.bgColor == ArgonColors.white
                                        ? ArgonColors.initial
                                        : ArgonColors.white)
                                    : ArgonColors.white,
                                size: 24.0),
                            onPressed: () {
                              if (!widget.backButton)
                                Scaffold.of(context).openDrawer();
                              else
                                Navigator.pop(context);
                            }),
                        Text(widget.title,
                            style: TextStyle(
                                color: !widget.transparent
                                    ? (widget.bgColor == ArgonColors.white
                                        ? ArgonColors.initial
                                        : ArgonColors.white)
                                    : ArgonColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0)),
                      ],
                    ),
                    if (widget.rightOptions)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          widget.alertOptions
                              ? GestureDetector(
                                  onTap: widget.alertOnTap,
                                  child: IconButton(
                                      icon: Icon(Icons.notifications,
                                          color: !widget.transparent
                                              ? (widget.bgColor ==
                                                      ArgonColors.white
                                                  ? ArgonColors.initial
                                                  : ArgonColors.white)
                                              : ArgonColors.white,
                                          size: 25.0),
                                      onPressed: null))
                              : SizedBox(), // 빈공간으로 설정
                          widget.settingOptions
                              ? GestureDetector(
                                  onTap: widget.settingOnTap,
                                  child: IconButton(
                                      icon: Icon(Icons.settings,
                                          color: !widget.transparent
                                              ? (widget.bgColor ==
                                                      ArgonColors.white
                                                  ? ArgonColors.initial
                                                  : ArgonColors.white)
                                              : ArgonColors.white,
                                          size: 25.0),
                                      onPressed: null))
                              : SizedBox(), // 빈공간으로 설정
                          widget.editOptions
                              ? GestureDetector(
                                  onTap: widget.editOnTap,
                                  child: IconButton(
                                      icon: Icon(Icons.edit,
                                          color: !widget.transparent
                                              ? (widget.bgColor ==
                                                      ArgonColors.white
                                                  ? ArgonColors.initial
                                                  : ArgonColors.white)
                                              : ArgonColors.white,
                                          size: 25.0),
                                      onPressed: null))
                              : SizedBox(), // 빈공간으로 설정
                          widget.deleteOptions
                              ? GestureDetector(
                                  onTap: widget.deleteOnTap,
                                  child: IconButton(
                                      icon: Icon(Icons.settings,
                                          color: !widget.transparent
                                              ? (widget.bgColor ==
                                                      ArgonColors.white
                                                  ? ArgonColors.initial
                                                  : ArgonColors.white)
                                              : ArgonColors.white,
                                          size: 25.0),
                                      onPressed: null))
                              : SizedBox(), // 빈공간으로 설정
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
