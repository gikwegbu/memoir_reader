import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/profile/model/profile_model.dart';
import 'package:memoir_reader/modules/profile/viewModel/profile_provider.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/const/image_url.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:provider/provider.dart';

class AvatarSettings extends StatefulWidget {
  const AvatarSettings({
    Key? key,
    required this.sheetKey,
  }) : super(key: key);

  final GlobalKey<ExpandableBottomSheetState> sheetKey;

  @override
  State<AvatarSettings> createState() => _AvatarSettingsState();
}

class _AvatarSettingsState extends State<AvatarSettings> {
  String _selectedAvatar = ImageUtils.dp;
  var _selectedAvatarIndex;
  var _selectedAvatarId;
  final _mAvatar = [
    {'id': "dfcserqwesdfa", 'file': ImageUtils.m1},
    {'id': "cvadgdafgsdfa", 'file': ImageUtils.m2},
    {'id': "cxzvdfasdaewe", 'file': ImageUtils.m3},
    {'id': "xcsawerqweasdfa", 'file': ImageUtils.m4},
    {'id': "czvdasdrwegq", 'file': ImageUtils.m5},
  ];
  final _fAvatar = [
    {'id': "dfascvzwerqwe", 'file': ImageUtils.f1},
    {'id': "asdkwerqwerqwefasldfa", 'file': ImageUtils.f2},
    {'id': "fadsfasdfasd", 'file': ImageUtils.f3},
    {'id': "asdkffasdcvzcasldfa", 'file': ImageUtils.f4},
    {'id': "dfasrwerqwerq", 'file': ImageUtils.f5},
    {'id': "asdfwerwqer", 'file': ImageUtils.f6},
    {'id': "dfasdfaeqrew", 'file': ImageUtils.f7},
  ];

  ProfileModel _userProfile = ProfileModel();

  @override
  void initState() {
    _userProfile = context.read<ProfileProvider>().profileDetails;
    super.initState();
  }

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            subtext('Change into your character...', context),
            InkWell(
              onTap: () => _updateProfileImage(),
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
        SizedBox(
          height: 120,
          child: ListView.builder(
              itemCount: _mAvatar.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, index) {
                var file = _mAvatar[index]['file'];
                var id = _mAvatar[index]['id'];
                return _avatarOptions(file, id, index);
              }),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            itemCount: _fAvatar.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, index) {
              var file = _fAvatar[index]['file'];
              var id = _fAvatar[index]['id'];
              return _avatarOptions(file, id, index);
            },
          ),
        ),
      ],
    );
  }

  void _updateProfileImage() {
    bool res = context.read<ProfileProvider>().updateProfile(
          _userProfile.copyWith(
            imageUrl: _selectedAvatar,
          ),
        );

    if (res) {
      widget.sheetKey.currentState?.contract();
    }
  }

  Widget _avatarOptions(file, id, index) {
    return InkWell(
      onTap: () {
        _selectedAvatar = file;
        _selectedAvatarId = id;
        _selectedAvatarIndex = index;
        setState(() {});
      },
      child: Container(
        height: 50,
        width: 120,
        margin: const EdgeInsets.all(9),
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          // color: _selectedAvatarIndex == index ? black : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: black, width: 1, style: BorderStyle.solid),
          image: DecorationImage(
            image: AssetImage(file),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
