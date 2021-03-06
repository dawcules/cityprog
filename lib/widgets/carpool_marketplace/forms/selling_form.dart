import 'dart:io';

import 'package:cityprog/model/market.dart';
import 'package:cityprog/model/trade_methods.dart';
import 'package:cityprog/networking/network_api.dart';
import 'package:cityprog/validation/title_details_validator.dart';
import 'package:cityprog/widgets/buttons/submit_form_button.dart';
import 'package:cityprog/widgets/camera/app_image_picker.dart';
import 'package:cityprog/widgets/columns/title_details_column.dart';
import 'package:cityprog/widgets/columns/select_price_column.dart';
import 'package:cityprog/widgets/database_model/auth.dart';
import 'package:cityprog/widgets/database_model/database.dart';
import 'package:cityprog/widgets/dialogs/citizenpoint_update.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SellingForm extends StatefulWidget {
  @override
  _SellingFormState createState() => _SellingFormState();
}

class _SellingFormState extends State<SellingForm> {
  // UI State
  Trading _method;
  final TitleDetailsValidator _titleDetailsValidator = TitleDetailsValidator();

  // Model state
  double _price;
  File _image;

  @override
  void initState() {
    super.initState();
    _method = Trading.SELLING;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
          ),
          SelectPriceColumn(
            tradeMethod: _method,
            onTradeMethodChanged: (Trading method) =>
                _onTradeMethodChanged(method),
            onPriceChanged: (double value) => _onPriceChanged(value),
          ),
          TitleDetailsColumn(
            validator: _titleDetailsValidator,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppImagePicker(
              iconSize: 40,
              onImagePicked: (File img) => _onImagePicked(img),
            ),
          ),
          SubmitFormButton(
            onPress: _validate,
            onValidatedSuccess: () => _submitPost(),
          )
        ],
      ),
    );
  }

  void _onPriceChanged(double price) {
    print(price);
    setState(() {
      _price = price;
    });
  }

  void _onTradeMethodChanged(Trading method) {
    print(method);
    setState(() {
      _method = method;
    });
  }

  void _onImagePicked(File img) {
    setState(() => _image = img);
  }

  void _validate(Function callback) {
    if (_method == Trading.SELLING) {}
    callback(_titleDetailsValidator.validate() && _validatePrice());
  }

  bool _validatePrice() {
    if (_method == Trading.SELLING) {
      return _price != null ? true : false;
    } else
      return true;
  }

  void _uploadImage() {
    print("Submit sell post!");
    NetworkApi.uploadImage(
        _image,
        (error, imageUrl) => {
              if (!error)
                {
                  _sendData(imageUrl),
                  Navigator.of(context).pushReplacementNamed("/market")
                }
              else
                {Toast.show("Error uploading image", context)}
            });
  }

  void _submitPost() {
    print("Submit sell post!");
    if (_image != null) {
      _uploadImage();
    } else {
      _sendData(null);
    }
  }

  void _sendData(String imageUrl) {
    MarketPostData post = MarketPostData(
        body: _titleDetailsValidator.details,
        //imageUri: _image != null ? _image.uri : null,
        imageUri: imageUrl,
        postDate: DateTime.now(),
        uid: Auth().getUID(),
        postedBy: Auth().getUser().displayName,
        price: _price,
        title: _titleDetailsValidator.title,
        tradeMethod: _method);
    Database().newCommunityPost(
        post: post.toMap(),
        document: "Marketplace",
        collection: _method.toDatabaseCollectionId(),
        callback: (value, error) => {
              if (!error)
                {
                  showDialog(
                    context: context,
                    child: CitizenPointUpdateDialog(
                      amount: 200,
                    ),
                  ),
                  Navigator.of(context).pushReplacementNamed("/market")
                }
            });
  }
}
