import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/ResetPassword/components/background.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/Inputdecoration.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email;
  int UserId;
  bool isLoading = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confrimPasswordController = TextEditingController();
  ScaffoldState scaffoldState;
  final _formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  showSnackbar(String msg) {
    var snackBar = new SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) UserId = arguments['user_id'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Background(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/fpswd.svg",
                  height: size.height * 0.20,
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    child: Column(children: [
                      SizedBox(height: size.height * 0.03),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration:
                            buildInputDecoration(Icons.lock, "New Password"),
                        controller: passwordController,
                        onSaved: (val) {},
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (input.length < 8) {
                            return 'Provide Minimum 8 Character';
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(input)) {
                            return 'Please use atleast One Uppercase [A-Z]';
                          }
                          if (!RegExp(r'[a-z]').hasMatch(input)) {
                            return 'Please use atleast One Lowercase [a-z]';
                          }
                          if (!RegExp(r'[0-9]').hasMatch(input)) {
                            return 'Please use atleast One Numeric value [0-9]';
                          }
                          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                              .hasMatch(input)) {
                            return 'Please use atleast One Special character [0-9]';
                          }
                          if (input.length >= 20) {
                            return 'Maximum length is 20 Character';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: buildInputDecoration(
                            Icons.lock, "Confirm Password"),
                        controller: confrimPasswordController,
                        onSaved: (val) {},
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please confirm your password ";
                          }
                          if (passwordController.text !=
                              confrimPasswordController.text) {
                            return "Password Do not match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      RoundedButton(
                        text: "Save Changes",
                        press: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            // showSnackbar();
                            ResetPassword();
                          }
                        },
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void ResetPassword() async {
    var data = {
      'user_id': UserId,
      'password': passwordController.text,
      'password_confirmation': confrimPasswordController.text
    };

    var res = await CallApi().postData(data, 'resetPassword');
    if (res.statusCode == 200) {
      Map<String, dynamic> response = json.decode(res.body);
      if (response['status']) {
        showSnackbar(response['message']);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        showSnackbar(" ${response['error']}");
      }
    } else {
      showSnackbar("Please try again!");
    }
  }
}
