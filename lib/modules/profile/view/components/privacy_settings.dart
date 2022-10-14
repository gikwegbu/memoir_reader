import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/components/custom_button.dart';
import 'package:memoir_reader/modules/profile/model/profile_model.dart';
import 'package:memoir_reader/modules/profile/viewModel/profile_provider.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/form_utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class PrivacySettings extends StatefulWidget {
  const PrivacySettings({Key? key, required this.sheetKey}) : super(key: key);
  final GlobalKey<ExpandableBottomSheetState> sheetKey;

  @override
  State<PrivacySettings> createState() => _PrivacySettingsState();
}

class _PrivacySettingsState extends State<PrivacySettings> {
  final _gbKey = GlobalKey<FormBuilderState>();
  ProfileModel _userProfile = ProfileModel();
  TextEditingController _oldPasswordTextController = TextEditingController();
  TextEditingController _newPasswordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();

  @override
  void initState() {
    _userProfile = context.read<ProfileProvider>().profileDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _formValues = {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(
          "Privacy Settings 🔐",
          context,
          fontWeight: FontWeight.bold,
          color: isDarkMode(context) ? isLight : black,
        ),
        ySpace(height: 10),
        subtext('Get to update your password details here...', context),
        ySpace(height: 10),
        const Divider(),
        FormBuilder(
          key: _gbKey,
          child: Column(
            children: [
              _formBuilder(
                "Current Password",
                form: FormBuilderTextField(
                  name: "currentPassword",
                  decoration: FormUtils.formDecoration(
                    hintText: "********",
                  ),
                  obscureText: true,
                  controller: _oldPasswordTextController,
                  style: FORM_STYLE,
                  onSaved: (value) => _formValues['currentPassword'] = value,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context,
                          errorText: "Field can't be empty"),
                    ],
                  ),
                ),
                hint: "The password you logged in with",
              ),
              ySpace(height: 15),
              _formBuilder(
                "New Password",
                form: FormBuilderTextField(
                  name: "newPassword",
                  decoration: FormUtils.formDecoration(
                    hintText: "********",
                  ),
                  obscureText: true,
                  controller: _newPasswordTextController,
                  style: FORM_STYLE,
                  onSaved: (value) => _formValues['newPassword'] = value,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        context,
                        errorText: "Field can't be empty",
                      ),
                    ],
                  ),
                ),
              ),
              ySpace(height: 5),
              _formBuilder(
                "Confirm Password",
                form: FormBuilderTextField(
                  name: "confirmPassword",
                  decoration: FormUtils.formDecoration(
                    hintText: "********",
                  ),
                  obscureText: true,
                  controller: _confirmPasswordTextController,
                  style: FORM_STYLE,
                  onSaved: (value) => _formValues['confirmPassword'] = value,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        context,
                        errorText: "Field can't be empty",
                      ),
                      FormBuilderValidators.match(
                        context,
                        // '${_formValues['newPassword']}',
                        _newPasswordTextController.text,
                        errorText: "Must match the new password",
                      ),
                    ],
                  ),
                ),
                hint: "Must match the new password",
              ),
              ySpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: CustomButton(
                  title: "Update Password",
                  press: () {
                    // print("${_oldPasswordTextController.text}");
                    // print("${_newPasswordTextController.text}");
                    // print("${_confirmPasswordTextController.text}");
                    if (_gbKey.currentState!.validate()) {
                      _updatePrivary();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column _formBuilder(String label, {required Widget form, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(
          label: label,
          hint: hint,
          color: black,
        ),
        form,
      ],
    );
  }

  void _updatePrivary() {
    _gbKey.currentState!.save();
    _oldPasswordTextController.text = '';
    _newPasswordTextController.text = '';
    _confirmPasswordTextController.text = '';
    // bool res = context.read<ProfileProvider>().updateProfile(
    //       _userProfile.copyWith(
    //         fullname: _formValues['fullname'],
    //         username: _usernameChecker(_formValues['username']),
    //         whatsappUrl: _formValues['whatsapp'],
    //         twitterUrl: _formValues['twitter'],
    //         instagramUrl: _formValues['instagram'],
    //         linkedinUrl: _formValues['linkedIn'],
    //       ),
    //     );
    // if (res) {
    widget.sheetKey.currentState?.contract();
    // }
  }
}
