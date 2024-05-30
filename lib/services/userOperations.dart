import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/UserClass.dart';
import 'package:ecommerce/model/userProvider.dart';
import 'package:ecommerce/screens/detailPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class UserOperations {
  // Step 1: Create an instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //register
  Future<int> add(UserClass user) async {
    // If registration is successful
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.usermail, password: user.password);
      print("done");
      return 1;
      // throws exception in case of failure & returns registration failed message
    } catch (e) {
      print("no");
      return 0;
    }
  }

  //login
  Future<int> login(UserClass user) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: user.usermail, password: user.password);
      print("Login successful");
      return 1;
    } catch (e) {
      print("error");
      return 0;
    }
  }

  Future<int> create(UserClass user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection("users").add(user.toMap());
      print("Created");
      return 1;
    } catch (e) {
      print("Noo");
      return 0;
    }
  }

  // Update cart
  Future<void> addProductToCart(String name, String img, String email) async {
    final cartRef =
        firestore.collection('users').where("email", isEqualTo: email).get();

    final newProduct = {
      'pname': name,
      'pimg': img,
      'pqty': 1,
    };

    try {
      
        if ) {
          final cartData =
              snapshot.data()?['cart'] as Map<String, dynamic>? ?? {};
          cartData[productId] = newProduct;

          transaction.update(cartRef, {'cart': cartData});
        } else {
          transaction.set(cartRef, {
            'cart': {productId: newProduct}
          });
        }
      });

      print('Product added to cart');
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }
}
