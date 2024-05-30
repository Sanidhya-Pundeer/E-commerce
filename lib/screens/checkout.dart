import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/razorPay.dart';
import 'package:ecommerce/services/userOperations.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/model/cartProvider.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  final String userEmail; // Pass user email for cart retrieval

  Checkout({required this.userEmail});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late int qty;
  UserOperations operate=UserOperations();
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

  Widget _buildCartItem(BuildContext context, Map<String, dynamic> productData, int index) {
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
              onPressed: () async{
              if (qty==0) {
                ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Product not in Cart"),
                              duration: Duration(milliseconds: 1500),
                            ));
              }
              int b;
              if(qty==1){
                await operate.removeProductFromCart(product.id!, "chomu@gmail.com");
                b=0;
              }
              else{
              int a=await operate.decreaseProductQuantity(product.id!, "chomu@gmail.com");
              b=await operate.getCartQuantity(product.id!, "chomu@gmail.com");}

              setState(() {
                qty=b;
              });
              
            } 
            ),
            Text(
              '${product.qty}',
              style: TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async{
              int a=await operate.updateProductQuantity(product.id!, "chomu@gmail.com");
              int? b=await operate.getCartQuantity(product.id!, "chomu@gmail.com");
              setState(() {
                qty=b;
              });
            }
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
        // ... (rest of app bar code)
      ),
      body: StreamBuilder<QuerySnapshot>(
        child: ListView.builder(
          itemCount: cartProducts.length, // Use cartProducts list
          itemBuilder: (context, index) {
            return _buildCartItem(context, cartProducts[index], index);
          },
        ),
      ),
      // ... (rest of checkout page code)
    );
  }
}
