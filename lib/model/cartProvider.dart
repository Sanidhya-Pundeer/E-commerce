import 'package:flutter/material.dart';
import 'package:ecommerce/model/product.dart'; 

class CartProvider with ChangeNotifier {

   int current=0;
  List<Product> cart = [];

  List<Product> pList = [
    Product(
      "Shop Corporate & Casual Backpacks at Upto 74% OFF on Nasher Miles",
      2150.00,
      1,
      5,
      "assets/images/bag1.webp",
      
    ),
    Product(
      "Loupin 18 inch Backpack - Black",
      1899.0,
      1,
      6,
      "assets/images/bag2.png",
     
    ),
    Product(
      "Buy Laptop Backpack for Women Computer",
      4664,
      1,
      10,
      "assets/images/bag3.jpg",
      
    ),
    Product(
      "Lightweight with compartment Waterproof Daypack",
      2499,
      1,
      7,
      "assets/images/bag4.jpg",
      
    ),
    Product(
      "Unicorn Backpack for Children - School Bag for Student, School and Col",
      2199,
      1,
      8,
      "assets/images/bag5.webp",
     
    ),
    Product(
      "Mini Backpack Girls Small Backpack",
      6499,
      1,
      9,
      "assets/images/bag6.webp",
      
    ),
    Product(
      "Leather Backpacks, Travel Backpacks & Laptop Backpacks",
      7300,
      1,
      5,
      "assets/images/bag7.jpg",
     
    ),
    Product(
      "Women Mini Backpack Shoulder Bag PU Leather Backpack",
      3875,
      1,
      8,
      "assets/images/bag8.jpg",
    ),
  ];


 void add(Product product) {
    cart.add(product);
    notifyListeners();
  }

  void increaseQty(int index) {
    try {
      if (cart[index].quantity + 1 > cart[index].limit) {
        throw Exception();
      } else {
        cart[index].quantity += 1;
        notifyListeners();
      }
    } catch (e) {
      throw Exception();
    }
  }

  void decreaseQty(int index) {
    try {
      if (cart[index].quantity - 1 < 0) {
        throw Exception();
      } else {
        cart[index].quantity -= 1;
        notifyListeners();
      }
    } catch (e) {
      throw Exception();
    }
  }

  void delete(int index) {
    cart.removeAt(index);
    notifyListeners();
  }

  void removeAll() {
    cart.clear();
    notifyListeners();
  }
}
