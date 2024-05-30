import 'package:ecommerce/services/userOperations.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {

  UserOperations operate=UserOperations();
  late int length;

  CartProvider(){
    length=0;
  }

  void getCartLength(String email) async{
    length=await operate.getCartLength(email);
    notifyListeners();
  }


}
