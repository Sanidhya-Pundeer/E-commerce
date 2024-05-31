
import 'package:flutter/material.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/bagPage.dart';
import 'package:ecommerce/screens/menuDrawer.dart';
import 'package:ecommerce/services/Helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  var _selectedIndex = 0;
  Helper http = Helper();
  var name = "Tiramisu";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MenuDrawer(),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              margin: EdgeInsets.only(left: 27),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome,",
                  style: TextStyle(
                    fontFamily: 'Lufga',
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 12, right: 9, bottom: 2),
                        child: Icon(Icons.search),
                      ),
                      border: InputBorder.none,
                      hintText: 'What would you like to buy?',
                      hintStyle: TextStyle(
                          fontFamily: 'Lufga', fontWeight: FontWeight.w100)),

                    onSubmitted: (value) async{
                                List<Product> p = await http.getProducts(value);
                                if (p.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BagPage(),
                                      settings: RouteSettings(arguments: p),
                                    ),
                                  );
                                } else {
                                  // Handle empty or null product list
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('No products found')),
                                  );
                              };
                    },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Container(
                height: 150,
                width: double.infinity,
                child: PageView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        'assets/images/slide1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        'assets/images/slide2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        'assets/images/slide3.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        'assets/images/slide4.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              height: 60,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuText('Category', 0),
                ],
              ),
            ),
            SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: [
                _buildGridItem('assets/images/grid1.png', 'bags', BagPage()),
                _buildGridItem(
                    'assets/images/grid2.png', 'Bodycare', BagPage()),
                _buildGridItem(
                    'assets/images/grid3.png', 'Stationery', BagPage()),
                _buildGridItem(
                    'assets/images/grid4.png', 'Hardware', BagPage()),
                _buildGridItem('assets/images/grid5.png', 'Fashion', BagPage()),
                _buildGridItem(
                    'assets/images/grid6.png', 'Footwear', BagPage()),
                _buildGridItem('assets/images/grid7.png', 'Watches', BagPage()),
                _buildGridItem(
                    'assets/images/grid8.png', 'Jewellery', BagPage()),
                _buildGridItem('assets/images/grid9.png', 'Gadgets', BagPage()),
              ],
            ),
          ],
        ),
      ),
     
    );
  }

  Widget _buildMenuText(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: _selectedIndex == index
                ? const BorderSide(
                    color: Colors.black,
                    width: 2,
                  )
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lufga',
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(String imagePath, String text, Widget nextPage) {
    return GestureDetector(
      onTap: () async {
        List<Product> p = await http.getProducts(text);
        if (p.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextPage,
              settings: RouteSettings(arguments: p),
            ),
          );
        } else {
          // Handle empty or null product list
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No products found')),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lufga',
                    fontWeight: FontWeight.w100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
