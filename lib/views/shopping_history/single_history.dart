import 'package:flutter/material.dart';
import 'shopping_history.dart';
import 'package:collection/collection.dart';

class SingleHistory extends StatefulWidget {

  Reciept reciept;

  SingleHistory({Key? key, required this.reciept}) : super(key: key);


  @override
  _SingleHistoryState createState() => _SingleHistoryState();
}

class _SingleHistoryState extends State<SingleHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.0),
            onPressed: () => Navigator.pop(context)
        ),
        actions: [
          IconButton(icon: Icon(Icons.more_vert_rounded),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Details'),
                content: const Text('AlertDialog description'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: Text((dateFormat.format(widget.reciept.date)).toString(), style: TextStyle(color: Colors.black),),

        backgroundColor: Color(0xFFBAD3D4),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text("Total: Rs " + widget.reciept.total.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              children: [
                Text("Total Items/ Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text(widget.reciept.products.length.toString() + "/ 10")
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              children: [
                Text("Discount", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text(widget.reciept.products.length.toString())
              ],
            ),
          ),
          SizedBox(height: 25),
          Text("Product Description", style: TextStyle(fontWeight: FontWeight.w600),),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              children: const [
                Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text("Discount", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0) ,
              itemCount: widget.reciept.products.length,
              itemBuilder: (context, index) => Column(
                children: [

                  ListTile(

                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(widget.reciept.products[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    subtitle: Row(
                      children: [
                        Text(widget.reciept.products[index].quantity.toString()),
                        Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text(widget.reciept.products[index].price.toString()),
                        Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text(widget.reciept.products[index].discount.toString()),
                        Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text(widget.reciept.products[index].itemTotal.toString()),
                      ],
                    ),
                  ),
                  Divider(thickness: 1.7, indent: 15, endIndent: 15),
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}
