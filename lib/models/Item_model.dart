class ItemModel {
  final String productID;
  final int productQuantity;
  final double grossTotal;
  bool isDeleted = false;
  final String productName;
  final String productDescription;
// Aiman pls add image here

  ItemModel(
      {required this.productID,
      required this.grossTotal,
      required this.productQuantity,
      required this.isDeleted,
      required this.productName,
      required this.productDescription});

  static ItemModel fromJson(Map<String, dynamic> json) {
    return ItemModel(
        productID: json["productID"],
        grossTotal: json["grossTotal"],
        productQuantity: json["productQuantity"],
        isDeleted: json["isDeleted"],
        productName: json["productName"],
        productDescription: json["productDescription"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productID'] = productID;
    data['productQuantity'] = productQuantity;
    data['grossTotal'] = grossTotal;
    data['isDeleted'] = isDeleted;
    data['productName'] = productName;
    data['productDescription'] = productDescription;
    return data;
  }
}
