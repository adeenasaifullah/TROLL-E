import 'Item_model.dart';

class ReceiptModel{
  final DateTime date;
  final double netTotal;
  final double totalDiscount;
  final double gst;
   bool isDeleted = false;
   List <ItemModel>? items = [];

   ReceiptModel({
    required this.date,
     required this.netTotal,
     required this.totalDiscount,
     required this.gst,
     required this.items
});

   static ReceiptModel fromJson(Map<String, dynamic> json){
     return ReceiptModel(
         date: json['date'],
         netTotal: json['netTotal'],
         totalDiscount: json['totalDiscount'],
         gst: json['gst'],
         items: (json['items']as List).map((e) => ItemModel.fromJson(e as Map<String, dynamic>)).toList(),
     );
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['date'] = this.date;
     data['netTotal'] = this.netTotal;
     data['totalDiscount'] = this.totalDiscount;
     data['gst'] = this.gst;
     data['items'] = this.items?.map((v) => v.toJson()).toList();

     return data;
   }

}