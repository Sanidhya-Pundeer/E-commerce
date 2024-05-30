import 'dart:convert';
import 'package:ecommerce/model/product.dart';
import 'package:http/http.dart' as http;

class Helper {
  final String auth = "real-time-product-search.p.rapidapi.com";
  final String path = 'search';
  final String apiKey = '09cb3dbb1cmsh09bf36e51f75909p162005jsn38d929668579';

  Future<List<Product>> getProducts(String name) async {
    final headers = {'X-RapidAPI-Key': apiKey, 'X-RapidAPI-Host': auth};

    Map<String, dynamic> param = {
      'q': name,
    };

    Map<String, dynamic> data = {};

    try {
      final url = Uri.https(auth, path, param);
      http.Response res=await http.get(url,headers: headers);
      data=jsonDecode(res.body);

      if (res.statusCode == 200) {
        data = jsonDecode(res.body);
        if (data.containsKey('data')) {
          print(data['data'][0]['product_title']);
          final dataContent = data['data'];
          if (dataContent is List) {
            return Product().fromJson(dataContent);
          } else {
            print('Unexpected data content: ${dataContent.runtimeType}');
          }
        } else {
          print('Unexpected response structure: ${res.body}');
        }
      } else {
        print('Failed to load products: ${res.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }


    return [];
  }
}

void main() {
  Helper h = Helper();
  h.getProducts("phone");
}
