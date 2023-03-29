
import 'package:troll_e/models/receipt_model.dart';
import 'package:troll_e/models/shopping_history.dart';

class UserModel {
   String? user_id;
  final String email;
  final String first_name;
  final String last_name;
  final String phone_number;
   String? google_id;
   String password;
   String? image;
   List <ReceiptModel>? shoppingHistory = [];

  UserModel({
    this.user_id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.password,
    required this.phone_number,
     this.shoppingHistory
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      user_id: json['_id'],
        email: json['email'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        password: json['password'],
        phone_number: json['phone_number'],
        shoppingHistory: (json['shoppingHistory']['receipt'] as List).map((e) =>
            ReceiptModel.fromJson(e as Map<String, dynamic>)).toList()
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = this.email;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['password'] = this.password;
    data['phone_number'] = this.phone_number;
    //data['shoppingHistory'] = {'receipt': this.shoppingHistory.map((v) => v.toJson()).toList(),
    //};
    return data;
  }

}