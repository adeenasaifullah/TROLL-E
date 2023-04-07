import 'package:troll_e/models/temp_receipt_model.dart';
import 'package:troll_e/models/shopping_history.dart';
import 'package:troll_e/models/shopping_history.dart';

class UserModel {
  String? userId;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  String? googleId;
  String password;
  String? image;
  var shoppingHistory;

  UserModel({
    this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
    this.shoppingHistory,
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    if (json['shoppingHistory'] != null) {
      ShoppingHistoryModel.fromJson(json['shoppingHistory']);
    }

    return UserModel(
        userId: json['_id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        password: json['password'],
        phoneNumber: json['phone_number'],
        shoppingHistory: json['shoppingHistory']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['password'] = password;
    data['phone_number'] = phoneNumber;
    //data['shoppingHistory'] = {'receipt': this.shoppingHistory.map((v) => v.toJson()).toList(),
    //};
    return data;
  }
}
