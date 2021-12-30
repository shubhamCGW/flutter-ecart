import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({ key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 115,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage(
                "assets/images/banner_background.png",
              ),
              fit: BoxFit.cover)),
      child: Row(
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Image.asset(
                "assets/images/banner_image.png",
              ),
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Fresh Vegetables",
              style: TextStyle(fontSize: 22,
              fontWeight: FontWeight.bold),),
              Text("Get Up To 40%  OFF",
                style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
            ],
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}