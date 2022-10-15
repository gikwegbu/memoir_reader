// import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:memoir_reader/modules/memoir/components/memoir_card.dart';
import 'package:memoir_reader/modules/memoir/model/memoir_model.dart';
import 'package:memoir_reader/modules/memoir/viewModel/memoir_provider.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Pagination? _pagination;
  List<MemoirModel> _memoirData = <MemoirModel>[];
  int _limit = 0;

  void _loadData() {
    _memoirData =
        Provider.of<MemoirProvider>(context, listen: true).getMemoirData ?? [];
    _pagination =
        Provider.of<MemoirProvider>(context, listen: true).getPagination;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await context.read<MemoirProvider>().fetchMemoir();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    int? _total = _pagination?.total ?? 0;
    int? _currentLimit = _pagination?.limit ?? 0;
    _limit = _currentLimit;

    if (_limit < _total) {
      await context.read<MemoirProvider>().fetchMemoir(limit: _limit + 10);
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
    if (mounted) setState(() {});
    // await Future.delayed(const Duration(milliseconds: 1000));
    // if (mounted) setState(() {});
    // _refreshController.loadNoData();
  }

  @override
  Widget build(BuildContext context) {
    _loadData();

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
          child: _memoirData.isEmpty
              ? Center(
                  child: labelText(
                    // "All available memoirs 📝, will appear here. ${context.read<MemoirProvider>().isFetchingMemoir}",
                    "All available memoirs 📝, will appear here. ${context.read<MemoirProvider>().getMemoirData}",
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
                    final _title = _memoirData[index].title;
                    final _author = _memoirData[index].author;
                    final _desc = _memoirData[index].description;
                    final _date = _memoirData[index].publishedAt!;
                    final _id = _memoirData[index].url.toString();
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: MemoirCard(
                        title: _title ?? '',
                        content: _desc ?? '',
                        id: _id,
                        username: _author ?? '',
                        createdAt: _date,
                        // createdAt: shortDate(_date),
                      ),
                    );
                  },
                  itemCount: _memoirData.length,
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
