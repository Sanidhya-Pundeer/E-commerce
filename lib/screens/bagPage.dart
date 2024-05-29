import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/detailPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/model/cartProvider.dart';

class BagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey sortKey = GlobalKey();
    final GlobalKey filterKey = GlobalKey();
    List<Product> productList = Provider.of<CartProvider>(context).pList;

    return Scaffold(
      backgroundColor: Colors.grey[100],
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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 4 / 6,  //width:height 
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return _buildGridItem(context, productList[index]);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        shape: CircularNotchedRectangle(), // Notch for floating action button
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                key: filterKey,
                onPressed: () {
                  final RenderBox button = filterKey.currentContext!.findRenderObject() as RenderBox;
                  final Size buttonSize = button.size; // Get the button's size

                  final Rect buttonRect = Rect.fromLTWH(
                    button.localToGlobal(Offset.zero).dx, // Left position
                    button.localToGlobal(Offset.zero).dy, // Top position
                    buttonSize.width,  // Width
                    buttonSize.height, // Height
                  );

                  showMenu<String>(
                    context: context,
                    position: RelativeRect.fromRect(buttonRect, Offset.zero & MediaQuery.of(context).size),
                    items: [
                      PopupMenuItem(child: Text("price")),
                      PopupMenuItem(child: Text("popularity")),
                      // Add more menu options here
                    ],
                  ).then((selectedValue) {
                    if (selectedValue != null) {
                      // Handle the selected menu item (e.g., update sort state)
                      print("Selected: $selectedValue");
                    }
                  });
                },
                icon: Icon(Icons.filter_alt_sharp),
              ),
            IconButton(
                key: sortKey,
                onPressed: () {
                  final RenderBox button = sortKey.currentContext!.findRenderObject() as RenderBox;
                  final Size buttonSize = button.size; // Get the button's size

                  final Rect buttonRect = Rect.fromLTWH(
                    button.localToGlobal(Offset.zero).dx, // Left position
                    button.localToGlobal(Offset.zero).dy, // Top position
                    buttonSize.width,  // Width
                    buttonSize.height, // Height
                  );

                  showMenu<String>(
                    context: context,
                    position: RelativeRect.fromRect(buttonRect, Offset.zero & MediaQuery.of(context).size),
                    items: [
                      PopupMenuItem(child: Text("Low to High")),
                      PopupMenuItem(child: Text("High to Low")),
                      // Add more menu options here
                    ],
                  ).then((selectedValue) {
                    if (selectedValue != null) {
                      // Handle the selected menu item (e.g., update sort state)
                      print("Selected: $selectedValue");
                    }
                  });
                },
                icon: Icon(Icons.sort),
              ),
          ],
        ),
      ),
      );
  }

  Widget _buildGridItem(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(product: product)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                product.img,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 2),
            Text(
              product.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 1.5),
            Text(
              'Price: ${product.price.toString()}',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 40, 196, 239),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
