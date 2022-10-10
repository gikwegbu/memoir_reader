import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/form_utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreateMemoirScreen extends StatefulWidget {
  const CreateMemoirScreen({Key? key}) : super(key: key);

  @override
  State<CreateMemoirScreen> createState() => _CreateMemoirScreenState();
}

class _CreateMemoirScreenState extends State<CreateMemoirScreen> {
  final _gbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _formValue = {};
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
                    FormBuilderTextField(
                      name: "title",
                      decoration: FormUtils.formDecoration(
                        labelText: "Title",
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 50,
                      // initialValue: "",
                      keyboardType: TextInputType.text,
                      style: FORM_STYLE,
                      onSaved: (value) => _formValue['title'] = value,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            context,
                            errorText: "enter title",
                          )
                        ],
                      ),
                    ),
                    ySpace(),
                    FormBuilderTextField(
                      maxLines: 10,
                      name: "content",
                      decoration: FormUtils.formDecoration(
                        labelText: "Content",
                      ),
                      keyboardType: TextInputType.text,
                      style: FORM_STYLE,
                      onSaved: (value) => _formValue['content'] = value,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            context,
                            errorText: "content can't be empty",
                          ),
                          FormBuilderValidators.minLength(
                            context,
                            150,
                            errorText:
                                "content should be at least 150 characters",
                          ),
                        ],
                      ),
                    ),
                    ySpace(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: CustomButton(
                        title: "Post",
                        press: () {
                          if (_gbKey.currentState!.validate()) {
                            print(".....posting...");
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
                onPressed: () {},
                icon: const Icon(Icons.visibility),
              ),
            ],
          ),
        ),
      ),
      preferredSize: const Size(
        double.infinity,
        39.0,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.press,
    required this.title,
  });

  final Function press;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => press(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: labelText(
          title,
          context,
          textAlign: TextAlign.center,
          color: isDarkMode(context) ? green : isLight,
        ),
      ),
    );
  }
}
