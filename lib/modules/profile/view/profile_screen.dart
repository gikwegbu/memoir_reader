import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/profile/model/profile_model.dart';
import 'package:memoir_reader/modules/profile/view/components/ai_settings.dart';
import 'package:memoir_reader/modules/profile/view/components/avatar_settings.dart';
import 'package:memoir_reader/modules/profile/view/components/notification_settings.dart';
import 'package:memoir_reader/modules/profile/view/components/privacy_settings.dart';
import 'package:memoir_reader/modules/profile/view/components/profile_settings.dart';
import 'package:memoir_reader/modules/profile/view/my_memoirs.dart';
import 'package:memoir_reader/modules/profile/viewModel/profile_provider.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/const/image_url.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ExpandableBottomSheetState> bottomSheetKey = GlobalKey();
  String _bottomSheetWidget = "";

  ProfileModel _userProfile = ProfileModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _userProfile =
        Provider.of<ProfileProvider>(context, listen: true).profileDetails;
    return Scaffold(
      body: ExpandableBottomSheet(
        key: bottomSheetKey,
        background: ListView(
          padding: EdgeInsets.zero,
          children: [
            _coverImage(),
            _bottomSection(),
          ],
        ),
        expandableContent: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            // filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 30),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _contractBottomSheet,
                    child: Container(
                      height: 8,
                      width: 55,
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    child: _sheetWidget(item: _bottomSheetWidget),
                  ),
                ],
              ),
            ),
          ),
        ),
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
              onTap: () {
                _openBottomSheet('avatar');
              },
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
    return Positioned(
      top: -70,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
        backgroundImage: AssetImage(
          // 'https://media.istockphoto.com/photos/studio-portrait-of-attractive-20-year-old-bearded-man-picture-id1351147752?b=1&k=20&m=1351147752&s=170667a&w=0&h=txEdYegsKceJkltlTnz0hVdaX6wjlDL_vWAjEC_a6Ys=',
          // ImageUtils.dp,
          _userProfile.imageUrl ?? ImageUtils.m1,
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
              labelText(_userProfile.fullname ?? 'Fullname', context),
              const Icon(
                Icons.verified,
                size: 15,
                color: blue,
              ),
            ],
          ),
          Center(
            child: subtext(
              // "@gikwegbu",
              "@${_userProfile.username ?? 'username'}",
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
                      ? "https://wa.me/${_userProfile.whatsappUrl}/?text=${Uri.parse('Hi George, I would want to work with you on a flutter project.')}"
                      : "https://api.whatsapp.com/send?phone=${_userProfile.whatsappUrl}=${Uri.parse('Hi George, I would want to work with you on a flutter project.')}"),
              // _socialIcons(
              //   icon: Icons.email_rounded,
              //   url: "https:www.facebook.com",
              // ),
              _socialIcons(
                icon: FontAwesomeIcons.twitter,
                // url: "https://twitter.com/gikwegbu",
                url: "${_userProfile.twitterUrl}",
              ),
              _socialIcons(
                icon: FontAwesomeIcons.instagram,
                // url: "https://www.instagram.com/g.ikwegbu/",
                url: "${_userProfile.instagramUrl}",
              ),
              _socialIcons(
                icon: FontAwesomeIcons.linkedinIn,
                // url: "http://linkedin.com/in/GIkwegbu",
                url: "${_userProfile.linkedinUrl}",
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
          ySpace(),
          labelText(
            "MEMOIRS",
            context,
            fontWeight: FontWeight.bold,
            color: isDarkMode(context) ? isLight : Colors.grey,
          ),
          ySpace(height: 10),
          _profileItem(
            title: 'My Memoirs',
            subTitle: 'view all your written memoirs',
            item: 'ai',
            icon: Icons.bookmark_add,
            type: 'memoir',
          ),
          ySpace(),
          const Divider(),
          ySpace(height: 10),
          _profileItem(
            title: 'Logout',
            subTitle: 'Click to log out of the application',
            icon: Icons.power_settings_new_outlined,
            type: 'logout',
          ),
          ySpace(height: 10),
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
    String? type,
  }) {
    return InkWell(
      onTap: () {
        // type == 'memoir'
        //     ? navigate(context, MyMemoirScreenScreen.routeName)
        //     : _openBottomSheet(item);
        switch (type) {
          case "memoir":
            navigate(context, MyMemoirScreenScreen.routeName);
            break;
          case "logout":
            logoutUser(context);
            break;
          default:
            _openBottomSheet(item);
        }
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
                xSpace(width: 10),
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

  void _expandBottomSheet() => bottomSheetKey.currentState?.expand();

  void _contractBottomSheet() => bottomSheetKey.currentState?.contract();

  bool _bottomSheetStatus() =>
      bottomSheetKey.currentState!.expansionStatus ==
      ExpansionStatus.contracted;

  void _openBottomSheet(val) {
    _bottomSheetWidget = val;
    _bottomSheetStatus() ? _expandBottomSheet() : _contractBottomSheet();
    setState(() {});
  }

  Widget _sheetWidget({String? item}) {
    switch (item) {
      case 'profile':
        return ProfileSettings(sheetKey: bottomSheetKey);
      // return const ProfileSettings();
      case 'privacy':
        return PrivacySettings(sheetKey: bottomSheetKey);
      case 'notification':
        return const NotificationSettings();
      case 'ai':
        return AiSettings(sheetKey: bottomSheetKey);
      case 'avatar':
        return AvatarSettings(sheetKey: bottomSheetKey);
      default:
        return Container();
    }
  }
}
