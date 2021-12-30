import 'package:flutter/material.dart';
import 'package:flutter_auth/components/confirmPassword_field.dart';
import 'package:flutter_auth/components/rounded_button.dart';

class ChangePswdScreen extends StatefulWidget {
  const ChangePswdScreen({Key key}) : super(key: key);

  @override
  _ChangePswdScreenState createState() => _ChangePswdScreenState();
}

class _ChangePswdScreenState extends State<ChangePswdScreen> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          "Change Password",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => SearchScreen()));
        //       },
        //       icon: Icon(Icons.search, color: Colors.white)),
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => CartScreen()));
        //       },
        //       icon: Icon(Icons.shopping_cart, color: Colors.white)),
        // ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              ConfirmPasswordField(
                text: "Current Password",
                onChanged: (value) {},
              ),
              ConfirmPasswordField(
                text: "New Password",
                onChanged: (value) {},
              ),
              ConfirmPasswordField(
                text: "Confirm Password",
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "Save",
                press: () {},
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildTextFeild(
      String labeltext, String placeholder, bool isPswdTextFeild) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPswdTextFeild ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPswdTextFeild
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.indigo,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 8),
            labelText: labeltext,
            labelStyle: TextStyle(color: Colors.indigo),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }
}
