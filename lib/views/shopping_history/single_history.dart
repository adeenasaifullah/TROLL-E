import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utility.dart';
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
          icon:
              const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.0),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
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
        title: Roboto_heading(
            textValue: (dateFormat.format(widget.reciept.date)).toString(),
            size: 20.sp),
        backgroundColor: const Color(0xFFBAD3D4),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              "Total: Rs ${widget.reciept.total}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              children: [
                const Text(
                  "Total Items/ Quantity",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text("${widget.reciept.products.length}/ 10")
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              children: [
                const Text("Discount",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text(widget.reciept.products.length.toString())
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "Product Description",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 25),
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
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              itemCount: widget.reciept.products.length,
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(widget.reciept.products[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                            widget.reciept.products[index].quantity.toString()),
                        const Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text(widget.reciept.products[index].price.toString()),
                        const Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text(
                            widget.reciept.products[index].discount.toString()),
                        const Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text(widget.reciept.products[index].itemTotal
                            .toString()),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1.7, indent: 15, endIndent: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
