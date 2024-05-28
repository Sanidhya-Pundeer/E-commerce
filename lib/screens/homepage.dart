import 'package:ecommerce/screens/bagPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  final TextEditingController _searchController = TextEditingController();
  var _selectedIndex = 0;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              height: 30,
              width: 200,
              fit: BoxFit.contain,
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
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 12, right: 9),
                      child: Icon(Icons.search),
                    ),
                    border: InputBorder.none,
                    hintText: 'What would you like to buy?',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              width: double.infinity,
              child: PageView(
                children: [
                  Image.asset(
                    'assets/images/slide1.png',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/slide2.jpg',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconContainer(Icons.other_houses, 'Popular',
                    Color.fromRGBO(163, 41, 147, 1)),
                _buildIconContainer(Icons.access_alarm, 'Flash Sell',
                    Color.fromARGB(255, 209, 189, 6)),
                _buildIconContainer(Icons.directions_car, 'Evaly Store',
                    Color.fromARGB(255, 54, 203, 153)),
                _buildIconContainer(
                    Icons.cake, 'Voucher', Color.fromARGB(255, 7, 95, 196)),
              ],
            ),
            SizedBox(
              height: 18,
            ),
              Container(
                color: Colors.grey[100],
              padding: EdgeInsets.symmetric(vertical: 6),
              height: 60, 
              width: double.infinity, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuText('Category', 0),
                  _buildMenuText('Brands', 1),
                  _buildMenuText('Shop', 2),
                ],
              ),
            ),
             SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: [
                _buildGridItem('assets/images/bag.png', 'Bags & Luggage' ,  BagPage()),
                _buildGridItem('assets/images/beauty.png', 'Beauty & Bodycare' , BagPage() ),
                _buildGridItem('assets/images/books.png', 'Books & Stationery', BagPage()),
                _buildGridItem('assets/images/hardware.webp', 'Hardware & Tools' , BagPage()),
                _buildGridItem('assets/images/fashion.webp', 'Fashion' , BagPage()),
                _buildGridItem('assets/images/shoes.jpg', 'Footwear', BagPage()),
                _buildGridItem('assets/images/watch.png', 'Watches' , BagPage()),
                _buildGridItem('assets/images/jewellery.webp', 'Jewellery', BagPage()),
                _buildGridItem('assets/images/gadgets.jpg', 'Gadgets', BagPage()),
                
              ],
            ),


          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(IconData icon, String text, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[100],
          ),
          child: Icon(
            icon,
            size: 30,
            color: color,
          ),
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(fontSize: 12),
        ),
      ],
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _selectedIndex == index ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _selectedIndex == index ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }
  

  Widget _buildGridItem(String imagePath, String text, Widget nextPage) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    },
    child: Column(
      children: [
        Image.asset(
          imagePath,
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}

}
