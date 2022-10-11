import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:avatar_glow/avatar_glow.dart';

class MemoirDetailsScreen extends StatefulWidget {
  const MemoirDetailsScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String id;
  final String title;
  final String content;

  static const String routeName = "/memore_details_screen";

  @override
  State<MemoirDetailsScreen> createState() => _MemoirDetailsScreenState();
}

class _MemoirDetailsScreenState extends State<MemoirDetailsScreen> {
  bool _isReading = false;
  late String _id;
  late String _title;
  late String _content;

  @override
  void initState() {
    // TODO: implement initState
    _isReading = false;
    _id = widget.id;
    _title = widget.title;
    _content = widget.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
          child: Column(
            children: [
              labelText(
                // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. \nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                _content,
                context,
                fontSize: 14,
                letterSpacing: 1,
                height: 2,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _isReading
          ? AvatarGlow(
              glowColor: isDarkMode(context) ? green : black,
              endRadius: 60.0,
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 10),
              child: GestureDetector(
                onTap: () {
                  _toggleReadingStat();
                },
                child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: isDarkMode(context) ? green : black,
                    child: Icon(
                      _isReading
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 40,
                      color: isDarkMode(context) ? black : isLight,
                    ),
                    radius: 30.0,
                  ),
                ),
              ),
            )
          : GestureDetector(
              onTap: () {
                _toggleReadingStat();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: isDarkMode(context) ? green : black,
                    child: Icon(
                      // Icons.play_arrow_rounded,
                      _isReading
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 40,
                      color: isDarkMode(context) ? black : isLight,
                    ),
                    radius: 30.0,
                  ),
                ),
              ),
            ),
    );
  }

  void _toggleReadingStat() {
    _isReading = !_isReading;
    setState(() {});
  }

  PreferredSize _appBar() {
    return PreferredSize(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AppBar(
            backgroundColor: Colors.black.withOpacity(0.2),
            // title: labelText(_title, context),
            title: Tooltip(
              message: _title,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: black,
              ),
              // height: 50,
              padding: const EdgeInsets.all(8.0),
              preferBelow: true,
              textStyle: const TextStyle(
                fontSize: 12,
                color: isLight,
              ),
              showDuration: const Duration(seconds: 2),
              waitDuration: const Duration(seconds: 1),
              child: labelText(_title, context),
            ),
            elevation: 0.0,
            actions: [
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  showNotification(
                    message: "Downloaded 🎧",
                    duration: const Duration(seconds: 4),
                  );
                },
                icon: const Icon(Icons.download),
              ),
            ],
          ),
        ),
      ),
      preferredSize: const Size(
        double.infinity,
        39.0,
      ),
    );
  }
}

class MemoirDetailsScreenArguements {
  String title, id, content;

  MemoirDetailsScreenArguements({
    required this.id,
    required this.title,
    required this.content,
  });
}
