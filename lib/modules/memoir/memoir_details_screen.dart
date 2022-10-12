import 'dart:ui';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';

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

enum TtsState { playing, stopped, paused, continued }

class _MemoirDetailsScreenState extends State<MemoirDetailsScreen> {
  GlobalKey<ExpandableBottomSheetState> bottomSheetKey = GlobalKey();

  bool _isReading = false;
  bool _showFAB = true;
  late String _id;
  late String _title;
  late String _content;

  // Voice Settings
  FlutterTts flutterTts = FlutterTts();
  double volume = 1.0;
  double pitch = 1.0;
  double speechRate = 0.5;
  List<String>? languages;
  String langCode = "en-US";

  TtsState ttsState = TtsState.stopped;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  @override
  void initState() {
    // TODO: implement initState
    _isReading = false;
    _id = widget.id;
    _title = widget.title;
    _content = widget.content;
    super.initState();
    init();
  }

  // Settings
  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  void init() async {
    languages = List<String>.from(await flutterTts.getLanguages);
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      print("Complete");
      _isReading = false;
      ttsState = TtsState.stopped;
      setState(() {});
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (isWeb || isIOS || isWindows) {
      flutterTts.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ExpandableBottomSheet(
        key: bottomSheetKey,

        //required
        //This is the widget which will be overlapped by the bottom sheet.
        // Na here the child suppose dey naaaa
        background: SingleChildScrollView(
          child: Container(
            // color: Colors.blue[800],
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            child: labelText(
              _content,
              context,
              fontSize: 14,
              letterSpacing: 1,
              height: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        //required
        //This is the content of the bottom sheet which will be extendable by dragging.
        expandableContent: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 58.0),
              decoration: const BoxDecoration(
                // color: grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _toggleBottomSheet,
                    child: Container(
                      height: 8,
                      width: 55,
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: black,
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: labelText("Volume", context),
                        ),
                        Slider(
                          min: 0.0,
                          max: 1.0,
                          value: volume,
                          onChanged: (value) {
                            setState(() {
                              volume = value;
                            });
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                              double.parse((volume).toStringAsFixed(2))
                                  .toString(),
                              style: const TextStyle(fontSize: 17)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: labelText("Pitch", context),
                        ),
                        Slider(
                          min: 0.5,
                          max: 2.0,
                          value: pitch,
                          onChanged: (value) {
                            setState(() {
                              pitch = value;
                            });
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                              double.parse((pitch).toStringAsFixed(2))
                                  .toString(),
                              style: const TextStyle(fontSize: 17)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: labelText("Speech Rate", context),
                        ),
                        Slider(
                          // activeColor: isDarkMode(context) ? green : black,
                          min: 0.0,
                          max: 1.0,
                          value: speechRate,
                          onChanged: (value) {
                            setState(() {
                              speechRate = value;
                            });
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                              double.parse((speechRate).toStringAsFixed(2))
                                  .toString(),
                              style: const TextStyle(fontSize: 17)),
                        )
                      ],
                    ),
                  ),
                  if (languages != null)
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          labelText("Language", context),
                          const SizedBox(
                            width: 10,
                          ),
                          xSpace(),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              focusColor: Colors.white,
                              value: langCode,
                              iconSize: 24,
                              elevation: 16,
                              iconEnabledColor: green,
                              items: languages!.map<DropdownMenuItem<String>>(
                                  (String? value) {
                                return DropdownMenuItem<String>(
                                  value: value!,
                                  child: Text(
                                    value,
                                    // style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  langCode = value!;
                                });
                              },
                            ),
                          ),
                          xSpace(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _getFAB(),
    );
  }

  void _toggleReadingStat() {
    _isReading = !_isReading;
    setState(() {});
  }

  void initSetting() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.setLanguage(langCode);
  }

  void _speak() async {
    initSetting();
    await flutterTts.speak(_content);
  }

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  void _stop() async {
    await flutterTts.stop();
  }

  void _pause() async {
    await flutterTts.pause();
  }

  @override
  void dispose() {
    _stop();
    super.dispose();
  }

  Widget _getFAB() {
    if (_showFAB ||
        bottomSheetKey.currentState?.expansionStatus ==
                ExpansionStatus.expanded &&
            // ignore: unrelated_type_equality_checks
            TtsState.stopped == true) {
      return _fab();
    } else {
      return Container();
    }
  }

  Widget _fab() {
    return _isReading
        ? AvatarGlow(
            glowColor: isDarkMode(context) ? green : black,
            endRadius: 60.0,
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: const Duration(milliseconds: 10),
            child: GestureDetector(
              onTap: () {
                _toggleReadingStat();
                // _stop();
                _pause();
              },
              child: Material(
                elevation: 8.0,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: isDarkMode(context) ? green : black,
                  child: Icon(
                    _isReading ? Icons.pause_rounded : Icons.play_arrow_rounded,
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
              _speak();
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
                    _isReading ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 40,
                    color: isDarkMode(context) ? black : isLight,
                  ),
                  radius: 30.0,
                ),
              ),
            ),
          );
  }

  int _contentAmount = 0;

  void _expandBottomSheet() => bottomSheetKey.currentState!.expand();

  void _contractBottomSheet() => bottomSheetKey.currentState!.contract();

  bool _bottomSheetStatus() =>
      bottomSheetKey.currentState!.expansionStatus ==
      ExpansionStatus.contracted;

  void _toggleBottomSheet() {
    _bottomSheetStatus() ? _expandBottomSheet() : _contractBottomSheet();
    _showFAB = !_showFAB;
    _showFAB = _bottomSheetStatus() ? false : true;
    setState(() {});
  }

  PreferredSize _appBar() {
    return PreferredSize(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AppBar(
            backgroundColor: Colors.black.withOpacity(0.2),
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
                  _toggleBottomSheet();
                },
                icon: const Icon(Icons.volume_down),
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
