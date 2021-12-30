import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onSaved;
  final String Function(String) validator;
  final TextEditingController controller;
  const RoundedPasswordField(
      {Key key, this.controller, this.onSaved, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        obscureText: true,
        onSaved: onSaved,
        keyboardType: TextInputType.visiblePassword,
        validator: validator,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.all(0),
          // isDense: true,
          errorStyle: TextStyle(fontSize: 16, height: 0),
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
