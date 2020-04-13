import 'package:cityprog/styles/color_palette.dart';
import 'package:cityprog/styles/custom_decoration.dart';
import 'package:flutter/material.dart';


class IconFormInput extends StatelessWidget {

  final String hint;
  final String validationText;
  final Icon icon;

  IconFormInput({this.hint, this.validationText, this.icon});

  @override
  Widget build(BuildContext context) {
    return 
                      TextFormField(
                            validator: (value) => value.isEmpty ? validationText : null,
                            style: TextStyle(color: AppColor.secondary.color(), fontFamily: 'RadikalLight'),
                            decoration: CustomDecoration().formInputDecoration(hint, icon),
                      );
  }
}