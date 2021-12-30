import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

class RoundedConfirmPasswordField extends StatelessWidget {
  final ValueChanged<String> onSaved;
  final String Function(String) validator;
  final TextEditingController controller;
  final String text;
  final String labelText;
  const RoundedConfirmPasswordField({
    Key key,
    @required this.text,
    this.validator,
    this.controller,
    this.labelText,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        controller: controller,
        validator: validator,
        onSaved: onSaved,
        keyboardType: TextInputType.visiblePassword,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 16, height: 0),
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
