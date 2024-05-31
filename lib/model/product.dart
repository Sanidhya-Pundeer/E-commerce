class Product {
  String? id;
  String? name;
  String? price;
  double? rating;
  int? numRate;
  String? img;
  String? desc;
  String? delivery;
  int? qty;

  Product();

  List<Product> fromJson(List<dynamic> list) {
    List<Product> products = [];
    for (var item in list) {
      if (item is Map<String, dynamic>) {
        Product p = Product();
        if (item['typical_price_range']==null) {
          continue;
        }
        p.id = item['product_id'] as String?;
        p.name = (item['product_title'] as String?)?.split(',')[0];
        p.price = (item['typical_price_range'] as List<dynamic>?)?[0] as String?;
        p.rating = (item['product_rating'] as num?)?.toDouble();
        p.numRate = item['product_num_reviews'] as int?;
        p.img = (item['product_photos'] as List<dynamic>?)?.first as String?;
        p.desc = item['product_description'] as String?;
        p.delivery = item['offer']?['shipping'] as String?;
        products.add(p);
      } else {
        print('Unexpected item type in products list: ${item.runtimeType}');
      }
    }
    return products;
  }

  List<Product> fromJsonFilter3(List<dynamic> list) {
    List<Product> products = [];
    for (var item in list) {
      if (item is Map<String, dynamic>) {
        Product p = Product();
        if (item['typical_price_range']==null && (item['product_rating']==null || item['product_rating']<3.0)) {
          continue;
        }
        p.id = item['product_id'] as String?;
        p.name = (item['product_title'] as String?)?.split(',')[0];
        p.price = (item['typical_price_range'] as List<dynamic>?)?[0] as String?;
        p.rating = (item['product_rating'] as num?)?.toDouble();
        p.numRate = item['product_num_reviews'] as int?;
        p.img = (item['product_photos'] as List<dynamic>?)?.first as String?;
        p.desc = item['product_description'] as String?;
        p.delivery = item['offer']?['shipping'] as String?;
        products.add(p);
      } else {
        print('Unexpected item type in products list: ${item.runtimeType}');
      }
    }
    return products;
  }

  List<Product> fromJsonFilter4(List<dynamic> list) {
    List<Product> products = [];
    for (var item in list) {
      if (item is Map<String, dynamic>) {
        Product p = Product();
        if (item['typical_price_range']==null && (item['product_rating']==null || item['product_rating']<4.0)) {
          continue;
        }
        p.id = item['product_id'] as String?;
        p.name = (item['product_title'] as String?)?.split(',')[0];
        p.price = (item['typical_price_range'] as List<dynamic>?)?[0] as String?;
        p.rating = (item['product_rating'] as num?)?.toDouble();
        p.numRate = item['product_num_reviews'] as int?;
        p.img = (item['product_photos'] as List<dynamic>?)?.first as String?;
        p.desc = item['product_description'] as String?;
        p.delivery = item['offer']?['shipping'] as String?;
        products.add(p);
      } else {
        print('Unexpected item type in products list: ${item.runtimeType}');
      }
    }
    return products;
  }

   Product fromMap(Map<String, dynamic> map) {
     Product p=Product();
      p.id = ['product_id'] as String;
      p.name = ( ['product_title'] as String?)?.split(',')[0];
      p.price = ( ['typical_price_range'] as List<dynamic>?)?[0] as String?;
      p.rating = ( ['product_rating'] as num?)?.toDouble();
      p.numRate =  ['product_num_reviews'] as int?;
      p.img = ( ['product_photos'] as List<dynamic>?)?.first as String?;
      p.desc =  ['product_description'] as String?;
      return p;
  }

 Product fromMapCart(Map<String, dynamic> map) {
  // Assuming the top-level key is a product ID (can be adjusted if needed)
  print(map.toString());

  if (map != null && map is Map<String, dynamic>) {
    // Extract product details from the nested map
    Product p=Product();
    p.img = map['pimg'] as String;
    p.name = map['pname'] as String;
    p.qty = map['pqty']?? 0; // Handle potential parsing errors
    return p;
  } else {
    // Handle invalid data structure (optional)
    throw Exception('Invalid product data format');
  }
}
}
