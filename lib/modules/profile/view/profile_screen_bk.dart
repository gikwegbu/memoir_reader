import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/const/image_url.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _coverImage(),
          _bottomSection(),
        ],
      ),
    );
  }

  Stack _coverImage() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          child: Image.asset(
            ImageUtils.profileHeader,
            // 'https://mir-s3-cdn-cf.behance.net/project_modules/2800_opt_1/57dea783589529.5d412d47cbabf.jpg',
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          // top: 200,
          child: Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDarkMode(context) ? isDark : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Stack _bottomSection() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        _contentSection(),
        _profileImage(),
        Positioned(
          // top: 20,
          // right: 1,
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(
              left: 80,
            ),
            decoration: BoxDecoration(
              color: isDarkMode(context) ? isDark : isLight,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: isDark,
              ),
            ),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.camera_alt,
                color: isDarkMode(context) ? isLight : isDark,
              ),
            ),
          ),
        )
      ],
    );
  }

  Positioned _profileImage() {
    return const Positioned(
      top: -70,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
        backgroundImage: AssetImage(
          // 'https://media.istockphoto.com/photos/studio-portrait-of-attractive-20-year-old-bearded-man-picture-id1351147752?b=1&k=20&m=1351147752&s=170667a&w=0&h=txEdYegsKceJkltlTnz0hVdaX6wjlDL_vWAjEC_a6Ys=',
          ImageUtils.dp,
        ),
      ),
    );
  }

  Container _contentSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 50,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              labelText("George Ikwegbu", context),
              const Icon(
                Icons.verified,
                size: 15,
                color: blue,
              ),
            ],
          ),
          Center(
            child: subtext(
              "@gikwegbu",
              context,
              height: 1.5,
              fontSize: 12,
              textAlign: TextAlign.center,
            ),
          ),
          ySpace(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcons(
                  icon: FontAwesomeIcons.whatsapp,
                  url: Platform.isAndroid
                      ? "https://wa.me/+2348101570258/?text=${Uri.parse('Hi George, I would want to work with you on a flutter project.')}"
                      : "https://api.whatsapp.com/send?phone=+2348101570258=${Uri.parse('Hi George, I would want to work with you on a flutter project.')}"),
              // _socialIcons(
              //   icon: Icons.email_rounded,
              //   url: "https:www.facebook.com",
              // ),
              _socialIcons(
                icon: FontAwesomeIcons.twitter,
                url: "https://twitter.com/gikwegbu",
              ),
              _socialIcons(
                icon: FontAwesomeIcons.instagram,
                url: "https://www.instagram.com/g.ikwegbu/",
              ),
              _socialIcons(
                icon: FontAwesomeIcons.linkedinIn,
                url: "http://linkedin.com/in/GIkwegbu",
              ),
            ],
          ),
          const Divider(),
          ySpace(),
          labelText(
            "GENERAL",
            context,
            fontWeight: FontWeight.bold,
            color: isDarkMode(context) ? isLight : Colors.grey,
          ),
          ySpace(height: 10),
          _profileItem(
            title: 'Profile Settings',
            subTitle: 'update & modify your profile',
            item: "profile",
            icon: Icons.account_circle,
          ),
          ySpace(height: 10),
          _profileItem(
            title: 'Privacy',
            subTitle: 'change password',
            item: "privacy",
            icon: Icons.security,
          ),
          ySpace(height: 10),
          _profileItem(
            title: 'Notification',
            subTitle: 'change notification settings',
            item: "notification",
            icon: Icons.notification_add,
          ),
          ySpace(height: 10),
          _profileItem(
            title: 'AI Reader',
            subTitle: 'change AI settings',
            item: 'ai',
            icon: Icons.air_sharp,
          ),
        ],
      ),
    );
  }

  IconButton _socialIcons({IconData? icon, String? url}) {
    // final Uri params = Uri(
    //   scheme: 'mailto',
    //   path: 'email@example.com',
    //   query:
    //       'subject=App Feedback&body=App Version 3.23', //add subject and body here
    // );
    final Uri _url = Uri.parse("$url");
    return IconButton(
      splashRadius: 20,
      onPressed: () async {
        if (!await launchUrl(_url)) {
          throw 'Could not launch $_url';
        }
      },
      color: isDarkMode(context) ? isLight : blue,
      icon: Icon(
        icon,
        size: 25,
        // color: Colors.white,
      ),
    );
  }

  InkWell _profileItem({
    String? title,
    String? subTitle,
    String? item,
    IconData? icon,
  }) {
    return InkWell(
      onTap: () {
        _openBottomSheet(item);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDarkMode(context) ? isDark : black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                xSpace(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      '$title',
                      context,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    subtext(
                      '$subTitle',
                      context,
                      fontSize: 11,
                      color: isDarkMode(context) ? isLight : Colors.grey,
                    )
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_right,
              size: 25,
              color: Colors.black.withOpacity(0.9),
            ),
          ],
        ),
      ),
    );
  }

  void _openBottomSheet(val) {
    print("Opening $val");
  }
}
