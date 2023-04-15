import 'package:flutter/material.dart';
import 'package:troll_e/utility.dart';

class SecondScan{

  final TextEditingController increase_qty = TextEditingController();
  final TextEditingController decrease_qty = TextEditingController();
  showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'What would you like to do?',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            "Do you want to increase or decrease the item quantity?",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      primary: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // close the previous dialog box
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Enter Quantity to Increase",style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),),
                            actions: <Widget>[
                              TextFormField(
                                controller: increase_qty,
                                decoration: InputDecoration(
                                  fillColor: const Color(0xFFF4F1F1),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(width: 6,  color: Color(0xFFF4F1F1)),
                                  ),
                                ),
                              ),
                              SizedBox( height: 20,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Future.delayed(Duration(seconds: 1), () {
                                        Navigator.of(context).pop();
                                      });
                                      return const AlertDialog(
                                        title: Text("Quantity Increased!"),
                                      );
                                    },
                                  );
                                },
                                child: const Text("Save",
                                  style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Increase'),
                  ),

                  const SizedBox(width: 16),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      primary: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      //need to check if item qty is one or not
                      //if one then directly remove and show prompt that Item Removed!
                      //else ask for quantity to decrease
                    },
                    child: const Text('Decrease'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
