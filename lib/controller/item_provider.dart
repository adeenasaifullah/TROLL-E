
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:troll_e/models/item_model.dart';

class itemprovider extends ChangeNotifier{
  List<Items> _itemlist = [];

  UnmodifiableListView<Items> get items {
    return UnmodifiableListView(_itemlist);
  }

   void totalweight(){
    //calculate the total weight of all the items
   }

   void total(){
    // calculate the total amount of all the items
   }
}