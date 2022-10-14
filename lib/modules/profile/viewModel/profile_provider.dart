import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:memoir_reader/modules/profile/model/profile_model.dart';
import 'package:memoir_reader/utils/utils.dart';
// import 'package:tuple/tuple.dart';

class ProfileProvider extends ChangeNotifier {
  static const String _profileBoxName = "profileBox";

  bool _isUpdateingProfile = false;
  ProfileModel _profileDetails = ProfileModel();

  // Getters
  bool get isUpdateingProfile => _isUpdateingProfile;
  ProfileModel get profileDetails =>
      _profileDetails; // Upon launching of the app, provide where this data will be retrieved from...

  // Setters

  setIsUpdateingProfile(bool val) {
    _isUpdateingProfile = val;
    notifyListeners();
  }

  setUpdateProfile(ProfileModel val) async {
    var _box = Hive.box<ProfileModel>(_profileBoxName);
    _box.put('profileDetails', val);

    var _ = _box.get('profileDetails');
    _profileDetails = val;
    // print(_?.toJson());
    showNotification(
      message: 'Profile Updated Successfully!',
      duration: const Duration(milliseconds: 2000),
    );
    notifyListeners();
  }

  bool updateProfile(data) {
    setUpdateProfile(data);

    notifyListeners();
    return true;
  }
}
