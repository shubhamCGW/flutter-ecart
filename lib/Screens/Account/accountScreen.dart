import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account/components/body.dart';
import 'package:flutter_auth/components/MainAppBar.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "My Account"),
      // drawer: MainDrawer(),
      body: Body(),
    );
  }
}
















































//     return SafeArea(
//       child: Container(
//         child: SingleChildScrollView(
//             child: Column(
//           children: [
//             SizedBox(
//               height: 20.0,
//             ),
//             ListTile(
//               leading: SizedBox(
//                   width: 65,
//                   height: 65,
//                   child: CircleAvatar(
//                     radius: 5.0,
//                     backgroundImage: AssetImage(imagePath),
//                     backgroundColor: Colors.indigo.withOpacity(0.7),
//                   )),
//               title: Text(
//                 "Shubham Rajak",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: Text(
//                 "Sr. Software Developer",
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.indigo[400]),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
          
//             Container(
//               width: double.maxFinite,
//               margin: EdgeInsets.symmetric(horizontal: 25),
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: Text(
//                   "Log Out",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18.0),
//                     ),
//                     primary: Colors.indigo,
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                     textStyle:
//                         TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             )
//           ],
//         )),
//       ),
//     );
//   }
// }
