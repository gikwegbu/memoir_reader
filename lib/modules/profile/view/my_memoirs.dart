// import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/memoir/components/memoir_card.dart';
import 'package:memoir_reader/modules/memoir/model/custom_memoir_model.dart';
import 'package:memoir_reader/modules/memoir/viewModel/memoir_provider.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyMemoirScreenScreen extends StatefulWidget {
  const MyMemoirScreenScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = "/my_memoirs";

  @override
  State<MyMemoirScreenScreen> createState() => _MyMemoirScreenScreenState();
}

class _MyMemoirScreenScreenState extends State<MyMemoirScreenScreen> {
  List<CustomMemoirModel> _customMemoirData = <CustomMemoirModel>[];

  void _loadData() {
    _customMemoirData =
        List.from(context.read<MemoirProvider>().getCustomMemoirData.reversed);
  }

  @override
  void initState() {
    // TODO: implement initState
    _customMemoirData = List.from(
        Provider.of<MemoirProvider>(context, listen: false)
            .getCustomMemoirData
            .reversed);
    super.initState();
  }

  List<String> items = ["1", "2"];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _loadData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadNoData();
  }

  @override
  Widget build(BuildContext context) {
    // _loadData();
    return Scaffold(
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
          child: _customMemoirData.isEmpty
              ? Center(
                  child: labelText(
                    "All your created memoirs 📝, will appear here.",
                    context,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    textAlign: TextAlign.center,
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2.1,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (c, index) {
                    final _id = _customMemoirData[index].id.toString();
                    final _title = _customMemoirData[index].title.toString();
                    final _author = _customMemoirData[index].author.toString();
                    final _content =
                        _customMemoirData[index].description.toString();
                    final _createdAt = _customMemoirData[index].publishedAt;
                    final _username =
                        _customMemoirData[index].username.toString();
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: MemoirCard(
                        title: _title,
                        content: _content,
                        id: _id,
                        username: _username,
                        createdAt: _createdAt!,
                      ),
                    );
                  },
                  itemCount: _customMemoirData.length,
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
            title: const Text('Memoirs'),
            elevation: 0.0,
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
