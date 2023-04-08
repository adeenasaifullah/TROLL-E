class ItemModel {
  final String productID;
  final int productQuantity;
  final double grossTotal;
  bool isDeleted = false;

  ItemModel({
    required this.productID,
    required this.grossTotal,
    required this.productQuantity,
    required this.isDeleted,
  });

  static ItemModel fromJson(Map<String, dynamic> json) {
    return ItemModel(
        productID: json["productID"],
        grossTotal: json["grossTotal"],
        productQuantity: json["productQuantity"],
        isDeleted: json["isDeleted"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productID'] = productID;
    data['productQuantity'] = productQuantity;
    data['grossTotal'] = grossTotal;
    data['isDeleted'] = isDeleted;
    return data;
  }
}
