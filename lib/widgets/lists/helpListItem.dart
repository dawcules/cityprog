import 'package:flutter/material.dart';
import 'package:cityprog/strings/community_help_strings.dart';

// Create a stylized card from firebase data

class HelpListTile extends StatelessWidget {
  final dynamic index;

  HelpListTile(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: 150,
      width: 750,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      index['title'].toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Flexible(
                        child: Text(index['description'].toString(),
                            style: TextStyle(fontSize: 18), maxLines: 2,)),
                    Container(
                                height: 25,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.redAccent),
                                child: Text(LocalizedCommunityHelpStrings.labelToLocalized(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
                              ),
                  ],
                ),
              ),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  'assets/images/helper.jpg',
                  width: 170,
                  height: 150,
                  fit: BoxFit.fitHeight,
                )),
          ],
        ),
      ),
    );
  }
}
