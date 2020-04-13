import 'package:cityprog/pages/community_help_cat_page.dart';
import 'package:flutter/material.dart';

import './main.dart';
import './pages/welcome_page.dart';
import './pages/community_page.dart';
import './pages/introduction_page.dart';
//import './pages/personal_page.dart';
import 'pages/community_help_sign_page.dart';
import 'pages/community_help_main_page.dart';
import './pages/carpool.dart';
import './pages/login_page.dart';
import './pages/profile_creation.dart';
import './pages/marketplace.dart';

// https://www.youtube.com/watch?v=nyvwx7o277U

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/': // The absolute first page
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case '/home':
        return MaterialPageRoute(builder: (_) => MyHomePage(title: args));
      case '/community':
        return MaterialPageRoute(builder: (_) => CommunityPage());
      case '/communityHelp':
        return MaterialPageRoute(builder: (_) => CommunityHelpMain());
      case '/communityHelpSign':
        return MaterialPageRoute(builder: (_) => CommunityHelpPage());
      case '/communityHelpCat':
        return MaterialPageRoute(builder: (_) => CommunityHelpCat(args));
      case '/personal':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/introduction':
        return MaterialPageRoute(builder: (_) => IntroductionPage());
      case '/carpool':
        return MaterialPageRoute(builder: (_) => CarpoolPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/market':
        return MaterialPageRoute(builder: (_) => MarketPlacePage());
      case '/market_new':
        return MaterialPageRoute(
          builder: (_) => MarketPlacePage(
            navigatedWithNewCommand: true,
          ),
        );
      case '/carpool_new':
        return MaterialPageRoute(
          builder: (_) => CarpoolPage(
            navigatedWithNewCommand: true,
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text("404 - ei löydy :D"),
        ),
      );
    });
  }
}

enum Routes {
  HOME,
  PERSONAL,
  COMMUNITY,
  INTRODUCTION,
  CARPOOL,
  PROFILE,
  COMMUNITYHELP,
  MARKETPLACE,
  MARKET_NEW,
  CARPOOL_NEW,
}

extension RoutePaths on Routes {
  String get name {
    switch (this) {
      case Routes.HOME:
        return "/home";
        break;
      case Routes.PERSONAL:
        return "/personal";
        break;
      case Routes.COMMUNITY:
        return "/community";
        break;
      case Routes.COMMUNITYHELP:
        return "/communityMain";
      case Routes.INTRODUCTION:
        return "/introduction";
        break;
      case Routes.CARPOOL:
        return "/carpool";
        break;
      case Routes.PROFILE:
        return "/profile";
        break;
      case Routes.MARKETPLACE:
        return "/market";
      case Routes.MARKET_NEW:
        return "/market_new";
      case Routes.CARPOOL_NEW:
        return "/carpool_new";
      default:
        return "/lookslikea404";
        break;
    }
  }
}
