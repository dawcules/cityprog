import 'package:cityprog/strings/navigation_strings.dart';
import 'package:cityprog/widgets/Backgrounds/background_widget.dart';
import 'package:cityprog/widgets/rows/icon_and_route_name.dart';
import 'package:cityprog/handlers/message_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cityprog/styles/color_palette.dart';

class NavigationPage extends StatelessWidget {
  final double logoSizeMultiplier;
  const NavigationPage({this.logoSizeMultiplier});

  @override
  Widget build(BuildContext context) {
    //double multiplier = logoSizeMultiplier != null ? logoSizeMultiplier : 1;
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Container(
        height: 1000,
        width: 750,
        color: Colors.transparent,
        //width: MediaQuery.of(context).size.width * multiplier,
        child: Scaffold(
          // backgroundColor: Colors.orangeAccent,
          extendBody: true,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: heigth / 2.4,
                  child: Stack(
                    children: <Widget>[
                      kIsWeb
                          ? SizedBox(height: 200, width: 200)
                          : BackgroundWidget(
                              heigth: heigth / 2.2,
                              width: width + 30,
                              imageUrl: "assets/images/backgroundtesting.png",
                            ),
                      kIsWeb
                          ? BackgroundWidget(
                              top: 200,
                              heigth: 100,
                              width: 150,
                              imageUrl: "assets/images/smartespoo.png",
                            )
                          : BackgroundWidget(
                              heigth: heigth / 5,
                              width: width / 2,
                              imageUrl: "assets/images/backgroundmyespoo.png",
                            )
                    ],
                  ),
                ),
                /*Align(
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
                ),*/
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: generateNavigationButtons(context),
                ),
                kIsWeb
                    ? Padding(
                        padding: EdgeInsets.all(0),
                      )
                    : MessageHandler(),
              ],
            ),
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
          heroTag: "nav_health",
          icon: Icon(Icons.local_hospital),
          route: "/health",
          routeName: NavigationStrings.healthToLocalized(),
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
        //   IconRouteNameRow(
        //   heroTag: "nav_voting",
        //   icon: Icon(Icons.flag),
        //   route: "/voting",
        //   routeName: NavigationStrings.personalToLocalized(),
        // ),
        Padding(
          padding: EdgeInsets.all(8),
        ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Material(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(420)),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(420),
                              ),
                              child: FloatingActionButton(
                                heroTag: 'exitBtn',
                                elevation: 0,
                                  backgroundColor: AppColor.secondary.color(),
                                  child: Text('X', style: TextStyle(fontSize: 18),),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }
                            ),
                          ),
                    ),
                  ),
                )
        /*       IconRouteNameRow(
          heroTag: "nav_introduction",
          icon: Icon(Icons.help),
          route: "/introduction",
          routeName: NavigationStrings.introductionToLocalized(),
        ), */
      ],
    );
  }
}
