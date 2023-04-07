import 'Item_model.dart';

class ReceiptObject {
  final double totalWeight;
  final DateTime date;
  final double netTotal;
  final double totalDiscount;
  final double? gst;
  final bool isDeleted;
  final List<ItemModel> items;

  ReceiptObject({
    required this.totalWeight,
    required this.date,
    required this.netTotal,
    required this.totalDiscount,
    required this.isDeleted,
    required this.items,
    this.gst,
  });

  static ReceiptObject fromJson(Map<String, dynamic> json) {
    return ReceiptObject(
      totalWeight: json['totalWeight'],
      date: DateTime.parse(json['date']),
      netTotal: json['netTotal'],
      totalDiscount: json['totalDiscount'],
      gst: json['gst'],
      isDeleted: json['isDeleted'],
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalWeight'] = totalWeight;
    data['date'] = date.toIso8601String();
    data['netTotal'] = netTotal;
    data['totalDiscount'] = totalDiscount;
    data['isDeleted'] = isDeleted;
    data['items'] = items.map((v) => v.toJson()).toList();
    if (gst != null) data['gst'] = gst;
    return data;
  }
}
