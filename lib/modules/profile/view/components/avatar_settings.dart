import 'package:flutter/material.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';

class AvatarSettings extends StatefulWidget {
  const AvatarSettings({
    Key? key,
  }) : super(key: key);

  @override
  State<AvatarSettings> createState() => _AvatarSettingsState();
}

class _AvatarSettingsState extends State<AvatarSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(
          "Avatar Settings 👽",
          context,
          fontWeight: FontWeight.bold,
          color: isDarkMode(context) ? isLight : black,
        ),
        ySpace(height: 10),
        subtext('Change into your character...', context),
        ySpace(height: 10),
        const Divider(),
        ySpace(height: 10),
        Container(
          child: Column(
            children: [
              labelText("avatars...", context),
            ],
          ),
        )
      ],
    );
  }
}
