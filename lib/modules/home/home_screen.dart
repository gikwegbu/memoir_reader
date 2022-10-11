// import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/memoir/components/memoir_card.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    items.add((items.length + 1).toString());
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: labelText("mR", context),
      //   // automaticallyImplyLeading: false,
      //   actions: [
      //     IconButton(
      //       splashRadius: 20,
      //       onPressed: () {},
      //       icon: const Icon(Icons.search),
      //     ),
      //     IconButton(
      //       splashRadius: 20,
      //       onPressed: () {},
      //       icon: const Icon(Icons.notifications),
      //     ),
      //   ],
      // ),
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 88.0),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading:
              _onLoading, // Maker a request to BE to request for more data...
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.4,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (c, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: MemoirCard(
                  title: "Our Temperature fades",
                  content:
                      "The sky is blue, but we don't usually notice ast it's filled with clouds, yet we are not aware of how we are killing our environment on a daily...",
                  id: "sdkflajskdfjlasdkfa",
                  username: 'George Ikwegbu',
                  createdAt: DateTime.now(),
                ),
              );
            },
            itemCount: items.length,
          ),
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AppBar(
            backgroundColor: Colors.black.withOpacity(0.2),
            title: const Text('mReader'),
            elevation: 0.0,
            actions: [
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size(
        double.infinity,
        // 39.0,
        // 59.0,
        Platform.isIOS ? 39 : 45,
      ),
    );
  }
}
