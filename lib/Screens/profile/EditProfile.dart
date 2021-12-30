import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Models/User.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/Inputdecoration.dart';

import 'package:flutter_auth/components/rounded_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class EditProfileSreen extends StatefulWidget {
  const EditProfileSreen({Key key}) : super(key: key);

  @override
  State<EditProfileSreen> createState() => _EditProfileSreenState();
}

class _EditProfileSreenState extends State<EditProfileSreen> {
  bool showPassword = false;
  bool isLoading = false;
  File image;
  PickedFile _imageFile;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  Future<User> authUser;
  User user;

  @override
  void initState() {
    super.initState();
    authUser = getUser();
  }

  Future<User> getUser() async {
    Map<String, dynamic> res = await CallApi().getUserProfile();
    user = User.fromJson(res);
    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phone.toString();

    return user;
  }

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
          "Edit Profile",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Stack(children: [
                    SizedBox(
                      height: 30,
                    ),
                    image != null
                        ? ClipOval(
                            child: Image.file(
                              image,
                              width: 80,
                              height: 80,
                            ),
                          )
                        : Container(
                            width: 80,
                            height: 80,
                            child: FutureBuilder(
                                future: authUser,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return CircleAvatar(
                                      backgroundImage: snapshot.data.image ==
                                              null
                                          ? AssetImage(
                                              'assets/images/profile_pic.png')
                                          : NetworkImage(snapshot.data.image),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  // By default, show a loading spinner.
                                  return const CircularProgressIndicator();
                                }),
                          ),
                    // Container(
                    //     width: 80,
                    //     height: 80,
                    //     decoration: BoxDecoration(
                    //         border:
                    //             Border.all(width: 4, color: Colors.grey),
                    //         boxShadow: [
                    //           BoxShadow(
                    //               spreadRadius: 2,
                    //               blurRadius: 10,
                    //               color: Colors.white,
                    //               offset: Offset(0, 10))
                    //         ],
                    //         shape: BoxShape.circle,

                    //         image: DecorationImage(
                    //             fit: BoxFit.cover,
                    //             image: AssetImage(
                    //                 "assets/images/profile_pic.png"))),
                    //   ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 40,
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                        ))
                  ]),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: TextFormField(
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
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: TextFormField(
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
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: TextFormField(
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
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RoundedButton(
                      text: "Save",
                      press: () {},
                    ),
                    RoundedButton(
                      text: "Cancle",
                      color: kPrimaryLightColor,
                      textColor: Colors.black,
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
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

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/profile.jpeg")
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                pickImagefromCamera();
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                pickImagefromGallery();
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  Future pickImagefromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() => this.image = tempImage);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future pickImagefromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() => this.image = tempImage);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }
}
