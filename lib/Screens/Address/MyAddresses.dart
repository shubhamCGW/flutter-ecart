import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account/components/profile_menu.dart';
import 'package:flutter_auth/Screens/Address/AddNewAddress.dart';

class MyAddresses extends StatelessWidget {
  const MyAddresses({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigo,
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
          "My Address",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: ProfileMenu(
                  text: "+ Add a new Address",
                  icon: "assets/icons/location_icon.svg",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewAddress()));
                  },
                ),
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 10),
                // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                height: size.height / 4,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text("Shubham Rajak")),
                    Expanded(
                        child:
                            Text("CGW, 101 ,Sidharth Apartment,Bhopal")),
                    Expanded(child: Text("- 462021")),
                    Expanded(child: Text("- 8821908348")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
