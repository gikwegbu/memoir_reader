import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class ApiService {
  final BaseOptions options = BaseOptions(
    // receiveDataWhenStatusError: true,
    connectTimeout: 55800,
    receiveTimeout: 59250,
  );

  Dio _instance() {
    Dio dio = Dio(options)
      ..interceptors.add(
        PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            responseBody: true,
            responseHeader: false,
            compact: false,
            error: true,
            maxWidth: 90),
      );

    return dio;
  }

  Dio getDioWith() {
    return _instance()..interceptors;
  }
}
