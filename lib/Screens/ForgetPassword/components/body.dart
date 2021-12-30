import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/ForgetPassword/components/background.dart';
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
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  ScaffoldState scaffoldState;
  final _formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  showSnackbar(String msg) {
    var snackBar = new SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            )),
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
                      "Forget Password",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      "Enter the email address \nassociated with your E-cart account",
                      textAlign: TextAlign.center,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        width: size.width * 0.8,
                        child: Column(children: [
                          SizedBox(height: size.height * 0.03),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => email = input,
                            decoration: buildInputDecoration(
                                Icons.email, "Enter your email"),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please enter email";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return "Please enter valid email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8),
                          RoundedButton(
                            text: "Continue",
                            press: () {
                              forgetPassword();
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

  void forgetPassword() async {
    setState(() {
      isLoading = true;
    });

    var data = {'email': emailController.text};

    var res = await CallApi().postData(data, 'forgotPasswordSentEmail');
    if (res.statusCode == 200) {
      Map<String, dynamic> response = json.decode(res.body);
      // print(response);
      if (response['status']) {
        Navigator.of(context).pushNamed('/verifyOtp',
            arguments: {'email': emailController.text});
      } else {
        // print(" ${response['error']}");
        showSnackbar(" ${response['error']}");
      }
    } else {
      showSnackbar("Please try again!");
    }

    setState(() {
      isLoading = false;
    });
  }
}
