import 'package:flutter/material.dart';

import '../../../constants.dart';

class Menu extends StatelessWidget {
  final String text;
  final bool hasNavigation;

  const Menu({
    Key key,
    this.text,
    this.press,
    this.hasNavigation = true,
  }) : super(key: key);

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: kPrimaryColor,
        // padding: EdgeInsets.all(20),
      ),
      onPressed: press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(width: 20),
          Expanded(child: Text(text)),
          this.hasNavigation?
          Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ):Container()
        ],
      ),
    );
  }
}
