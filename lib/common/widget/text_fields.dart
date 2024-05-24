import 'package:flutter/material.dart';
import 'package:todo/common/font.dart';

class TextFields extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLine, minLine;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int? maxLength;
  const TextFields({
    super.key,
    required this.controller,
    this.maxLine,
    this.minLine,
    required this.hintText,
    this.validator,
    required this.keyboardType,
    this.maxLength,
  });

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      maxLines: widget.maxLine,
      minLines: widget.minLine,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      style: TextStyle(
        fontSize: AppFont.largerFontSize,
      ),
      validator: (value) => widget.validator!(value),
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: AppFont.largerFontSize
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            // borderRadius: BorderRadius.circular(10)
          )),
    );
  }
}
