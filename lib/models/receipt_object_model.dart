import 'Item_model.dart';

class ReceiptObject {
   num totalWeight;
  final DateTime date;
   num netTotal;
   num totalDiscount;
  final num? gst;
  final bool isDeleted;
   List<ItemModel> items;

  ReceiptObject({
    required this.totalWeight,
    required this.date,
    required this.netTotal,
    required this.totalDiscount,
    required this.isDeleted,
    required  this.items,
    this.gst,
  });

  static ReceiptObject fromJson(Map<String, dynamic> json) {
    print("entered fromjson receipt object");
    // List<ItemModel> items = List.from(json['items'])
    //     .map((itemJson) => ItemModel.fromJson(itemJson))
    //     .toList();
    //print(items[0].productName);
    //print(items[0].productDescription);

    print("called list item model in receipt object");
    return ReceiptObject(
      totalWeight: json['totalWeight'] as num? ?? 0.0,
      date:DateTime.tryParse(json['date']) ?? DateTime.now(),
      netTotal: json['netTotal'] as num? ?? 0.0,
      totalDiscount: json['totalDiscount'] as num? ?? 0.0,
      gst: json['gst'] as num? ?? 0.0,
      isDeleted: json['isDeleted'] as bool? ?? false,
      items: List.from(json['items'])
          .map((itemJson) => ItemModel.fromJson(itemJson))
          .toList() ?? []

      //  items: (json['items'] as List<Map<String, dynamic>>?)?.map((e) => Items.fromJson(e)).toList() ?? [],

      // (json['items'] as List<dynamic>)
      //     .map((e) => ItemModel.fromJson(e))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalWeight'] = totalWeight;
    data['date'] = date.toIso8601String();
    data['netTotal'] = netTotal;
    data['totalDiscount'] = totalDiscount;
    data['isDeleted'] = isDeleted;
 //   data['items'] = items.map((v) => v.toJson()).toList();
   // if (gst != null) data['gst'] = gst;
    return data;
  }
}
