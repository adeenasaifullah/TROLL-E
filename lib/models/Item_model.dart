class ItemModel {
 final String productID;
 final num productQuantity;
 final num grossTotal;
 bool isDeleted = false;
  final String productName;
  final String productDescription;

 // String image = "";
  final String barcode;
// Aiman pls add image here

  ItemModel(
      {
       required this.productID,
      required this.grossTotal,
     required this.productQuantity,
     required this.isDeleted,
      required this.productName,
      required this.productDescription,
     required this.barcode,
    //  required this.image
      });

  static ItemModel fromJson(Map<String, dynamic> json) {
    print("entered fromjson itemmodel");
    return ItemModel(
      productDescription: json['productDescription'] as String? ?? '',
       productID: json["productID"] as String? ?? '',
      grossTotal: json["grossTotal"] as num? ?? 0.0,
      barcode: json['barcode'] as String? ?? '',
       productQuantity: json["productQuantity"] as num? ?? 0.0,
       isDeleted: json["isDeleted"] as bool? ?? false,
        productName: json["productName"] as String? ?? '',
     //   image: json['image']
         );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   data['productID'] = productID;
   data['productQuantity'] = productQuantity;
   data['grossTotal'] = grossTotal;
   data['isDeleted'] = isDeleted;
   data['barcode']=barcode;
    data['productName'] = productName;
    data['productDescription'] = productDescription;
   // data['image']=image;
    return data;
  }
}
