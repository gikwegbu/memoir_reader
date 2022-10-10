import 'package:flutter/material.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          child: Image.network(
            'https://mir-s3-cdn-cf.behance.net/project_modules/2800_opt_1/57dea783589529.5d412d47cbabf.jpg',
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
        
      ],
    );
  }

  Positioned _profileImage() {
    return const Positioned(
      top: -70,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(
          'https://media.istockphoto.com/photos/studio-portrait-of-attractive-20-year-old-bearded-man-picture-id1351147752?b=1&k=20&m=1351147752&s=170667a&w=0&h=txEdYegsKceJkltlTnz0hVdaX6wjlDL_vWAjEC_a6Ys=',
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
                icon: Icons.facebook_rounded,
                press: () {},
              ),
              _socialIcons(
                icon: Icons.email_rounded,
                press: () {},
              ),
              _socialIcons(
                icon: FontAwesomeIcons.twitter,
                press: () {},
              ),
              _socialIcons(
                icon: FontAwesomeIcons.instagram,
                press: () {},
              ),
              _socialIcons(
                icon: FontAwesomeIcons.linkedinIn,
                press: () {},
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
            press: () {},
            icon: Icons.account_circle,
          ),
          ySpace(height: 10),
          _profileItem(
            title: 'Privacy',
            subTitle: 'change password',
            press: () {},
            icon: Icons.security,
          ),
          ySpace(height: 10),
          _profileItem(
            title: 'Notification',
            subTitle: 'change notification settings',
            press: () {},
            icon: Icons.notification_add,
          ),
          ySpace(height: 10),
          _profileItem(
            title: 'AI Reader',
            subTitle: 'change AI settings',
            press: () {},
            icon: Icons.air_sharp,
          ),
        ],
      ),
    );
  }

  IconButton _socialIcons({IconData? icon, Function? press}) {
    return IconButton(
      splashRadius: 20,
      onPressed: () => press,
      color: isDarkMode(context) ? isDark : blue,
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
    Function? press,
    IconData? icon,
  }) {
    return InkWell(
      onTap: () => press,
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
                    color: isDarkMode(context) ? isDark : blue,
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
}