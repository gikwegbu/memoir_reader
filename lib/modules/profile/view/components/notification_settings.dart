import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool _pushNotification = true;
  bool _playSound = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(
          "Notification Settings 🔔",
          context,
          fontWeight: FontWeight.bold,
          color: isDarkMode(context) ? isLight : black,
        ),
        ySpace(height: 10),
        subtext('Configure your notification settings here...', context),
        ySpace(height: 10),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            subtext(
              "Push Notification",
              context,
              fontSize: 14,
            ),
            CupertinoSwitch(
              value: _pushNotification,
              onChanged: (value) {
                setState(() {
                  _pushNotification = value;
                });
              },
            ),
          ],
        ),
        ySpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            subtext(
              "Play Sound",
              context,
              fontSize: 14,
            ),
            CupertinoSwitch(
              value: _playSound,
              onChanged: (value) {
                setState(() {
                  _playSound = value;
                });
              },
            ),
          ],
        ),
        ySpace(height: 10),
        // Play notification Sounds...
      ],
    );
  }
}
