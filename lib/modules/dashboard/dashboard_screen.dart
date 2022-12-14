import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/scheduler.dart';
import 'package:memoir_reader/modules/dashboard/components/dashboard_screen_diplayer.dart';
import 'package:memoir_reader/modules/memoir/viewModel/memoir_provider.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  // always marked "final".

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _page = "home";
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  void _fetchMemoirs() {
    context.read<MemoirProvider>().fetchMemoir();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Used to remove the building faild to build widget stuff for trying to update context while widget is still building...
    // WidgetsBinding.instance?.addPostFrameCallback(((timeStamp) {
    SchedulerBinding.instance?.scheduleFrameCallback(((timeStamp) {
      _fetchMemoirs();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => logoutUser(context),
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color:
              isDarkMode(context) ? Colors.grey.withOpacity(0.4) : Colors.white,
          buttonBackgroundColor: isDarkMode(context) ? green : Colors.white,
          // backgroundColor: isDark,
          backgroundColor: isDarkMode(context) ? isDark : Colors.transparent,
          key: _bottomNavigationKey,
          items: const <Widget>[
            Icon(
              Icons.home_work,
              size: 30,
              color: black,
            ),
            Icon(
              Icons.add,
              size: 30,
              color: black,
            ),
            Icon(
              Icons.account_circle,
              size: 30,
              color: black,
            ),
          ],
          onTap: (index) {
            _navSwitcher(index);
          },
        ),
        body: SizedBox(
          // color: Colors.blueAccent,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: DisplayWidget(currentTab: _page),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navSwitcher(index) {
    switch (index) {
      case 0:
        _page = "home";
        break;
      case 1:
        _page = "create";
        break;
      case 2:
        _page = "profile";
        break;
      default:
    }
    setState(() {});
  }
}
