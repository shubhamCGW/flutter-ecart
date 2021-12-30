// import 'dart:convert';

// import 'package:badges/badges.dart';
// import 'package:carousel_pro/carousel_pro.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_auth/Screens/Cart/cart.dart';
// import 'package:flutter_auth/Screens/Products/productDetail.dart';
// import 'package:flutter_auth/Screens/Products/seeAll.dart';
// import 'package:flutter_auth/api/api.dart';
// import 'package:flutter_auth/components/Drawer.dart';
// import '../explore_screen.dart';
// import 'components/grocery_featured_Item_widget.dart';

// class HomeMainScreen extends StatefulWidget {
//   const HomeMainScreen({Key key}) : super(key: key);

//   @override
//   _HomeMainScreenState createState() => _HomeMainScreenState();
// }

// class _HomeMainScreenState extends State<HomeMainScreen> {
//   bool isLoading = false;
//   bool favourite = false;
//   List Banners;
//   List ExclusiveOffer;
//   List BestOffer;
//   bool isSearching = false;
//   List myCart;
//   // var _currentTab = TabItem.red;

//   // void _selectTab(TabItem tabItem) {
//   //   setState(() => _currentTab = tabItem);
//   // }

//   // int _selectedIndex = 0;

//   showSnackbar(String msg) {
//     var snackBar = new SnackBar(content: Text(msg));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   getCartList() async {
//     // var data = {'product_id': productId};

//     var res = await CallApi().getDataWithHeader('getCartList');

//     if (res.statusCode == 200) {
//       var response = json.decode(res.body);
//       if (response['status']) {
//         // print(response['response']);
//         setState(() {
//           myCart = response['response'];
//         });
//         // print(response['message']);
//       } else {
//         showSnackbar(response['error']);
//       }
//     } else {
//       showSnackbar("Please try again!");
//     }
//   }

//   getBannerImages() async {
//     setState(() {
//       isLoading = true;
//     });

//     var res = await CallApi().getData('getBanners');
//     if (res.statusCode == 200) {
//       var response = json.decode(res.body);

//       if (response['status']) {
//         setState(() {
//           Banners = response['response'];
//           // print(Banners);
//         });
//       } else {
//         // print(" ${response['error']}");
//         print(" ${response['error']}");
//       }
//     } else {
//       print("Please try again!");
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   addToWishList(int productId) async {
//     var data = {'product_id': productId};

//     var res = await CallApi().postDataWithHeader(data, 'addToWishListProduct');

//     if (res.statusCode == 200) {
//       var response = json.decode(res.body);
//       if (response['status']) {
//         print(response['response']);
//         // showSnackbar(response['message']);
//       } else {
//         print(response['message']);
//       }
//     } else {
//       print("Please try again!");
//     }
//   }

//   getExclusiveOffer() async {
//     var response = await CallApi().getData('getExclusiveOffer');

//     if (response.statusCode == 200) {
//       var res = json.decode(response.body.toString());
//       if (res['status']) {
//         // print(ExclusiveOffer);
//         setState(() {
//           ExclusiveOffer = res['response'];
//         });
//       } else {
//         print(" ${response['error']}");
//       }
//     } else {
//       print("Please try again!");
//     }
//   }

//   getBestOffer() async {
//     var response = await CallApi().getData('getBestSelling');

//     if (response.statusCode == 200) {
//       var res = json.decode(response.body.toString());
//       if (res['status']) {
//         setState(() {
//           BestOffer = res['response'];
//         });
//       } else {
//         print(" ${response['error']}");
//       }
//     } else {
//       print("Please try again!");
//     }
//   }

//   getProductDetails(int productId) async {
//     var data = {
//       'product_id': productId,
//     };

//     var response =
//         await CallApi().postDataWithHeader(data, 'getProductDetails');
//     // print(response);
//     if (response.statusCode == 200) {
//       var res = json.decode(response.body.toString());
//       if (res['status']) {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ProductDetailsScreen(res['response'])));
//       } else {
//         print(" ${response['error']}");
//       }
//     } else {
//       print("Please try again!");
//     }
//   }

  

//   @override
//   void initState() {
//     super.initState();
//     getBannerImages();
//     getExclusiveOffer();
//     getBestOffer();
//     getCartList();
//   }

 

//   @override
//   Widget build(BuildContext context) {
//     Size _size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         title: Text(
//           "E-Cart",
//           style: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => SearchScreen()));
//               },
//               icon: Icon(Icons.search, color: Colors.white)),
//           Badge(
//             position: BadgePosition.topEnd(top: 0, end: 3),
//             badgeContent: myCart == null
//                 ? Text(
//                     "0",
//                     style: TextStyle(color: Colors.white),
//                   )
//                 : Text(
//                     myCart.length.toString(),
//                     style: TextStyle(color: Colors.white),
//                   ),
//             child: IconButton(
//                 icon: Icon(Icons.shopping_cart, color: Colors.white),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => CartScreen()));
//                 }),
//           )
//         ],
//       ),
//       drawer: MainDrawer(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 imageCrousel = Container(
//                   height: _size.height * 0.25,
//                   width: double.infinity,
//                   child: Carousel(
//                     boxFit: BoxFit.cover,
//                     autoplay: true,
//                     animationCurve: Curves.fastOutSlowIn,
//                     animationDuration: Duration(milliseconds: 1000),
//                     dotSize: 6.0,
//                     dotIncreasedColor: Colors.indigo,
//                     dotBgColor: Colors.transparent,
//                     dotPosition: DotPosition.bottomCenter,
//                     dotVerticalPadding: 10.0,
//                     showIndicator: true,
//                     indicatorBgPadding: 7.0,
//                     images: Banners == null
//                         ? Center(child: CircularProgressIndicator())
//                         : [
//                             NetworkImage(Banners[0]['image']),
//                             NetworkImage(Banners[1]['image']),
//                             NetworkImage(Banners[2]['image']),
//                             NetworkImage(Banners[3]['image']),
//                             NetworkImage(Banners[4]['image']),
//                           ],
//                   ),
//                 ),
//                 SizedBox(
//                   // height: 25,
//                   height: _size.height * 0.02,
//                 ),
//                 padded(subTitle(context, "Exclusive")),
//                 getHorizontalItemSlider(),
//                 SizedBox(
//                   height: _size.height * 0.01,
//                   // height: 15,
//                 ),
//                 padded(subTitle(context, "Best Selling")),
//                 getBestOfferItemSlider(),
//                 SizedBox(
//                   height: _size.height * 0.01,
//                 ),
//                 padded(subTitle(context, "Groceries")),
//                 // SizedBox(
//                 //   height: size.height * 0.01,
//                 // ),
//                 Container(
//                   height: 105,
//                   child: ListView(
//                     padding: EdgeInsets.zero,
//                     scrollDirection: Axis.horizontal,
//                     children: [
//                       SizedBox(
//                         width: 1,
//                       ),
//                       GroceryFeaturedCard(
//                         groceryFeaturedItems[0],
//                         color: Color(0xffF8A44C),
//                       ),
//                       GroceryFeaturedCard(
//                         groceryFeaturedItems[1],
//                         color: Colors.red[200],
//                       ),
//                       GroceryFeaturedCard(
//                         groceryFeaturedItems[2],
//                         color: Colors.cyan[200],
//                       ),
//                       GroceryFeaturedCard(
//                         groceryFeaturedItems[3],
//                         color: Colors.green[100],
//                       ),
//                       GroceryFeaturedCard(
//                         groceryFeaturedItems[4],
//                         color: Colors.blue[100],
//                       ),
//                     ],
//                   ),
//                 ),
//                 getHorizontalItemSlider(),
//                 SizedBox(
//                   height: _size.height * 0.03,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget padded(Widget widget) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 25),
//       child: widget,
//     );
//   }

//   Widget getHorizontalItemSlider() {
//     //  print(ExclusiveOffer);
//     return ExclusiveOffer == null
//         ? Center(child: CircularProgressIndicator())
//         : Container(
//             margin: EdgeInsets.symmetric(vertical: 6),
//             height: 200,
//             child: ListView.separated(
//               padding: EdgeInsets.symmetric(horizontal: 2),
//               itemCount: ExclusiveOffer.length,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 final exoff = ExclusiveOffer[index];
//                 return GestureDetector(
//                   onTap: () {
//                     exoff['id'] == null
//                         ? Center(child: CircularProgressIndicator())
//                         : getProductDetails(exoff['id']);
//                   },
//                   child: Container(
//                     width: 174,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Color(0xffE2E2E2),
//                       ),
//                       borderRadius: BorderRadius.circular(
//                         18,
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 15,
//                         vertical: 15,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(bottom: 20.0, left: 115),
//                             child: InkWell(
//                               onTap: () {
//                                 if (exoff['favourite'] = true) {
//                                   setState(() {
//                                     addToWishList(exoff['id']);
//                                     favourite = !favourite;
//                                   });
//                                 }
//                               },
//                               child: Icon(
//                                 favourite
//                                     ? Icons.favorite
//                                     : Icons.favorite_border,
//                                 color:
//                                     favourite ? Colors.indigo : Colors.blueGrey,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Center(
//                               child: Container(
//                                 child: Image.network(exoff['image']),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 3,
//                           ),
//                           Text(
//                             exoff['name'],
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               // color: Color(0xFF7C7C7C),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 2,
//                           ),
//                           Text(
//                             exoff['description'],
//                             softWrap: true,
//                             textAlign: TextAlign.justify,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                             style: TextStyle(
//                               color: Color(0xFF7C7C7C),
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                               // color: Color(0xFF7C7C7C),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 3,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "\Rs. ${exoff['price']} /-",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Spacer(),
//                               Text(
//                                 exoff['sub_desc'],
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF7C7C7C),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // Row(
//                           //   mainAxisSize: MainAxisSize.max,
//                           //   children: [

//                           //   ],
//                           // )
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return SizedBox(
//                   width: 1,
//                 );
//               },
//             ),
//           );
//   }

//   Widget getBestOfferItemSlider() {
//     return BestOffer == null
//         ? Center(child: CircularProgressIndicator())
//         : Container(
//             margin: EdgeInsets.symmetric(vertical: 6),
//             height: 200,
//             child: ListView.separated(
//               padding: EdgeInsets.symmetric(horizontal: 2),
//               itemCount: BestOffer.length,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 final exoff = BestOffer[index];
//                 return GestureDetector(
//                   onTap: () {
//                     exoff['id'] == null
//                         ? Center(child: CircularProgressIndicator())
//                         : getProductDetails(exoff['id']);
//                   },
//                   child: Container(
//                     width: 174,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Color(0xffE2E2E2),
//                       ),
//                       borderRadius: BorderRadius.circular(
//                         18,
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 15,
//                         vertical: 15,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(bottom: 20.0, left: 115),
//                             child: InkWell(
//                               onTap: () {
//                                 if (exoff['favourite'] = true) {
//                                   setState(() {
//                                     addToWishList(exoff['id']);
//                                     favourite = !favourite;
//                                   });
//                                 }
//                               },
//                               child: Icon(
//                                 favourite
//                                     ? Icons.favorite
//                                     : Icons.favorite_border,
//                                 color:
//                                     favourite ? Colors.indigo : Colors.blueGrey,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Center(
//                               child: Container(
//                                 child: Image.network(exoff['image']),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 3,
//                           ),
//                           Text(
//                             exoff['name'],
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               // color: Color(0xFF7C7C7C),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 2,
//                           ),
//                           Text(
//                             exoff['description'],
//                             softWrap: true,
//                             textAlign: TextAlign.justify,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                             style: TextStyle(
//                               color: Color(0xFF7C7C7C),
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                               // color: Color(0xFF7C7C7C),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "\Rs. ${exoff['price']} /-",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Spacer(),
//                               Text(
//                                 exoff['sub_desc'],
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF7C7C7C),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return SizedBox(
//                   width: 1,
//                 );
//               },
//             ),
//           );
//   }

//   Widget subTitle(BuildContext context, String text) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           text,
//           style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.indigo[900]),
//         ),
//         // Spacer(),
//         InkWell(
//             child: Text(
//               "See All",
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.indigo[500]),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SeeAllProdList()),
//               );
//             })
//       ],
//     );
//   }

//   Widget imageCrousel = Container(
//     height: 200,
//     child: Carousel(
//       boxFit: BoxFit.cover,
//       autoplay: true,
//       animationCurve: Curves.fastOutSlowIn,
//       animationDuration: Duration(milliseconds: 1000),
//       dotSize: 6.0,
//       dotIncreasedColor: Colors.grey,
//       dotBgColor: Colors.transparent,
//       dotPosition: DotPosition.bottomCenter,
//       dotVerticalPadding: 10.0,
//       showIndicator: true,
//       indicatorBgPadding: 7.0,
//       images: [
//         AssetImage("assets/images/i5.jpg"),
//         AssetImage("assets/images/i6.jpg"),
//         AssetImage("assets/images/i3.jpg"),
//         AssetImage("assets/images/b4.jpg"),
//       ],
//     ),
//   );
// }
