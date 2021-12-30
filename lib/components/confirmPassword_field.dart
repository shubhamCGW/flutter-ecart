import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_input_feild_container.dart';
import 'package:flutter_auth/constants.dart';

class ConfirmPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String text;
  final String labelText;
  const ConfirmPasswordField({
    Key key,
    @required this.text,
    this.labelText,
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
          hintText: text,
          labelText: labelText,
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
