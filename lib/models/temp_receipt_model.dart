import 'package:troll_e/models/receipt_object_model.dart';

class TempReceiptModel {
  final String userID;
  final double tempWeight;
  var receipt;
  final String uid;

  TempReceiptModel({
    required this.userID,
    required this.tempWeight,
    required this.receipt,
    required this.uid,
  });

  static TempReceiptModel fromJson(Map<String, dynamic> json) {
    if (json['receipt'] != null) {
      ReceiptObject.fromJson(json['receipt']);
    }
    return TempReceiptModel(
      userID: json['userID'],
      tempWeight: json['tempWeight'] ?? 0.0,
      receipt: json['receipt'],
      uid: json['UID'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['tempWeight'] = tempWeight;
    data['receipt'] = receipt.toJson();
    data['UID'] = uid;
    return data;
  }
}
