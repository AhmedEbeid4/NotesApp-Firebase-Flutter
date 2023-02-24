import 'package:firebase_flutter/views/values/colors.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatefulWidget {
  double? fontSize;
  TextInputType? inputType = TextInputType.text;
  String? label;
  String? hint;
  TextEditingController? controller = TextEditingController();
  TextStyle? textStyle;
  int? minLines;
  int? maxLines;

  RoundedTextField({Key? key,this.fontSize,this.label,this.inputType,this.controller,this.textStyle,this.maxLines,this.minLines,this.hint}) : super(key: key);

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  var _labelColor = itemBackgroundColor;
  @override
  Widget build(BuildContext context) {
    return Focus(
        onFocusChange: (hasFocus) {
          setState(() => _labelColor = hasFocus ? thirdColor : itemBackgroundColor);
        },
      child: TextField(

          minLines: widget.minLines,
          maxLines: widget.maxLines,
          controller: widget.controller,
          style: widget.textStyle,
          keyboardType: widget.inputType,

          cursorColor: thirdColor,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle:  TextStyle(fontSize: widget.fontSize,color: itemBackgroundColor,),
            labelText: widget.label,
            labelStyle: TextStyle(fontSize: widget.fontSize,color: _labelColor,),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
              borderSide: const BorderSide(
                color: thirdColor,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
              borderSide: const BorderSide(
                  color: itemBackgroundColor,
                  width: 1.5),
            ),
          )
      ),
    );
  }
}
