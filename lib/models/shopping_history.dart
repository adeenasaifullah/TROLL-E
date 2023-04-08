import 'package:troll_e/models/temp_receipt_model.dart';
import 'package:troll_e/models/receipt_object_model.dart';

class ShoppingHistoryModel {
  List<ReceiptObject> receipts = [];

  ShoppingHistoryModel({required this.receipts});

  static ShoppingHistoryModel fromJson(Map<String, dynamic> json) {
    return ShoppingHistoryModel(
      receipts: (json['receipt'] as List)
          .map((e) => ReceiptObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receipt'] = receipts.map((v) => v.toJson()).toList();

    return data;
  }
}
