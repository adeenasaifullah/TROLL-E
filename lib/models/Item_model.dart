class ItemModel {
  final String name;
  final String description;
  final String quantity;
  final String SKU;
  final String barcode;
  final double Weight;
  final double price;
  final double discount;

  ItemModel(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.SKU,
      required this.barcode,
      required this.Weight,
      required this.price,
      required this.discount});

  static ItemModel fromJson(Map<String, dynamic> json) {
    return ItemModel(
        name: json['name'],
        description: json['description'],
        quantity: json['quantity'],
        SKU: json['SKU'],
        barcode: json['barcode'],
        Weight: json['weight'],
        price: json['price'],
        discount: json['discount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['SKU'] = this.SKU;
    data['barcode'] = this.barcode;
    data['weight'] = this.Weight;
    data['price'] = this.price;
    data['discount'] = this.discount;

    return data;
  }
}
