import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:troll_e/models/receipt_object_model.dart';
import '../../utility.dart';
import 'shopping_history.dart';
import 'package:collection/collection.dart';

class SingleHistory extends StatefulWidget {
  ReceiptObject? reciept;

  SingleHistory({Key? key,  this.reciept}) : super(key: key);

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
            textValue: ((DateFormat.yMMMMEEEEd().format(widget.reciept!.date)).toString()),
            size: 20.sp),
        backgroundColor: const Color(0xFFBAD3D4),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              "Total: Rs ${widget.reciept?.netTotal}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              children: [
                const Text(
                  "Total Items",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text("${widget.reciept?.items.length}")
              ],
            ),
          ),
           SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              children: [
                const Text("Discount",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text(widget.reciept!.totalDiscount.toString())
              ],
            ),
          ),
          const SizedBox(height: 25),
          Container(
              width: double.infinity,
              height: 320.h,
              //color: Colors.black12,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Product Description",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Product",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Quantity",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Price",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Gross Total",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        itemCount: widget.reciept?.items.length,
                        itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  widget.reciept!.items[index].productDescription.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.reciept!.items[index].productName.toString(),
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  Text(widget.reciept!.items[index].productQuantity.toString(),
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  Text(widget.reciept!.items[index].price.toString(),
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  Text(widget.reciept!.items[index].grossTotal.toString(),
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1.7,
                              indent: 15,
                              endIndent: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] ) ),
          // const Text(
          //   "Product Description",
          //   style: TextStyle(fontWeight: FontWeight.w600),
          // ),
          // const SizedBox(height: 25),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15.0, right: 15),
          //   child: Row(
          //     children: const [
          //       Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
          //       Spacer(
          //         flex: 2, // <-- SEE HERE
          //       ),
          //       Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
          //       Spacer(
          //         flex: 2, // <-- SEE HERE
          //       ),
          //       Text("Discount", style: TextStyle(fontWeight: FontWeight.bold)),
          //       Spacer(
          //         flex: 2, // <-- SEE HERE
          //       ),
          //       Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
          //       Spacer(
          //         flex: 2, // <-- SEE HERE
          //       ),
          //     ],
          //   ),
          // ),
          // Expanded(
          //   child: ListView.builder(
          //     padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          //     itemCount: widget.reciept?.items.length,
          //     itemBuilder: (context, index) => Column(
          //       children: [
          //         ListTile(
          //           title: Padding(
          //             padding: const EdgeInsets.only(bottom: 8.0),
          //             child: Text(widget.reciept!.items[index].productName,
          //                 style: TextStyle(fontWeight: FontWeight.bold)),
          //           ),
          //           subtitle: Row(
          //             children: [
          //               Text(
          //                   widget.reciept!.items[index].productQuantity.toString()),
          //               const Spacer(
          //                 flex: 2, // <-- SEE HERE
          //               ),
          //               //WE NEED TO ADD PRODUCT KI PRICE
          //               Text(widget.reciept!.items[index].price.toString()),
          //               const Spacer(
          //                 flex: 2, // <-- SEE HERE
          //               ),
          //               Text(
          //                 //WE NEED TO ADD PRODUCT KA DISCOUNT
          //                   'DISCOUNT'),
          //               const Spacer(
          //                 flex: 2, // <-- SEE HERE
          //               ),
          //               Text(widget.reciept!.items[index].grossTotal
          //                   .toString()),
          //             ],
          //           ),
          //         ),
          //         const Divider(thickness: 1.7, indent: 15, endIndent: 15),
        //        ],
          //    ),
           // ),
      //    ),
        ],
      ),
    );
  }
}
