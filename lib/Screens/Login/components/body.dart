import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/home_screen.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/Inputdecoration.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/Screens/ForgetPassword/forget_password.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;
  String email, password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScaffoldState scaffoldState;
  final _formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  showSnackbar(String msg) {
    var snackBar = new SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void startLoading() async {
    this.setState(() {
      this.isLoading = true;
    });
  }

  void finishLoading() {
    this.setState(() {
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Background(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login1.svg",
                  height: size.height * 0.32,
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            buildInputDecoration(Icons.mail, "Enter Email"),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => email = input,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter email";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            buildInputDecoration(Icons.lock, "Enter Password"),
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (input) => password = input,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please enter your password';
                          }
                          // if (input.length < 8) {
                          //   return 'Provide Minimum 8 Character';
                          // }
                          // if (!RegExp(r'[A-Z]').hasMatch(input)) {
                          //   return 'Please use atleast One Uppercase [A-Z]';
                          // }
                          // if (!RegExp(r'[a-z]').hasMatch(input)) {
                          //   return 'Please use atleast One Lowercase [a-z]';
                          // }
                          // if (!RegExp(r'[0-9]').hasMatch(input)) {
                          //   return 'Please use atleast One Numeric value [0-9]';
                          // }
                          // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                          //     .hasMatch(input)) {
                          //   return 'Please use atleast One Special character [0-9]';
                          // }
                          // if (input.length >= 20) {
                          //   return 'Maximum length is 20 Character';
                          // }
                          return null;
                        },
                      ),
                      RoundedButton(
                        text: "LOGIN",
                        press: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            login();
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      AlreadyHaveAnAccountCheck(
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignUpScreen();
                              },
                            ),
                          );
                        },
                      ),
                      // SizedBox(height: size.height * 0.03),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => ForgetPswdScreen()));
                          },
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                                color: Color(0xFF1A237e), fontSize: 15),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    // setState(() {
    //   this.startLoading();
    //   showLoaderDialog(context);
    // });

    var data = {
      'email': emailController.text,
      'password': passwordController.text
    };

    var res = await CallApi().postData(data, 'userLogin');
    if (res.statusCode == 200) {
      Map<String, dynamic> response = jsonDecode(res.body);
      if (response['status']) {
        Map<String, dynamic> userProfile = response['response'];
        savePref(userProfile);
        showSnackbar("Login Successful");
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // print(" ${response['error']}");
        setState(() {
          this.finishLoading();
          showSnackbar(" ${response['error']}");
        });
      }
    } else {
      showSnackbar("Please try again!");
    }

    // setState(() {
    //   this.finishLoading();
    // });
  }

  savePref(Object userProfile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("userProfile", jsonEncode(userProfile));
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            value: this.isLoading ? null : 1,
          ),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
