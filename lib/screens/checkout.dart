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

  Widget _buildCartItem(BuildContext context,Map<String, dynamic> productData,int index,) {
  
  final product = Product().fromMapCart(productData);
  
  return Card(
    margin: EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: const Color.fromARGB(255, 54, 53, 53),
        
        leading: product.img != null
            ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  product.img!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
            )
            : Placeholder( // Display a placeholder if image is null
                child: Container(
                  color: Color.fromARGB(255, 1, 0, 0),
                  width: 80,
                  height: 80,
                ),
              ),
        title: Text(product.name!,style: TextStyle(fontFamily: "Lufga",fontSize: 14,color: Colors.white),),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              Text(
                '${product.qty}',
                style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: "Lufga"),
              ),
              
            ],
          ),
        ),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
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
          style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          minimumSize: Size(290, 45),
                        ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RazorPay()),
            );
          },
          child: Text("Proceed to Payment",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}


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
