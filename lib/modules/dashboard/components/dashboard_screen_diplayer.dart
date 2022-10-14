import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/home/home_screen.dart';
import 'package:memoir_reader/modules/memoir/components/create_memoir_screen.dart';
import 'package:memoir_reader/modules/profile/view/profile_screen.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';

class DisplayWidget extends StatelessWidget {
  const DisplayWidget({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final String currentTab;

  @override
  Widget build(BuildContext context) {
    print("George this is the current ScreenTab: $currentTab");
    switch (currentTab) {
      case "home":
        return const HomeScreen();
      case "create":
        return const CreateMemoirScreen();
      case "profile":
        return const ProfileScreen();
      default:
        return labelText('Default view', context);
    }
  }
}
