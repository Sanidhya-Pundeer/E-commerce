import 'package:ecommerce/model/UserClass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserOperations {
  // Step 1: Create an instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //register
  Future<String> add(UserClass user) async {
    // If registration is successful
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.username, password: user.password);
      print("done");
      return "Reg";
      // throws exception in case of failure & returns registration failed message
    } catch (e) {
      print("no");
      return "no";
    }
    }
    
  
  //login
  Future<int> login(String username, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: username, password: password);
       print("Login successful");
      return 1;
    } catch (e) {
      print("error");
      return 0;
    }
    }

  //change password
  update() {}

  //Accound deactivate
  remove() {}
}
