import 'package:argon_flutter/constants/Theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupListXWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(right: 25.0, left: 25.0),
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
          ],
        ),
      ),
      SizedBox(
        height: 130,
        child: GridView.count(
            primary: false,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
            crossAxisSpacing: 10,
            crossAxisCount: 1,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 35,
                  ),
                  Text("Now",
                      style: TextStyle(
                          color: Color.fromRGBO(50, 50, 93, 1), fontSize: 12.0))
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.pink,
                    radius: 35,
                  ),
                  Text("Now",
                      style: TextStyle(
                          color: Color.fromRGBO(50, 50, 93, 1), fontSize: 12.0))
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 35,
                  ),
                  Text("Now",
                      style: TextStyle(
                          color: Color.fromRGBO(50, 50, 93, 1), fontSize: 12.0))
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    radius: 35,
                  ),
                  Text("Now",
                      style: TextStyle(
                          color: Color.fromRGBO(50, 50, 93, 1), fontSize: 12.0))
                ],
              ),
            ]),
      )
    ]);
  }
}
