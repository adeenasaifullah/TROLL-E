class ItemModel {
 final String productID;
 final int productQuantity;
 final double grossTotal;
 bool isDeleted = false;
  final String productName;
  final String productDescription;

 // String image = "";
  //String barcode;
// Aiman pls add image here

  ItemModel(
      {
       required this.productID,
      required this.grossTotal,
     required this.productQuantity,
     required this.isDeleted,
      required this.productName,
      required this.productDescription,
    //  required this.barcode,
    //  required this.image
      });

  static ItemModel fromJson(Map<String, dynamic> json) {
    print("entered fromjson itemmodel");
    return ItemModel(
      productDescription: json['productDescription'],
       productID: json["productID"],
      grossTotal: json["grossTotal"],
    //   barcode: json['barcode'],
       productQuantity: json["productQuantity"],
       isDeleted: json["isDeleted"],
        productName: json["productName"],
     //   image: json['image']
         );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   data['productID'] = productID;
   data['productQuantity'] = productQuantity;
   data['grossTotal'] = grossTotal;
   data['isDeleted'] = isDeleted;
    data['productName'] = productName;
    data['productDescription'] = productDescription;
   // data['image']=image;
    return data;
  }
}
