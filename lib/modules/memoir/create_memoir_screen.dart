import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memoir_reader/modules/components/custom_button.dart';
import 'package:memoir_reader/modules/memoir/memoir_details_screen.dart';
import 'package:memoir_reader/modules/test_screen.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/form_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:bot_toast/bot_toast.dart';

class CreateMemoirScreen extends StatefulWidget {
  const CreateMemoirScreen({Key? key}) : super(key: key);

  @override
  State<CreateMemoirScreen> createState() => _CreateMemoirScreenState();
}

class _CreateMemoirScreenState extends State<CreateMemoirScreen> {
  final _gbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _formValues = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(top: 20),
          // color: Colors.red,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilder(
                key: _gbKey,
                child: Column(
                  children: [
                    _formBuilder(
                      "Title",
                      form: FormBuilderTextField(
                        name: "Title",
                        inputFormatters: [LengthLimitingTextInputFormatter(30)],
                        decoration: FormUtils.formDecoration(),
                        maxLength: 30,
                        style: FORM_STYLE,
                        onSaved: (value) => _formValues['title'] = value,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(context,
                                errorText: 'Please provide title'),
                          ],
                        ),
                      ),
                    ),
                    ySpace(),
                    _formBuilder(
                      "Content",
                      form: FormBuilderTextField(
                        name: "Content",
                        // inputFormatters: [
                        //   LengthLimitingTextInputFormatter(1000)
                        // ],
                        decoration: FormUtils.formDecoration(),
                        maxLines: 10,
                        // maxLength: 1000,
                        style: FORM_STYLE,
                        onSaved: (value) => _formValues['content'] = value,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                              context,
                              errorText: "Content can't be empty",
                            ),
                            FormBuilderValidators.minLength(
                              context,
                              50,
                              errorText:
                                  "content should be at least 50 characters",
                            ),
                          ],
                        ),
                      ),
                    ),
                    ySpace(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: CustomButton(
                        title: "Post",
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
          ),
        ),
      ),
    );
  }

  Column _formBuilder(String label, {required Widget form, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(label: label, hint: hint),
        form,
      ],
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AppBar(
            backgroundColor: Colors.black.withOpacity(0.2),
            title: const Text('Create memoir'),
            elevation: 0.0,
            actions: [
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  if (_gbKey.currentState!.validate()) {
                    _gbKey.currentState!.save();
                    memoirLoader();
                    Future.delayed(const Duration(milliseconds: 4000), () {
                      BotToast.closeAllLoading();
                      navigate(
                        context,
                        MemoirDetailsScreen.routeName,
                        arguments: MemoirDetailsScreenArguements(
                          id: DateTime.now().toString(),
                          title: _formValues['title'],
                          content: _formValues['content'],
                        ),
                      );
                    });
                  }
                },
                icon: const Icon(Icons.visibility),
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size(
        double.infinity,
        Platform.isIOS ? 39 : 45,
      ),
    );
  }
}
