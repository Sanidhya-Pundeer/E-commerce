import 'package:flutter/material.dart';

class userProvider extends ChangeNotifier {
  String? email;
  String? name;

  void setValue(String uemail, String uname) {
    email = uemail.toLowerCase();
    name = uname.toLowerCase();
    notifyListeners();
  }

  void removeValue() {
    email = '';
    name = '';
    notifyListeners();
  }
}
