import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/dashboard/dashboard_screen.dart';
import 'package:memoir_reader/modules/memoir/view/memoir_details_screen.dart';
import 'package:memoir_reader/modules/profile/view/my_memoirs.dart';
import 'package:memoir_reader/modules/splash_screen.dart';
import 'package:memoir_reader/modules/test_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print('Navigated Route Name ${settings.name}');

    final args = settings.arguments;
    switch (settings.name) {
      case MemoirDetailsScreen.routeName:
        // const page = MemoirDetailsScreen();
        final _args = args as MemoirDetailsScreenArguements;
        return MaterialPageRoute(
          builder: (context) {
            return MemoirDetailsScreen(
              id: _args.id,
              title: _args.title,
              content: _args.content,
            );
          },
        );
      case TestScreen.routeName:
        const page = TestScreen();
        return MaterialPageRoute(builder: (_) => page);
      case MyMemoirScreenScreen.routeName:
        const page = MyMemoirScreenScreen();
        return MaterialPageRoute(builder: (_) => page);
      case SplashScreen.routeName:
        const page = SplashScreen();
        return MaterialPageRoute(builder: (_) => page);

      default:
        const page = Dashboard();
        return MaterialPageRoute(builder: (_) => page);
    }
  }
}

// http://api.mediastack.com/v1/news?access_key=5b960bcf0220600a99a0d1242c9a0492
// http://api.mediastack.com/v1/news?access_key=5b960bcf0220600a99a0d1242c9a0492&categories=entertainment&languages=en
