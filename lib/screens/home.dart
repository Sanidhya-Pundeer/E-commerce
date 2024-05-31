import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:ecommerce/screens/checkout.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/orders.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;

  List<Widget> _pages = [
    HomePage(),
    Checkout(
      userEmail: "chomu@gmail.com",
    ),
    Orders(userEmail: "chomu@gmail.com"),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                margin: EdgeInsets.only(left: 65),
                child: Image.asset(
                  'assets/images/SwiftCart.png',
                  height: 57,
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: IconButton(
                icon: Icon(Icons.account_circle),
                iconSize: 32,
                color: Colors.black,
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: _pages[_page],
        bottomNavigationBar: CurvedNavigationBar(
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            backgroundColor: Color.fromARGB(239, 0, 0, 0),
            buttonBackgroundColor: Color.fromARGB(255, 155, 8, 8),
            animationDuration: Duration(milliseconds: 300),
            color: Color.fromARGB(255, 155, 8, 8),
            items: [
              CurvedNavigationBarItem(
                child: Icon(Icons.home),
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.search),
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.download_done_sharp),
              ),
            ]),
      ),
    );
  }
}
