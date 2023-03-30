import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xFFBAD3D4);
const kPrimaryDarkColor = Color(0xFF7EB0B2);

Size displaySize(BuildContext context) {
  //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  //debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  //debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

class Roboto_button extends StatelessWidget {
  final String textValue;
  final double size;
  const Roboto_button({Key? key, required this.textValue, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      //overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      softWrap: true,
      style: GoogleFonts.robotoCondensed(
        color: const Color(0xffffffff),
        fontSize: size,
      ),
    );
  }
}

class Roboto_heading extends StatelessWidget {
  final String textValue;
  final double size;

  const Roboto_heading({Key? key, required this.textValue, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      //overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      softWrap: true,
      style: GoogleFonts.robotoCondensed(
          color: const Color(0xff000000),
          fontSize: size,
          fontWeight: FontWeight.bold
      ),
    );
  }
}

class Roboto_subheading extends StatelessWidget {
  final String textValue;
  final double size;
  const Roboto_subheading({Key? key, required this.textValue, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      //overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      softWrap: true,
      style: GoogleFonts.roboto(
        color: const Color(0xff000000),
        fontSize: size,
        fontWeight: FontWeight.w500
      ),
    );
  }
}

class Roboto_text extends StatelessWidget {
  final String textValue;
  final double size;
  const Roboto_text({Key? key, required this.textValue, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      //overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      softWrap: true,
      style: GoogleFonts.roboto(
        color: const Color(0xff000000),
        fontSize: size,
      ),
    );
  }
}

class Roboto_boldtext extends StatelessWidget {
  final String textValue;
  final double size;
  const Roboto_boldtext({Key? key, required this.textValue, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      //overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      softWrap: true,
      style: GoogleFonts.robotoCondensed(
        color: const Color(0xff000000),
        fontSize: size,
      ),
    );
  }
}



class field extends StatefulWidget {
  //final bool? obscuredText;
  final String labelText;
  //final String hintText;
  Icon? prefixIcon;
  IconData? suffixIcon;
  final bool autoFocus;
  final String? Function(String?)? validateInput;
  final TextEditingController textController;
  VoidCallback? onPressed;
  //bool? obscuredText;

  field({
    Key? key,
    required this.textController,
    required this.labelText,
    //required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    //required this.onChanged,
    this.validateInput,
    required this.autoFocus,

    // this.onPressed,
    //this.obscuredText,
    //this.onPressed
  }) : super(key: key);

  @override
  _fieldState createState() => _fieldState();
}

class _fieldState extends State<field> {
  final _formKey = GlobalKey<FormState>();
  //bool _obscured = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: displayWidth(context) * 0.8,
      height: displayHeight(context)*0.075,
      child: TextFormField(
        //obscureText: _obscured,
        controller: widget.textController,
        //onChanged: widget.onChanged,
        validator: widget.validateInput,
        decoration: InputDecoration(
          fillColor: const Color(0xFFF4F1F1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 6,  color: Color(0xFFF4F1F1)),),
          labelText: widget.labelText,
          labelStyle: GoogleFonts.roboto(
            color: const Color(0xFF283618),
            fontSize: 14,
          ),
          // hintText: widget.hintText,
          // hintStyle: GoogleFonts.roboto(
          //     color: Color(0xFF838383), fontStyle: FontStyle.italic),
          prefixIcon: widget.prefixIcon,

          // //Icon(Icons.lock, color: Color(0xFF283618)),
          // suffixIcon:
          // IconButton(
          //     icon: Icon(widget.suffixIcon),
          //     onPressed: () {
          //       // if (_obscured == false) {
          //       //  widget.suffixIcon = Icons.visibility_off;
          //       // } else {
          //       //   widget.suffixIcon = Icons.visibility;
          //       // }
          //       _obscured = !_obscured;
          //       setState(() {});
          //     }),
        ),
      ),
    );
  }
}

class passfield extends StatefulWidget {
  //final bool? obscuredText;
  final String labelText;
  //final String hintText;
  Icon? prefixIcon;
  IconData? suffixIcon;
  final bool autoFocus;
  final String? Function(String?)? validateInput;
  final TextEditingController textController;
  VoidCallback? onPressed;
  //bool? obscuredText;

  passfield({
    Key? key,
    required this.textController,
    required this.labelText,
    //required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    //required this.onChanged,
    this.validateInput,
    required this.autoFocus,

    // this.onPressed,
    //this.obscuredText,
    //this.onPressed
  }) : super(key: key);

  @override
  _passfieldState createState() => _passfieldState();
}

class _passfieldState extends State<passfield> {
  final _formKey = GlobalKey<FormState>();
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context) * 0.8,
      height: displayHeight(context)*0.075,
      child: TextFormField(
        obscureText: _obscured,
        controller: widget.textController,
        //onChanged: widget.onChanged,
        validator: widget.validateInput,
        decoration: InputDecoration(
          fillColor: Color(0xFFF4F1F1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 6,  color: Color(0xFFF4F1F1)),),
          labelText: widget.labelText,
          labelStyle: GoogleFonts.roboto(
            color: Color(0xFF283618),
            fontSize: 14,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon:
          IconButton(
              icon: Icon(widget.suffixIcon),
              onPressed: () {
                if (_obscured == false) {
                 widget.suffixIcon = Icons.visibility_off;
                } else {
                  widget.suffixIcon = Icons.visibility;
                }
                _obscured = !_obscured;
                 setState(() {});
              }),
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final double buttonWidth;
  final double buttonHeight;
  final double textSize;
  final String buttonText;
  final VoidCallback onPressed;
  const NavButton({
    Key? key,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.textSize,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 20,
        fixedSize: Size(buttonWidth, buttonHeight),
        primary: const Color(0xFF000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: onPressed,
      child: Roboto_button(textValue: buttonText, size: 18),
    );
  }
}

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: 30.h),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.grey),
  );
}