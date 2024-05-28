import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/model/cartProvider.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
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
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return ListView.builder(
            itemCount: cartProvider.cart.length,
            itemBuilder: (context, index) {
              final product = cartProvider.cart[index];
              if (product.quantity > 0) {
                return _buildCartItem(context, product, index);
              } else {
                Provider.of<CartProvider>(context, listen: false).delete(index);
                return Container();
              }
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all( 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 206, 46, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Buy Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).removeAll();
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 228, 213, 210),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                ),
                child: Text(
                  'Remove All',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCartItem(BuildContext context, Product product, int index) {
  return Card(
    margin: EdgeInsets.all(8.0),
    child: ListTile(
      leading: Image.asset(
        product.img,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      title: Text(product.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .decreaseQty(index);
            },
          ),
          Text(
            '${product.quantity}',
            style: TextStyle(fontSize: 18),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .increaseQty(index);
              final maxQuantity = product.limit;
              if (product.quantity >= maxQuantity) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Max quantity is $maxQuantity'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}
