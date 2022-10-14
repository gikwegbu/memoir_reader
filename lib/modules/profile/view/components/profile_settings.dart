import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memoir_reader/modules/components/custom_button.dart';
import 'package:memoir_reader/modules/profile/model/profile_model.dart';
import 'package:memoir_reader/modules/profile/viewModel/profile_provider.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/form_utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key, required this.sheetKey}) : super(key: key);

  final GlobalKey<ExpandableBottomSheetState> sheetKey;

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _gbKey = GlobalKey<FormBuilderState>();
  var _formValues = {};
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
          "Profile Settings ⚙️",
          context,
          fontWeight: FontWeight.bold,
          color: isDarkMode(context) ? isLight : black,
        ),
        ySpace(height: 10),
        subtext('Get to update your profile details here...', context),
        ySpace(height: 10),
        const Divider(),
        FormBuilder(
          key: _gbKey,
          child: Column(
            children: [
              _formBuilder(
                "Fullname",
                form: FormBuilderTextField(
                  name: "fullname",
                  initialValue: _userProfile.fullname ?? '',
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  decoration: FormUtils.formDecoration(),
                  maxLength: 30,
                  style: FORM_STYLE,
                  onSaved: (value) => _formValues['fullname'] = value,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context,
                          errorText: "Field can't be empty"),
                    ],
                  ),
                ),
              ),
              ySpace(height: 5),
              _formBuilder(
                "Username",
                form: FormBuilderTextField(
                  name: "username",
                  initialValue: _userProfile.username ?? '',
                  inputFormatters: [LengthLimitingTextInputFormatter(15)],
                  decoration: FormUtils.formDecoration(),
                  // maxLines: 10,
                  maxLength: 15,
                  style: FORM_STYLE,
                  onSaved: (value) => _formValues['username'] = value,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        context,
                        errorText: "Field can't be empty",
                      )
                    ],
                  ),
                ),
              ),
              ySpace(height: 5),
              _formBuilder(
                "Whatsapp Number",
                form: FormBuilderTextField(
                  name: "whatsapp",
                  initialValue: _userProfile.whatsappUrl ?? '',
                  enableSuggestions: true,
                  keyboardType: TextInputType.phone,
                  decoration: FormUtils.formDecoration(
                    hintText: "+234",
                  ),
                  style: FORM_STYLE,
                  onSaved: (value) => _formValues['whatsapp'] = value,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        context,
                        errorText: "Field can't be empty",
                      ),
                      FormBuilderValidators.integer(
                        context,
                        errorText: "Enter a valid number",
                      ),
                    ],
                  ),
                ),
                hint: "Provide your country code too",
              ),
              ySpace(height: 5),
              _formBuilder(
                "Twitter Profile",
                form: FormBuilderTextField(
                  enableSuggestions: true,
                  name: "twitter",
                  initialValue: _userProfile.twitterUrl ?? '',
                  decoration: FormUtils.formDecoration(
                    hintText: "https://",
                  ),
                  style: FORM_STYLE,
                  onSaved: (value) => _formValues['twitter'] = value,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        context,
                        errorText: "Field can't be empty",
                      ),
                      FormBuilderValidators.url(
                        context,
                        errorText: "Enter a valid url",
                      ),
                    ],
                  ),
                ),
                hint: "Paste your twitter profile link to this field.",
              ),
              ySpace(height: 5),
              _formBuilder(
                "LinkedIn Profile",
                form: FormBuilderTextField(
                  name: "linkedIn",
                  initialValue: _userProfile.linkedinUrl ?? '',
                  enableSuggestions: true,
                  decoration: FormUtils.formDecoration(
                    hintText: "https://",
                  ),
                  style: FORM_STYLE,
                  onSaved: (value) => _formValues['linkedIn'] = value,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        context,
                        errorText: "Field can't be empty",
                      ),
                      FormBuilderValidators.url(
                        context,
                        errorText: "Enter a valid url",
                      ),
                    ],
                  ),
                ),
                hint: "Paste your linkedIn profile link in this field.",
              ),
              ySpace(height: 5),
              _formBuilder(
                "Instagram Profile",
                form: FormBuilderTextField(
                  name: "instagram",
                  initialValue: _userProfile.instagramUrl ?? '',
                  enableSuggestions: true,
                  decoration: FormUtils.formDecoration(
                    hintText: "https://",
                  ),
                  style: FORM_STYLE,
                  onSaved: (value) => _formValues['instagram'] = value,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        context,
                        errorText: "Field can't be empty",
                      ),
                      FormBuilderValidators.url(
                        context,
                        errorText: "Enter a valid url",
                      ),
                    ],
                  ),
                ),
                hint: "Paste your Instagram profile link in this field.",
              ),
              ySpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: CustomButton(
                  title: "Update",
                  press: () {
                    if (_gbKey.currentState!.validate()) {
                      _updateProfile();
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

  void _updateProfile() {
    _gbKey.currentState!.save();
    bool res = context.read<ProfileProvider>().updateProfile(
          _userProfile.copyWith(
            fullname: _formValues['fullname'],
            username: _usernameChecker(_formValues['username']),
            whatsappUrl: _formValues['whatsapp'],
            twitterUrl: _formValues['twitter'],
            instagramUrl: _formValues['instagram'],
            linkedinUrl: _formValues['linkedIn'],
          ),
        );
    if (res) {
      widget.sheetKey.currentState?.contract();
    }
  }

  String _usernameChecker(val) {
    var _username = val.replaceAll(' ', '');
    return _username[0] == '@'
        ? _username.substring(1, _username.length)
        : _username;
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
}
