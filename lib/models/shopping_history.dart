
import 'package:troll_e/models/receipt_model.dart';

class ShoppingHistory{
  List<ReceiptModel> history = [];

  ShoppingHistory({
     required this.history
});

  static ShoppingHistory fromJson(Map<String, dynamic> json){
    return ShoppingHistory(
      history: (json['receipt'] as List).map((e) =>
          ReceiptModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

   Map<String, dynamic> toJson(){
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['receipt'] = this.history.map((v) => v.toJson()).toList();

    return data;
   }

}