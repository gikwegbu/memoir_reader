import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/dashboard/dashboard_screen.dart';
import 'package:memoir_reader/modules/memoir/memoir_details_screen.dart';
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

      default:
        const page = Dashboard();
        return MaterialPageRoute(builder: (_) => page);
    }
  }
}
