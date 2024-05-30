import 'dart:convert';
import 'package:ecommerce/model/product.dart';
import 'package:http/http.dart' as http;

class Helper {
  final String auth = "real-time-amazon-data.p.rapidapi.com";
  final String path = 'search/';
  final String apiKey = '09cb3dbb1cmsh09bf36e51f75909p162005jsn38d929668579';

  Future<List<Product>> getProducts(String name) async {
    final headers = {'X-RapidAPI-Key': apiKey, 'X-RapidAPI-Host': auth};

    Map<String, dynamic> param = {
      'query': name,
      "page": 1,
      'country': "IN",
    };

    Map<String, dynamic> data = {};

    try {
      final url = Uri.https(auth, path, param);
      http.Response res = await http.get(url, headers: headers);
      data = jsonDecode(res.body);
    } catch (e) {
      print(e);
    }

    Product p = Product();
    List<Product> m = p.fromJson(data['data']['products']);
    print(m.cast);
    return m;
  }
}

void main() {
  Helper h = Helper();
  // h.getMovie('Barbie', 'us', 'en');
}
