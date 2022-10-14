import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/memoir/model/memoir_model.dart';
import 'package:memoir_reader/modules/memoir/repo/memoir_service.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:tuple/tuple.dart';

ApiServices _apiServices = ApiServices();

class MemoirProvider extends ChangeNotifier {
  bool _isFetchingMemoir = false;
  Pagination? _pagination;
  List<MemoirModel>? _memoirData;

  // Getters
  bool get isFetchingMemoir => _isFetchingMemoir;
  Pagination? get getPagination => _pagination;
  List<MemoirModel>? get getMemoirData => _memoirData;

  // Setters
  setIsFetchingMemoir(bool val) {
    _isFetchingMemoir = val;
    notifyListeners();
  }

  setPagination(Pagination? val) {
    _pagination = val;
    notifyListeners();
  }

  setMemoirData(List<MemoirModel>? val) {
    _memoirData = val;
    notifyListeners();
  }

  // Function Calls
  Future<Tuple2<MemoirApiModel?, dynamic>> fetchMemoir({
    int limit = 10,
  }) async {
    setIsFetchingMemoir(true);
    try {
      final _res = await _apiServices.fetchMemoirs(limit: limit);

      if (_res.item1 != null) {
        setIsFetchingMemoir(false);
        MemoirApiModel? data = _res.item1;

        setPagination(data?.pagination);
        setMemoirData(data?.data);
        return _res;
      } else {
        textNotification(
          message: _res.item2.toString(),
          duration: const Duration(milliseconds: 2500),
        );
        return _res;
      }
    } catch (e) {
      return Tuple2(null, e);
    } finally {
      setIsFetchingMemoir(false);
    }
  }
}
