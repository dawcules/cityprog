import 'package:cityprog/strings/navigation_strings.dart';
import 'package:cityprog/styles/color_palette.dart';
import 'package:cityprog/widgets/rows/icon_and_route_name.dart';
import 'package:cityprog/handlers/message_handler.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatelessWidget {
  final double logoSizeMultiplier;
  const NavigationPage({this.logoSizeMultiplier});

  @override
  Widget build(BuildContext context) {
    double multiplier = logoSizeMultiplier != null ? logoSizeMultiplier : 1;
    print(multiplier);
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width * multiplier,
      child: Scaffold(
        // backgroundColor: Colors.orangeAccent,
        extendBody: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     colors: <Color>[
                  //       AppColor.secondary.color(),
                  //       AppColor.secondary.color()
                  //     ]),
                ),
                child: Container(
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 200 * multiplier,
                      width: 200 * multiplier,
                      child: Image.asset("assets/images/smartespoo.png"),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: generateNavigationButtons(context),
            ),
            MessageHandler(),
          ],
        ),
      ),
    );
  }

  Widget generateNavigationButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconRouteNameRow(
          heroTag: "nav_home",
          icon: Icon(Icons.home),
          route: "/home",
          routeName: NavigationStrings.homeToLocalized(),
          args: "Should I be removed or kept..?",
        ),
        Padding(
          padding: EdgeInsets.all(8),
        ),
        IconRouteNameRow(
          heroTag: "nav_community",
          icon: Icon(Icons.people),
          route: "/community",
          routeName: NavigationStrings.communityToLocalized(),
        ),
        Padding(
          padding: EdgeInsets.all(8),
        ),
        IconRouteNameRow(
          heroTag: "nav_communityHelp",
          icon: Icon(Icons.transfer_within_a_station),
          route: "/communityHelp",
          routeName: NavigationStrings.helpServicesToLocalized(),
        ),
        Padding(
          padding: EdgeInsets.all(8),
        ),
        IconRouteNameRow(
          heroTag: "nav_personal",
          icon: Icon(Icons.person),
          route: "/personal",
          routeName: NavigationStrings.personalToLocalized(),
        ),
        Padding(
          padding: EdgeInsets.all(8),
        ),
        IconRouteNameRow(
          heroTag: "nav_introduction",
          icon: Icon(Icons.help),
          route: "/introduction",
          routeName: NavigationStrings.introductionToLocalized(),
        ),
      ],
    );
  }
}