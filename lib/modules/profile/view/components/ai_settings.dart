import 'package:flutter/material.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';

class AiSettings extends StatefulWidget {
  const AiSettings({
    Key? key,
  }) : super(key: key);

  @override
  State<AiSettings> createState() => _AiSettingsState();
}

class _AiSettingsState extends State<AiSettings> {
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
        subtext('Configure your speech settings here...', context),
        ySpace(height: 10),
        const Divider(),
        ySpace(height: 10),
      ],
    );
  }
}
