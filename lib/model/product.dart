class Product {
  String? id;
  String? name;
  String? price;
  String? offerPrice;
  String? rating;
  int? numRate;
  String? img;
  String? desc;
  String? delivery;

  Product();

  List<Product> fromJson(List<dynamic> list) {
    List<Product> l = [];
    for (dynamic i in list) {
      Product p = Product();
      p.id = i['asin'];
      p.name = i['product_title'].split(',')[0];
      p.price = i['product_price'];
      p.offerPrice = i['product_minimum_offer_price'];
      p.rating = i['product_star_rating'];
      p.numRate = i['product_num_ratings'];
      p.img = i['product_photo'];
      p.desc = i['product_title'];
      p.delivery = i['delivery'];
      l.add(p);
    }
    return l;
  }
}
