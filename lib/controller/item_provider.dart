
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:troll_e/models/Item_model.dart';

class itemprovider extends ChangeNotifier{
  List<ItemModel> _itemlist = [];

  UnmodifiableListView<ItemModel> get items {
    return UnmodifiableListView(_itemlist);
  }

   void totalweight(){
    //calculate the total weight of all the items
   }

   void total(){
    // calculate the total amount of all the items
   }
}