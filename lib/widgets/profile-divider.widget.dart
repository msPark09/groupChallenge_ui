import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileDividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Divider(
          height: 20.0,
          thickness: 1.5,
          indent: 32.0,
          endIndent: 32.0,
        ),
        SizedBox(height: 15.0),
      ],
    );
  }
}
