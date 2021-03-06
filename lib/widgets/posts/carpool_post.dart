import 'package:cityprog/widgets/rows/trade_method_row.dart';
import 'package:flutter/material.dart';

import '../../model/carpool.dart';
import '../../strings/community_strings.dart';
import '../../styles/color_palette.dart';

class CarpoolPostWidget extends StatelessWidget {
  final CarpoolPostData postData;
  final Function _moreButtonPressed;
  const CarpoolPostWidget(this.postData, this._moreButtonPressed);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: AppColor.secondary.color(),
        onTap: () => _moreButtonPressed(),
        child: Wrap(
          children: <Widget>[
            TradeMethodRow(
              postData.tradeMethod,
              fontSize: 16,
              paddingAmount: 8,
              borderRadius: BorderRadius.circular(10),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _originDestinationRow(
                    LocalizedCommunityStrings.fromToLocalized(),
                    postData.origin,
                    context,
                  ),
                  _originDestinationRow(
                    LocalizedCommunityStrings.destinationToLocalized(),
                    postData.destination,
                    context,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        LocalizedCommunityStrings.dateTimeToLocaleString(
                          postData.postDate,
                          needsHrs: true,
                        ),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: EdgeInsets.all(8),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _originDestinationRow(
      String left, String right, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            text: "$left: ",
            children: [
              TextSpan(
                  text: right,
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.normal))
            ]),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
