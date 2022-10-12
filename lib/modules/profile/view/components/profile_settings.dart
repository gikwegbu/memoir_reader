import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memoir_reader/modules/components/custom_button.dart';
import 'package:memoir_reader/modules/test_screen.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/form_utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _gbKey = GlobalKey<FormBuilderState>();
  var _formValues = {};
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
                      ),
                    ],
                  ),
                ),
              ),
              ySpace(height: 5),
              _formBuilder(
                "Whatsapp Number",
                form: FormBuilderTextField(
                  name: "whatsapp",
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
                    ],
                  ),
                ),
                hint: "Paste your twitter profile link to this field.",
              ),
              ySpace(height: 5),
              _formBuilder(
                "LinkedIn Profile",
                form: FormBuilderTextField(
                  name: "twitter",
                  enableSuggestions: true,
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
                    ],
                  ),
                ),
                hint: "Paste your linkedIn profile link in this field.",
              ),
              ySpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: CustomButton(
                  title: "Update",
                  press: () {
                    navigate(context, TestScreen.routeName);
                    if (_gbKey.currentState!.validate()) {
                      print("Caching.....");
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
}
