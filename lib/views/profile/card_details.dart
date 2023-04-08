import "package:flutter_credit_card/credit_card_form.dart";
import "package:flutter_credit_card/credit_card_model.dart";
import "package:flutter_credit_card/flutter_credit_card.dart";
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:troll_e/utility.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({Key? key}) : super(key: key);

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  String cardNumber = '';
  String cardHolderName = '';
  String cvvNumber = '';
  String expiryDate = '';
  bool showBackView = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModel(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      cardHolderName = creditCardModel.cardHolderName;
      expiryDate = creditCardModel.expiryDate;
      cvvNumber = creditCardModel.cvvCode;
      showBackView = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            backgroundImage: 'Assets/images/cardbg.png',
            cardHolderName: cardHolderName,
            cvvCode: cvvNumber,
            showBackView: showBackView,
            // cardBgColor: Color(0xFFBAD3D4),
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w300,
            ),
            animationDuration: Duration(milliseconds: 1200),
            onCreditCardWidgetChange: (CreditCardBrand) {},
          ),
          Expanded(
            child: SingleChildScrollView(
              child: CreditCardForm(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvNumber,
                formKey: formKey,
                onCreditCardModelChange: onCreditCardModel,
                cursorColor: Colors.black,
                themeColor: Colors.black,

                cardNumberDecoration: InputDecoration(
                    //  border: OutlineInputBorder(),
                    labelText: "Card Number",
                    hintText: "xxxx xxxx xxxx xxxx"),
//                   expiryDateDecoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: "Expiry Date",
//                       hintText: "xx/xx"
//                   ),
//                   cvvCodeDecoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: "CVV",
//                       hintText: "xxx"
//                   ),
//                   cardHolderDecoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Card Holder Name",
//                 ),
//
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(1, 15, 1, 20),
            child: NavButton(
              buttonText: 'Save Changes',
              textSize: 20.sp,
              buttonHeight: 50.h,
              buttonWidth: 320.w,
              onPressed: () => {
                //do something
              },
            ),
          )
        ],
      ),
    );
  }
}
