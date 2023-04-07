import 'package:troll_e/models/receipt_object_model.dart';

class ReceiptModel {
  final String userID;
  final double tempWeight;
  final ReceiptObject receipt;
  final String UID;

  ReceiptModel({
    required this.userID,
    required this.tempWeight,
    required this.receipt,
    required this.UID,
  });

  static ReceiptModel fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      userID: json['userID'],
      tempWeight: json['tempWeight'] ?? 0,
      receipt: ReceiptObject.fromJson(json['receipt']),
      UID: json['UID'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['tempWeight'] = this.tempWeight;
    data['receipt'] = this.receipt.toJson();
    data['UID'] = this.UID;
    return data;
  }
}