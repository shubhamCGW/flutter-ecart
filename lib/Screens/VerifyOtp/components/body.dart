import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/VerifyOtp/components/background.dart';
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
  TextEditingController otpController = TextEditingController();

  ScaffoldState scaffoldState;
  String userEmail;
  final _formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  showSnackbar(String msg) {
    var snackBar = new SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) userEmail = arguments['email'];
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
                SizedBox(height: 3),
                SvgPicture.asset(
                  "assets/icons/fpswd.svg",
                  height: 20
                ),
                SizedBox(height: 3),
                Text(
                  "Verification required",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Text(
                  "To continue,complete this verification step." +
                      " \nWe've sent an OTP to the email address \n" +
                      userEmail +
                      "\n Please enter it bleow to \ncomplete verification",
                  textAlign: TextAlign.center,
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: double.infinity,
                    child: Column(children: [
                      SizedBox(height: 3),
                      TextFormField(
                        controller: otpController,
                        decoration:
                            buildInputDecoration(Icons.mail, "Enter OTP "),
                        onChanged: (value) {},
                        keyboardType: TextInputType.phone,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter otp no.';
                          } else if (value.isNotEmpty) {
                            bool mobileValid =
                                RegExp(r'^[0-9]*$').hasMatch(value);
                            return mobileValid ? null : "Invalid otp no.";
                          }
                          if (value.length < 10) {
                            return "Please enter valid otp no.";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      RoundedButton(
                        text: "Continue",
                        press: () {
                          verifyOtp();
                        },
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      RoundedButton(
                        text: "Resend Otp",
                        press: () {
                          
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

  void verifyOtp() async {
    setState(() {
      isLoading = true;
    });

    var data = {'email': userEmail, 'otp_no': int.parse(otpController.text)};

    var res = await CallApi().postData(data, 'verifyOtp');
    if (res.statusCode == 200) {
      Map<String, dynamic> response = json.decode(res.body);
      // print(response);

      if (response['status']) {
        final userId = response['response']['id'];
        Navigator.of(context)
            .pushNamed('/resetPasswordScreen', arguments: {'user_id': userId});
      } else {
        // print(response);
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
