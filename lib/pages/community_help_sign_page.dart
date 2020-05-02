import 'package:cityprog/styles/color_palette.dart';
import 'package:cityprog/widgets/dialogs/citizenpoint_update.dart';
import 'package:flutter/material.dart';
import 'package:cityprog/strings/community_help_strings.dart';

class CommunityHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 1000,
                width: 750,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Text(
                        LocalizedCommunityHelpStrings.volunteerBtnToLocalized(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(20.0)),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Text(
                          LocalizedCommunityHelpStrings.signDescLocalized(),
                          style: TextStyle(fontSize: 20)),
                    ),
                    RaisedButton(
                      color: AppColor.button.color(),
                      onPressed: () {
                        showDialog(
                            context: context,
                            child: CitizenPointUpdateDialog(
                              amount: 250,
                              title: Text(
                                  LocalizedCommunityHelpStrings.weAppreciateToLocalized(250)),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                        child: Text(
                          LocalizedCommunityHelpStrings.signUpToLocalized(),
                          style: TextStyle(
                            color: AppColor.buttonText.color(),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
