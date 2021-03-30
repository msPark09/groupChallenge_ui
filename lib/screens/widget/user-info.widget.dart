import 'package:argon_flutter/widgets/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final bool editable;
  final bool edit = false;
  UserInfoWidget({this.editable});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            child: ElevatedButton(
          onPressed: () => {},
          child: Icon(Icons.edit),
        )),
        Align(
          child: this.edit
              ? Input()
              : Text("Jessica Jones, 27",
                  style: TextStyle(
                      color: Color.fromRGBO(50, 50, 93, 1), fontSize: 28.0)),
        ),
        SizedBox(height: 10.0),
        Align(
          child: Text("San Francisco, USA",
              style: TextStyle(
                  color: Color.fromRGBO(50, 50, 93, 1),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w200)),
        ),
        SizedBox(height: 40.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text("2K",
                    style: TextStyle(
                        color: Color.fromRGBO(82, 95, 127, 1),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                Text("Now",
                    style: TextStyle(
                        color: Color.fromRGBO(50, 50, 93, 1), fontSize: 12.0))
              ],
            ),
            Column(
              children: [
                Text("10",
                    style: TextStyle(
                        color: Color.fromRGBO(82, 95, 127, 1),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                Text("Goal",
                    style: TextStyle(
                        color: Color.fromRGBO(50, 50, 93, 1), fontSize: 12.0))
              ],
            ),
            Column(
              children: [
                Text("89",
                    style: TextStyle(
                        color: Color.fromRGBO(82, 95, 127, 1),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                Text("Fighting",
                    style: TextStyle(
                        color: Color.fromRGBO(50, 50, 93, 1), fontSize: 12.0))
              ],
            )
          ],
        ),
      ],
    );
  }
}
