import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/detailPage.dart';
import 'package:ecommerce/services/Helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/model/cartProvider.dart';

class BagPage extends StatefulWidget {
  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  Helper http = Helper();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as List<Product>?;
    if (args != null) {
      setState(() {
        products = args;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey sortKey = GlobalKey();
    final GlobalKey filterKey = GlobalKey();

    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 4 / 6, //width:height
              ),
              itemCount: products!.length,
              itemBuilder: (context, index) {
                return _buildGridItem(context, products![index]);
              },
            ),
          ),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        height: 80,
        shape: CircularNotchedRectangle(), // Notch for floating action button
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              key: filterKey,
              onPressed: () {
                final RenderBox button =
                    filterKey.currentContext!.findRenderObject() as RenderBox;
                final Size buttonSize = button.size; // Get the button's size

                final Rect buttonRect = Rect.fromLTWH(
                  button.localToGlobal(Offset.zero).dx, // Left position
                  button.localToGlobal(Offset.zero).dy, // Top position
                  buttonSize.width, // Width
                  buttonSize.height, // Height
                );

                showMenu<String>(
                  color: Colors.black,
                  context: context,
                  position: RelativeRect.fromRect(
                      buttonRect, Offset.zero & MediaQuery.of(context).size),
                  items: [
                    PopupMenuItem(
                      child: Text("Rating > 3",
                          style: TextStyle(
                              fontFamily: "Lufga", color: Colors.white)),
                      onTap: () async {
                        List<Product> p = await http.rate3("phone");
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
                        }
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Rating > 4",
                          style: TextStyle(
                              fontFamily: "Lufga", color: Colors.white)),
                      onTap: () async {
                        List<Product> p = await http.rate4("phone");
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
                        }
                      },
                    ),
                    // Add more menu options here
                  ],
                ).then((selectedValue) {
                  if (selectedValue != null) {
                    // Handle the selected menu item (e.g., update sort state)
                    print("Selected: $selectedValue");
                  }
                });
              },
                icon: Row(
                children: [
                  Icon(Icons.filter_alt_sharp, color: Colors.white),
                  SizedBox(width: 5), // Adjust the spacing between icon and label
                  Text(
                    'Filter',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            IconButton(
              key: sortKey,
              onPressed: () {
                final RenderBox button =
                    sortKey.currentContext!.findRenderObject() as RenderBox;
                final Size buttonSize = button.size; // Get the button's size

                final Rect buttonRect = Rect.fromLTWH(
                  button.localToGlobal(Offset.zero).dx, // Left position
                  button.localToGlobal(Offset.zero).dy, // Top position
                  buttonSize.width, // Width
                  buttonSize.height, // Height
                );

                showMenu<String>(
                  color: Colors.black,
                  context: context,
                  position: RelativeRect.fromRect(
                      buttonRect, Offset.zero & MediaQuery.of(context).size),
                  items: [
                    PopupMenuItem(
                      child: Text(
                        "Low to High",
                        style:
                            TextStyle(fontFamily: "Lufga", color: Colors.white),
                      ),
                      onTap: () async {
                        List<Product> p = await http.sortProductsLow("phone");
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
                        }
                      },
                    ),
                    PopupMenuItem(
                      child: Text("High to Low",
                          style: TextStyle(
                              fontFamily: "Lufga", color: Colors.white)),
                      onTap: () async {
                        List<Product> p = await http.sortProductsHigh("phone");
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
                        }
                      },
                    ),
                    // Add more menu options here
                  ],
                ).then((selectedValue) {
                  if (selectedValue != null) {
                    // Handle the selected menu item (e.g., update sort state)
                    print("Selected: $selectedValue");
                  }
                });
              },
              icon: Row(
                children: [
                  Icon(Icons.sort, color: Colors.white),
                  SizedBox(
                      width: 5), // Adjust the spacing between icon and label
                  Text(
                    'Sort',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
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
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    product.img!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  product.name!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14, fontFamily: 'Lufga', color: Colors.black),
                ),
              ),
              SizedBox(height: 1.5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  '\$${product.price ?? '\$440'}',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Lufga',
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '★ ${product.rating ?? '\$440'}',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontFamily: 'Lufga',
                      fontWeight: FontWeight.w100),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
