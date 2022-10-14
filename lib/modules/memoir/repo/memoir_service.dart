import 'package:dio/dio.dart';
import 'package:memoir_reader/config/dio_config.dart';
import 'package:memoir_reader/config/env.config.dart';
import 'package:memoir_reader/modules/memoir/model/memoir_model.dart';
import 'package:memoir_reader/utils/const/api.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:tuple/tuple.dart';

class ApiServices extends ApiService {
  // Fetch Memoirs
  Future<Tuple2<MemoirApiModel?, dynamic>> fetchMemoirs({
    int? limit,
  }) async {
    final _dio = super.getDioWith();
    try {
      Response _response = await _dio.get(
        // '${Apis.memoirApi}?access_key=$apiKey&categories=entertainment&languages=en',
        '${Apis.memoirApi}?access_key=$apiKey&categories=entertainment&languages=en&limit=$limit',
        // 9688, 9690
        // options: Options(
        //   contentType: Headers.jsonContentType,
        //   headers: {
        //     'Authorization': 'Bearer $apiKey',
        //   },
        // ),
      );
      MemoirApiModel? _res = MemoirApiModel.fromJson(_response.data);
      // Returning everything, so i'd have access to the pagination data too...
      return Tuple2(_res, null);
    } on DioError catch (e) {
      // {
      //   "error": {
      //       "code": "validation_error",
      //       "message": "Validation error",
      //       "context": {
      //         "date": [
      //             "NO_SUCH_CHOICE_ERROR"
      //         ]
      //       }
      //   }
      // }
      // ignore: prefer_if_null_operators
      var formatError = e.response!.data['error']['message'];

      showNotification(
        message: formatError.toString(),
        duration: const Duration(milliseconds: 2500),
      );
      return Tuple2(null, formatError);
    }
  }
}
