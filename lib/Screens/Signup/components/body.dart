import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/home_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/Inputdecoration.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ScaffoldState scaffoldState;
  showSnackbar(String msg) {
    var snackBar = new SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/register.svg",
                  height: size.height * 0.32,
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  "SIGNUP",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            buildInputDecoration(Icons.person, "Your Name"),
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        // onSaved: (input) => _name = input,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please enter name';
                          }
                          if (!RegExp(r'^[a-z A-Z]+$').hasMatch(input)) {
                            return 'Please enter correct name';
                          }
                          if (input.length < 3) {
                            return 'Name must have 3 Character';
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
                        decoration:
                            buildInputDecoration(Icons.email, "Your Email"),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter email";
                          }
                          if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value)) {
                            return 'Please enter valid email';
                          }
                          // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          //     .hasMatch(value)) {
                          //   return "Please enter valid email";
                          // }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: buildInputDecoration(
                            Icons.phone_android, "Your Mobile No."),
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (String value) {
                          if (value.length != 10) {
                            return "Mobile no. must be of 10 digit";
                          }
                          if (value.isNotEmpty) {
                            bool mobileValid = RegExp(
                                    r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                .hasMatch(value);
                            return mobileValid ? null : "Invalid mobile no.";
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
                        decoration:
                            buildInputDecoration(Icons.lock, "Your Password"),
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
                        controller: confirmpasswordController,
                        onSaved: (val) {},
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please confirm your password ";
                          }
                          if (passwordController.text !=
                              confirmpasswordController.text) {
                            return "Password Do not match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      RoundedButton(
                        text: "SIGNUP",
                        press: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            // showSnackbar();
                            signup();
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ),
                          );
                        },
                      ),
                      OrDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: SocalIcon(
                              iconSrc: "assets/icons/facebook.svg",
                              press: () {},
                            ),
                          ),
                          Expanded(
                            child: SocalIcon(
                              iconSrc: "assets/icons/twitter.svg",
                              press: () {},
                            ),
                          ),
                          Expanded(
                            child: SocalIcon(
                              iconSrc: "assets/icons/google-plus.svg",
                              press: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  void signup() async {
    var data = {
      'email': emailController.text,
      'name': nameController.text,
      'phone': phoneController.text,
      'password': passwordController.text,
      'password_confirmation': confirmpasswordController.text
    };

    var res = await CallApi().postData(data, 'userRegister');
    if (res.statusCode == 200) {
      Map<String, dynamic> response = jsonDecode(res.body);
      if (response['status']) {
        Map<String, dynamic> userProfile = response['response'];
        setState(() {
          isLoading = true;
          showLoaderDialog(context);
        });

        savePref(userProfile);
        showSnackbar("Account Created Successfully!");
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        showSnackbar(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }

    setState(() {
      isLoading = false;
    });
  }

  savePref(Object userProfile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("userProfile", jsonEncode(userProfile));
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
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
