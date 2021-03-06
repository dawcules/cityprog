import 'package:cityprog/styles/color_palette.dart';
import 'package:cityprog/styles/custom_decoration.dart';
import 'package:flutter/material.dart';


class BoxedFormEmail extends StatelessWidget {

  final String hint;
  final String validationText;
  final bool autovalidate;
  final TextEditingController controller;
  final Function validation;

  BoxedFormEmail({this.hint, this.validationText, this.validation, this.controller, this.autovalidate});

  @override
  Widget build(BuildContext context) {
    return Container(
                        padding: EdgeInsets.all(10),
                        decoration: CustomDecoration().formBoxDecoration(),
                        child: TextFormField(
                            controller: controller,
                            autovalidate: autovalidate ? autovalidate : false,
                            validator: (value) => validation(value) ? validationText : null,
                            style: TextStyle(color: AppColor.secondary.color(), fontFamily: 'RadikalLight'),
                            decoration: CustomDecoration().loginInputDecoration(hint),
                        ),
                      );
  }
}
