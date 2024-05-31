import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/razorPay.dart';
import 'package:ecommerce/services/userOperations.dart';
import 'package:ecommerce/model/cartProvider.dart';

class Checkout extends StatefulWidget {
  final String userEmail; // Pass user email for cart retrieval

  Checkout({required this.userEmail});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  UserOperations operate = UserOperations();
  List<Map<String, dynamic>> cartProducts = []; // Initialize empty list

  @override
  void initState() {
    super.initState();
    _getCartProducts(); // Fetch cart products on page load
  }

  Future<void> _getCartProducts() async {
    try {
      final fetchedProducts = await operate.getCartProducts(widget.userEmail);

      setState(() {
        cartProducts = fetchedProducts;
      });
    } catch (error) {
      print("Error getting cart products: $error");
      // Handle potential errors (e.g., show a snackbar)
    }
  }

  Widget _buildCartItem(
      BuildContext context, Map<String, dynamic> productData, int index) {
    final product = Product().fromMap(productData);

    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          product.img!,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(product.name!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () async {
                if (product.qty == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Product not in Cart"),
                      duration: Duration(milliseconds: 1500),
                    ),
                  );
                } else {
                  if (product.qty == 1) {
                    await operate.removeProductFromCart(
                        product.id!, widget.userEmail);
                  } else {
                    await operate.decreaseProductQuantity(
                        product.id!, widget.userEmail);
                  }
                  _getCartProducts(); // Refresh cart products
                }
              },
            ),
            Text(
              '${product.qty}',
              style: TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await operate.updateProductQuantity(
                    product.id!, widget.userEmail);
                _getCartProducts(); // Refresh cart products
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: ListView.builder(
        itemCount: cartProducts.length, // Use cartProducts list
        itemBuilder: (context, index) {
          return _buildCartItem(context, cartProducts[index], index);
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RazorPay()),
            );
          },
          child: Text("Proceed to Payment"),
        ),
      ),
    );
  }
}

// Placeholder for Product class
// class Product {
//   String? id;
//   String? name;
//   String? img;
//   int qty;

//   Product({this.id, this.name, this.img, this.qty = 1});

//   Product fromMap(Map<String, dynamic> map) {
//     return Product(
//       id: map['id'],
//       name: map['name'],
//       img: map['img'],
//       qty: map['qty'],
//     );
//   }
// }

// Placeholder for UserOperations class
// class UserOperations {
//   Future<List<Map<String, dynamic>>> getCartProducts(String email) async {
//     // Implement the logic to fetch cart products from Firestore or any other source
//     // Example: return a list of product maps
//     return [];
//   }

//   Future<void> updateProductQuantity(String productId, String email) async {
//     // Implement the logic to increase product quantity in the cart
//   }

//   Future<void> decreaseProductQuantity(String productId, String email) async {
//     // Implement the logic to decrease product quantity in the cart
//   }

//   Future<void> removeProductFromCart(String productId, String email) async {
//     // Implement the logic to remove the product from the cart
//   }
// }

// Placeholder for RazorPayScreen class
class RazorPayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RazorPay Payment"),
      ),
      body: Center(
        child: Text("RazorPay Payment Integration"),
      ),
    );
  }
}
