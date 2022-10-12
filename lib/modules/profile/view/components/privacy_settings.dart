import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/components/custom_button.dart';
import 'package:memoir_reader/modules/test_screen.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/form_utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PrivacySettings extends StatelessWidget {
  const PrivacySettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _gbKey = GlobalKey<FormBuilderState>();
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
                  style: FORM_STYLE,
                  onSaved: (value) => _formValues['confirmPassword'] = value,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        context,
                        errorText: "Field can't be empty",
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
