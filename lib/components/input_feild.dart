import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_input_feild_container.dart';
import 'package:flutter_auth/constants.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const InputField({
    Key key,
    this.hintText,
    this.labelText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextInputFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
