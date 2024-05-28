class Product {
  String img = '';
  String name = '';
  double price = 0;
  int quantity = 0;
  int limit = 0;
  bool isChecked = false;

  Product(this.name, this.price, this.quantity, this.limit, this.img);
  Product.quantity(this.quantity);
}
