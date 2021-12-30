import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final ValueChanged<String> onSaved;
  final String Function(String) validator;
  const RoundedInputField({
    Key key,
    this.keyboardType,
    this.controller,
    this.hintText,
    this.labelText,
    this.icon = Icons.person,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: validator,
        controller: controller,
        onSaved: onSaved,
        keyboardType: keyboardType,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 16, height: 0),
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
