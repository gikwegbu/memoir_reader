import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/dashboard/dashboard_screen.dart';
import 'package:memoir_reader/modules/profile/model/profile_model.dart';
import 'package:memoir_reader/modules/profile/viewModel/profile_provider.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/const/image_url.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = "/splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Checking if there's token in the hive
    _checkUserProfile();
    super.initState();
  }

  void _checkUserProfile() async {
    // Retrieving the last logged in account, so as to know which dashboard will be routed to
    ProfileModel _userProfile = await getUserProfileDetails();

    context.read<ProfileProvider>().setUpdateProfile(_userProfile);
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pop(context);
    });
    // navigateAndClearPrev(context, Dashboard.ro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode(context) ? black : green,
      body: Center(
        child: Image.asset(
          isDarkMode(context) ? ImageUtils.iconDark : ImageUtils.iconLabel,
          width: 200,
        ),
      ),
    );
  }
}
