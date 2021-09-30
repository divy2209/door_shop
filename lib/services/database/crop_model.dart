class Crop {
  final String identifier;
  final String name;
  final int price;
  final int quantity;
  final String unit;
  final int discount;
  final String url;

  Crop({this.identifier, this.name, this.price, this.quantity, this.unit, this.discount, this.url});
}

class CartCrop{
  final String identifier;
  final String name;
  final int price;
  final int quantity;
  final String unit;
  final int discount;
  final String url;
  int count;
  final int dPrice;

  CartCrop({this.identifier, this.name, this.price, this.quantity, this.unit, this.discount, this.url, this.count, this.dPrice});
}