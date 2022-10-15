import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:memoir_reader/modules/profile/model/ai_settings_model.dart';
import 'package:memoir_reader/utils/utils.dart';
// import 'package:tuple/tuple.dart';

class AiProvider extends ChangeNotifier {
  static const String aiBoxName = "aiBox";

  bool _isUpdateingAi = false;
  AiSettingsModel _aiDetails = AiSettingsModel();

  // Getters
  bool get isUpdateingAi => _isUpdateingAi;
  AiSettingsModel get aiDetails =>
      _aiDetails; // Upon launching of the app, provide where this data will be retrieved from...

  // Setters

  setIsUpdateingAi(bool val) {
    _isUpdateingAi = val;
    notifyListeners();
  }

  setUpdateAiSettings(AiSettingsModel val) async {
    var _box = Hive.box<AiSettingsModel>(aiBoxName);
    _box.put('aiDetails', val);

    var _ = _box.get('aiDetails');
    _aiDetails = val;
    // print(_?.toJson());
    showNotification(
      message: 'Settings Updated Successfully!',
      duration: const Duration(milliseconds: 2000),
    );
    notifyListeners();
  }

  bool updateAiSettings(data) {
    setUpdateAiSettings(data);

    notifyListeners();
    return true;
  }
}
