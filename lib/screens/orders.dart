import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/razorPay.dart';
import 'package:ecommerce/services/userOperations.dart';
import 'package:ecommerce/model/cartProvider.dart';

class Orders extends StatefulWidget {
  final String userEmail; // Pass user email for cart retrieval

  Orders({required this.userEmail});

  @override
  _Orders createState() => _Orders();
}

class _Orders extends State<Orders> {
  UserOperations operate = UserOperations();
  List<Map<String, dynamic>> cartProducts = []; // Initialize empty list

  @override
  void initState() {
    super.initState();
    _getOrders(); // Fetch cart products on page load
  }

  Future<void> _getOrders() async {
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
      padding: EdgeInsets.all(8.0),
      child: ListTile(
         tileColor: Color.fromARGB(255, 50, 49, 49),
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
                  color: Colors.grey[200],
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
                style: TextStyle(fontSize: 18,fontFamily: "Lufga",color: Colors.white),
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
        title: Text("Orders"),
      ),
      body: ListView.builder(
        itemCount: cartProducts.length, // Use cartProducts list
        itemBuilder: (context, index) {
          return _buildCartItem(context, cartProducts[index], index);
        },
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
