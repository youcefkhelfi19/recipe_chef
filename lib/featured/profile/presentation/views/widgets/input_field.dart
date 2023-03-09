
import 'package:flutter/material.dart';


class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key, required this.hintText, required this.textEditingController, required this.validator,  this.isNumber = false,
  }) : super(key: key);
  final String hintText;
  final TextEditingController textEditingController ;
  final bool isNumber;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isNumber?TextInputType.number:TextInputType.text,
      validator: validator,
      controller:  textEditingController,
      decoration: InputDecoration(
          hintText: hintText,

      ),

    );
  }
}
