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
}
