import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:memoir_reader/modules/profile/model/ai_settings_model.dart';
import 'package:memoir_reader/modules/profile/viewModel/ai_settings_provider.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:provider/provider.dart';

class AiSettings extends StatefulWidget {
  const AiSettings({
    Key? key,
    required this.sheetKey,
  }) : super(key: key);

  final GlobalKey<ExpandableBottomSheetState> sheetKey;

  @override
  State<AiSettings> createState() => _AiSettingsState();
}

class _AiSettingsState extends State<AiSettings> {
  AiSettingsModel _aiSettings = AiSettingsModel();
  FlutterTts flutterTts = FlutterTts();
  double? volume;
  double? pitch;
  double? speechRate;
  List<String>? languages;
  String? langCode;

  @override
  void initState() {
    // TODO: implement initState
    init();
    _aiSettings = context.read<AiProvider>().aiDetails;
    volume = _aiSettings.volume;
    pitch = _aiSettings.pitch;
    speechRate = _aiSettings.speechRate;
    langCode = _aiSettings.langCode;
    languages = _aiSettings.languages;
    super.initState();
  }

  void init() async {
    languages = List<String>.from(await flutterTts.getLanguages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(
          "Ai Settings 🤖",
          context,
          fontWeight: FontWeight.bold,
          color: isDarkMode(context) ? isLight : black,
        ),
        ySpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            subtext('Configure your speech settings here...', context),
            InkWell(
              onTap: () => _updateAiSettings(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDarkMode(context) ? green : black,
                  ),
                ),
                child: subtext('update', context),
              ),
            ),
          ],
        ),
        ySpace(height: 10),
        const Divider(),
        ySpace(height: 10),
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
                value: volume ?? 0,
                onChanged: (value) {
                  setState(() {
                    volume = value;
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                    double.parse((volume ?? 0).toStringAsFixed(2)).toString(),
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
                value: pitch ?? 0,
                onChanged: (value) {
                  setState(() {
                    pitch = value;
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                    double.parse((pitch ?? 0).toStringAsFixed(2)).toString(),
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
                value: speechRate ?? 0,
                onChanged: (value) {
                  setState(() {
                    speechRate = value;
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                    double.parse((speechRate ?? 0).toStringAsFixed(2))
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
                    items: languages!
                        .map<DropdownMenuItem<String>>((String? value) {
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
    );
  }

  void _updateAiSettings() {
    bool res = context.read<AiProvider>().updateAiSettings(
          _aiSettings.copyWith(
            volume: volume,
            pitch: pitch,
            speechRate: speechRate,
            langCode: langCode,
            languages: languages,
          ),
        );

    if (res) {
      widget.sheetKey.currentState?.contract();
    }
  }
}
