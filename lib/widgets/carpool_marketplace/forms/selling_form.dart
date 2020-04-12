import 'package:cityprog/model/trade_methods.dart';
import 'package:cityprog/widgets/buttons/submit_form_button.dart';
import 'package:cityprog/widgets/columns/title_details_column.dart';
import 'package:flutter/material.dart';

class SellingForm extends StatelessWidget {
  final Trading method = Trading.SELLING;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TitleDetailsColumn(),
          SubmitFormButton(
            onPress: () => print("submit sell"),
          ),
        ],
      ),
    );
  }
}
