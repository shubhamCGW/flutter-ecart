import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile_pic.png"),
          ),
          // Positioned(
          //   right: -16,
          //   bottom: 0,
          //   child: SizedBox(
          //     height: 46,
          //     width: 46,
          //     child: TextButton(
          //       style: TextButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(50),
          //           side: BorderSide(color: Colors.white),
          //         ),
          //         primary: Colors.indigo,
          //         backgroundColor: Colors.white,
          //       ),
          //       onPressed: () {},
          //       child: SvgPicture.asset(
          //           "assets/icons/account_icons/camera_icon.svg"),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
