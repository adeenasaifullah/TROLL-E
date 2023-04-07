class ItemModel {
 final String productID;
 final num productQuantity;
 final double grossTotal;
  bool isDeleted=false;


  ItemModel(
      {
        required this.productID,
        required this.grossTotal,
        required this.productQuantity,
        required this.isDeleted,

      });

  static ItemModel fromJson(Map<String, dynamic> json) {
    return ItemModel(
        productID :json["productID"],
        grossTotal: json["grossTotal"],
        productQuantity:json["productQuantity"],
        isDeleted:json["isDeleted"]

    );
  }


Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['productID']=this.productID;
  data['productQuantity']=this.productQuantity;
  data['grossTotal']=this.grossTotal;
  data['isDeleted']=this.isDeleted;
  return data;
}

}
