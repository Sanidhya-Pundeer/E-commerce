class Product {
  String? id;
  String? name;
  String? price;
  String? offerPrice;
  double? rating;
  int? numRate;
  String? img;
  String? desc;
  String? delivery;

  Product();

  List<Product> fromJson(List<dynamic> list) {
    List<Product> products = [];
    for (var item in list) {
      if (item is Map<String, dynamic>) {
        Product p = Product();
        p.id = item['product_id'] as String?;
        p.name = (item['product_title'] as String?)?.split(',')[0];
        p.price = (item['typical_price_range'] as List<dynamic>?)?[1] as String?;
        p.offerPrice = (item['typical_price_range'] as List<dynamic>?)?[0] as String?;
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
