class ItemModel {
  final String productID;
  final int productQuantity;
  final double grossTotal;
  bool isDeleted = false;
  final String productName;
  final String productDescription;
  String image = "";
// Aiman pls add image here

  ItemModel(
      {required this.productID,
      required this.grossTotal,
      required this.productQuantity,
      required this.isDeleted,
      required this.productName,
      required this.productDescription,
      required this.image});

  static ItemModel fromJson(Map<String, dynamic> json) {
    return ItemModel(
        productID: json["productID"],
        grossTotal: json["grossTotal"],
        productQuantity: json["productQuantity"],
        isDeleted: json["isDeleted"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        image: json['image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productID'] = productID;
    data['productQuantity'] = productQuantity;
    data['grossTotal'] = grossTotal;
    data['isDeleted'] = isDeleted;
    data['productName'] = productName;
    data['productDescription'] = productDescription;
    data['image']=image;
    return data;
  }
}
