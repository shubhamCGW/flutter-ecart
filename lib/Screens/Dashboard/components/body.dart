import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/components/grocery_featured_Item_widget.dart';
import 'package:flutter_auth/Screens/Products/productDetail.dart';
import 'package:flutter_auth/Screens/Products/seeAll.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/responsive.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        mobile: Row(
          children: [
            Expanded(flex: 2, child: HomeWidget(size: _size)),
          ],
        ),
        tablet: Row(
          children: [
            Expanded(flex: 6, child: HomeWidget(size: _size)),
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: _size.width > 1340 ? 2 : 4,
              child: HomeWidget(size: _size),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool isLoading = false;
  List Banners;
  List ExclusiveOffer;
  List BestOffer;

  getBannerImages() async {
    setState(() {
      isLoading = true;
    });

    var res = await CallApi().getData('getBanners');
    if (res.statusCode == 200) {
      var response = json.decode(res.body);

      if (response['status']) {
        setState(() {
          Banners = response['response'];
          // print(Banners);
        });
      } else {
        // print(" ${response['error']}");
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }

    setState(() {
      isLoading = false;
    });
  }

  getExclusiveOffer() async {
    var response = await CallApi().getData('getExclusiveOffer');

    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
      if (res['status']) {
        setState(() {
          ExclusiveOffer = res['response'];
        });
      } else {
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }
  }

  getBestOffer() async {
    var response = await CallApi().getData('getBestSelling');

    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
      if (res['status']) {
        setState(() {
          BestOffer = res['response'];
        });
      } else {
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }
  }

  getProductDetails(int productId) async {
    var data = {
      'product_id': productId,
    };

    var response =
        await CallApi().postDataWithHeader(data, 'getProductDetails');
    // print(response);
    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
      if (res['status']) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(res['response'])));
      } else {
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }
  }

  @override
  void initState() {
    super.initState();
    getBannerImages();
    getExclusiveOffer();
    getBestOffer();
  }

  @override
  Widget build(BuildContext context) {
    if (Banners == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      // print(Banners);
      return SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                imageCrousel = Container(
                  height: widget.size.height * 0.25,
                  width: double.infinity,
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    autoplay: true,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                    dotSize: 6.0,
                    dotIncreasedColor: Colors.indigo,
                    dotBgColor: Colors.transparent,
                    dotPosition: DotPosition.bottomCenter,
                    dotVerticalPadding: 10.0,
                    showIndicator: true,
                    indicatorBgPadding: 7.0,
                    images: Banners == null
                        ? Center(child: CircularProgressIndicator())
                        : [
                            NetworkImage(Banners[0]['image']),
                            NetworkImage(Banners[1]['image']),
                            NetworkImage(Banners[2]['image']),
                            NetworkImage(Banners[3]['image']),
                            NetworkImage(Banners[4]['image']),
                          ],
                  ),
                ),
                SizedBox(
                  // height: 25,
                  height: widget.size.height * 0.02,
                ),
                padded(subTitle(context, "Exclusive")),
                getHorizontalItemSlider(),
                SizedBox(
                  height: widget.size.height * 0.01,
                  // height: 15,
                ),
                padded(subTitle(context, "Best Selling")),
                getBestOfferItemSlider(),
                SizedBox(
                  height: widget.size.height * 0.01,
                ),
                padded(subTitle(context, "Groceries")),
                // SizedBox(
                //   height: size.height * 0.01,
                // ),
                Container(
                  height: 105,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 1,
                      ),
                      GroceryFeaturedCard(
                        groceryFeaturedItems[0],
                        color: Color(0xffF8A44C),
                      ),
                      GroceryFeaturedCard(
                        groceryFeaturedItems[1],
                        color: Colors.red[200],
                      ),
                      GroceryFeaturedCard(
                        groceryFeaturedItems[2],
                        color: Colors.cyan[200],
                      ),
                      GroceryFeaturedCard(
                        groceryFeaturedItems[3],
                        color: Colors.green[100],
                      ),
                      GroceryFeaturedCard(
                        groceryFeaturedItems[4],
                        color: Colors.blue[100],
                      ),
                    ],
                  ),
                ),
                getHorizontalItemSlider(),
                SizedBox(
                  height: widget.size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getHorizontalItemSlider() {
    return ExclusiveOffer == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            height: 200,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 2),
              itemCount: ExclusiveOffer.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final exoff = ExclusiveOffer[index];
                return GestureDetector(
                  onTap: () {
                    exoff['id'] == null
                        ? Center(child: CircularProgressIndicator())
                        : getProductDetails(exoff['id']);
                  },
                  child: Container(
                    width: 174,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffE2E2E2),
                      ),
                      borderRadius: BorderRadius.circular(
                        18,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Container(
                                child: Image.network(exoff['image']),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            exoff['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              // color: Color(0xFF7C7C7C),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            exoff['sub_desc'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7C7C7C),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "\Rs. ${exoff['price'].toStringAsFixed(2)} /-",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 1,
                );
              },
            ),
          );
  }

  Widget getBestOfferItemSlider() {
    return BestOffer == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            height: 200,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 2),
              itemCount: BestOffer.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final exoff = BestOffer[index];
                return GestureDetector(
                  onTap: () {
                    exoff['id'] == null
                        ? Center(child: CircularProgressIndicator())
                        : getProductDetails(exoff['id']);
                  },
                  child: Container(
                    width: 174,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffE2E2E2),
                      ),
                      borderRadius: BorderRadius.circular(
                        18,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Container(
                                child: Image.network(exoff['image']),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            exoff['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              // color: Color(0xFF7C7C7C),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            exoff['sub_desc'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7C7C7C),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "\Rs. ${exoff['price'].toStringAsFixed(2)} /-",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 1,
                );
              },
            ),
          );
  }

  Widget subTitle(BuildContext context, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900]),
        ),
        // Spacer(),
        InkWell(
            child: Text(
              "See All",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[500]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SeeAllProdList()),
              );
            })
      ],
    );
  }

  Widget imageCrousel = Container(
    height: 200,
    child: Carousel(
      boxFit: BoxFit.cover,
      autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
      dotSize: 6.0,
      dotIncreasedColor: Colors.grey,
      dotBgColor: Colors.transparent,
      dotPosition: DotPosition.bottomCenter,
      dotVerticalPadding: 10.0,
      showIndicator: true,
      indicatorBgPadding: 7.0,
      images: [
        AssetImage("assets/images/i5.jpg"),
        AssetImage("assets/images/i6.jpg"),
        AssetImage("assets/images/i3.jpg"),
        AssetImage("assets/images/b4.jpg"),
      ],
    ),
  );
}
