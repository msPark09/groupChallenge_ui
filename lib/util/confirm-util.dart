import 'package:argon_flutter/constants/Theme.dart';
import 'package:flutter/material.dart';

class ConfirmUtil {
  final context;
  final Color mainColor;
  final String title;
  final String message;
  ConfirmUtil({this.context, this.mainColor, this.title, this.message});

  static Future<bool> confirmSave(ConfirmUtil confirm) async {
    return showDialog<bool>(
        context: confirm.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: ArgonColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              title: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        confirm.title ?? '저장 확인',
                        style: TextStyle(
                          color: confirm.mainColor ?? ArgonColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      confirm.message ?? "저장하시겠습니까?",
                      style: TextStyle(
                          color: (confirm.mainColor ?? ArgonColors.primary)
                              .withOpacity(.4)),
                    ),
                  ]),
              actions: <Widget>[
                TextButton.icon(
                  style: TextButton.styleFrom(
                      backgroundColor:
                          (confirm.mainColor ?? ArgonColors.primary)
                              .withOpacity(.1),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0))),
                  icon: Icon(
                    Icons.clear,
                    color: (confirm.mainColor ?? ArgonColors.primary)
                        .withOpacity(.4),
                  ),
                  label: Text(
                    '취소',
                    style: TextStyle(
                        color: confirm.mainColor ?? ArgonColors.primary),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                      backgroundColor:
                          (confirm.mainColor ?? ArgonColors.primary)
                              .withOpacity(.1),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0))),
                  icon: Icon(
                    Icons.check,
                    color: (confirm.mainColor ?? ArgonColors.primary)
                        .withOpacity(.4),
                  ),
                  label: Text(
                    '확인',
                    style: TextStyle(
                        color: confirm.mainColor ?? ArgonColors.primary),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ]);
        });
  }
}
