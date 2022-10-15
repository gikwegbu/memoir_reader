import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/components/custom_button.dart';
import 'package:memoir_reader/modules/memoir/model/custom_memoir_model.dart';
import 'package:memoir_reader/modules/memoir/view/memoir_details_screen.dart';
import 'package:memoir_reader/modules/memoir/viewModel/memoir_provider.dart';
import 'package:memoir_reader/modules/profile/model/profile_model.dart';
import 'package:memoir_reader/modules/profile/view/my_memoirs.dart';
import 'package:memoir_reader/modules/profile/viewModel/profile_provider.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/form_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateMemoirScreen extends StatefulWidget {
  const CreateMemoirScreen({Key? key}) : super(key: key);

  @override
  State<CreateMemoirScreen> createState() => _CreateMemoirScreenState();
}

class _CreateMemoirScreenState extends State<CreateMemoirScreen> {
  final _gbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProfileModel? _userProfile;
  CustomMemoirModel _memoirModel = CustomMemoirModel();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  var _formValues = {};

  @override
  void initState() {
    _userProfile = context.read<ProfileProvider>().profileDetails;
    super.initState();
  }

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
                        // inputFormatters: [LengthLimitingTextInputFormatter(30)],
                        decoration: FormUtils.formDecoration(),
                        controller: _titleController,
                        // maxLength: 30,
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
                        controller: _contentController,
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
                              200,
                              errorText:
                                  "content should be at least 200 characters",
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
                          if (_gbKey.currentState!.validate()) {
                            _createMemoir();
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

  void _createMemoir() async {
    _gbKey.currentState?.save();
    var uuid = Uuid();

    var _res = await context.read<MemoirProvider>().addCustomMemoir(
          _memoirModel.copyWith(
            id: uuid.toString(),
            author: _userProfile?.fullname,
            username: _userProfile?.username,
            title: _formValues['title'],
            description: _formValues['content'],
            publishedAt: DateTime.now(),
          ),
        );
    if (_res) {
      // clear the form...
      _titleController.text = '';
      _contentController.text = '';
      navigate(context, MyMemoirScreenScreen.routeName);
    }
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
