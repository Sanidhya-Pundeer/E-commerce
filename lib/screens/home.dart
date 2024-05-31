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
        
        body: _pages[_page],
        bottomNavigationBar: CurvedNavigationBar(
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            backgroundColor: Color.fromARGB(238, 253, 253, 253),
            buttonBackgroundColor: Color.fromARGB(255, 0, 0, 0),
            animationDuration: Duration(milliseconds: 300),
            color: Color.fromARGB(255, 0, 0, 0),
            items: [
              CurvedNavigationBarItem(
                child: Icon(Icons.home,color: Colors.white,),
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.trolley,color: Colors.white,),
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.timelapse_outlined,color: Colors.white,),
              ),
            ]),
      ),
    );
  }
}
