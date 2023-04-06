import 'Item_model.dart';

class ReceiptModel{
  final DateTime date;
  final double netTotal;
  final double totalDiscount;
 // final double gst;
   bool isDeleted = false;
   List <ItemModel>? items = [];
   final double totalWeight;
   final double tempWeight;

   ReceiptModel( {
    required this.date,
     required this.netTotal,
     required this.totalDiscount,
  //   required this.gst,
     required this.items,
     required this.totalWeight,
     required this.tempWeight,
});

   static ReceiptModel fromJson(Map<String, dynamic> json){
     return ReceiptModel(
       date: json['tempreceipt']['receipt']['date'],
       netTotal: json['tempreceipt']['receipt']['netTotal'],
       totalDiscount: json['tempreceipt']['receipt']['totalDiscount'],
       totalWeight: json['tempreceipt']['receipt']['totalWeight'],
       tempWeight: json['tempreceipt']['tempWeight'],
       items: (json['tempreceipt']['receipt']['items'] as List)
           .map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
           .toList(),
        // json['Routines'] as List).map((e) => RoutineModel.fromJson(e as Map<String, dynamic>)).toList(),
         // date: json['date'],
         // netTotal: json['netTotal'],
         // totalDiscount: json['totalDiscount'],
         // //gst: json['gst'],
         // totalWeight: json["totalWeight"],
         // tempWeight:json["tempWeight"],
         // items: (json['items']as List).map((e) => ItemModel.fromJson(e as Map<String, dynamic>)).toList(),
         //
     );
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['date'] = this.date;
     data['netTotal'] = this.netTotal;
     data['totalDiscount'] = this.totalDiscount;
    // data['gst'] = this.gst;
     data["tempWeight"]=this.tempWeight;
     data["totalWeight"]=this.totalWeight;
     data['items'] = this.items?.map((v) => v.toJson()).toList();

     return data;
   }

}