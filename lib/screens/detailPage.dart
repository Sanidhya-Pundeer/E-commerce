import 'package:ecommerce/model/cartProvider.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/model/userProvider.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/services/userOperations.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/screens/checkout.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  UserOperations operate = UserOperations();
  late int qty;
  int? c;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void didChangeDependencies() async {
    super.didChangeDependencies();
    int b =
        await operate.getCartQuantity(widget.product.id!, "chomu@gmail.com");
    setState(() {
      qty = b;
    });
  }

  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<userProvider>(context);
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
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Checkout(
                      userEmail: "chomu@gmail.com",
                    ),
                  ),
                );
              },
              icon: Icon(Icons.trolley),
              iconSize: 32,
            )
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                widget.product.img!,
                height: 400,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price: ${widget.product.price}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${widget.product.desc}",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Product Details:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Product Dimensions: 18 x 30 x 48 cm; 600 g\n'
                      'Date First Available: 7 May 2021\n'
                      'Manufacturer: Fur Jaden\n'
                      'ASIN: B094DGXXR5\n'
                      'Item model number: BM81\n'
                      'Country of Origin: India\n'
                      'Department: unisex-adult',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: _isFavorite
                  ? Icon(Icons.favorite_rounded, color: Colors.red)
                  : Icon(Icons.favorite_outline_rounded),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),
            IconButton(
                icon: Icon(Icons.remove),
                onPressed: () async {
                  if (qty == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Product not in Cart"),
                      duration: Duration(milliseconds: 1500),
                    ));
                  }
                  int b;
                  if (qty == 1) {
                    await operate.removeProductFromCart(
                        widget.product.id!, "chomu@gmail.com");
                    b = 0;
                  } else {
                    int a = await operate.decreaseProductQuantity(
                        widget.product.id!, "chomu@gmail.com");
                    b = await operate.getCartQuantity(
                        widget.product.id!, "chomu@gmail.com");
                  }

                  setState(() {
                    qty = b;
                  });
                }),
            Text(
              '${qty}',
              style: TextStyle(fontSize: 18),
            ),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  int a = await operate.updateProductQuantity(
                      widget.product.id!, "chomu@gmail.com");
                  int? b = await operate.getCartQuantity(
                      widget.product.id!, "chomu@gmail.com");
                  setState(() {
                    qty = b!;
                  });
                }),
            ElevatedButton(
              onPressed: () async {
                if (qty >= 1) {
                  return;
                }

                // Null checks and default handling
                // if ( provider.email == null) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Product details or email are missing."),
                //       duration: Duration(milliseconds: 1500),
                //     ),
                //   );
                //   return;
                // }

                try {
                  int result = await operate.updateCart(
                    widget.product.id!,
                    widget.product.name!,
                    widget.product.img!,
                    "chomu@gmail.com",
                  );
                  int? b = await operate.getCartQuantity(
                      widget.product.id!, "chomu@gmail.com");
                  setState(() {
                    qty = b!;
                  });

                  if (result == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Added to Cart"),
                        duration: Duration(milliseconds: 1500),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Couldn't be added"),
                        duration: Duration(milliseconds: 1500),
                      ),
                    );
                  }
                } catch (e) {
                  // Handle any exceptions that might occur during the updateCart operation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("An error occurred: $e"),
                      duration: Duration(milliseconds: 1500),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}
