import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_input_feild_container.dart';
import 'package:flutter_auth/constants.dart';

class PasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const PasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return TextInputFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}