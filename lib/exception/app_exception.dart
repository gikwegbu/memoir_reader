// import 'package:amaze/core/model/api_response.dart';
// import 'package:amaze/core/model/paystack_response.dart';
// import 'package:amaze/utils/utils.dart';
// import 'package:dio/dio.dart';

// class AppException implements Exception {
//   final dynamic _message;

//   AppException([this._message]);

//   @override
//   String toString() => "$_message";

//   static ApiResponse handleError(DioError e) {
//     if(!isObjectEmpty(e.response)) {
//       if (DioErrorType.response == e.type && e.response?.data is Map<String, dynamic>) {
//         print(e.response?.data);
//         ApiResponse response = ApiResponse.fromJson(e.response?.data);
//         return response;
//       }
//     }
//     throw AppException(handleException(e.type));
//   }
// }


// class PaystackException implements Exception {
//   final dynamic _message;

//   PaystackException([this._message]);

//   @override
//   String toString() => "$_message";

//   static PaystackResponse handleError(DioError e) {
//     if(!isObjectEmpty(e.response)) {
//       if (DioErrorType.response == e.type && e.response?.data is Map<String, dynamic>) {
//         PaystackResponse response = PaystackResponse.fromJson(e.response?.data);
//         return response;
//       }
//     }
//     throw AppException(handleException(e.type));
//   }
// }

// class FetchDataException extends AppException {
//   FetchDataException([String? message]) : super(message);
// }

// class BadRequestException extends AppException {
//   BadRequestException([message]) : super(message);
// }

// class UnauthorisedException extends AppException {
//   UnauthorisedException([message]) : super(message);
// }

// class InvalidInputException extends AppException {
//   InvalidInputException([String? message]) : super(message);
// }

// String handleException(DioErrorType? errorType) {
//   // HandshakeException: Connection terminated during handshake
//   if (DioErrorType.connectTimeout == errorType) {
//     return "Please check your internet connection and try again!";
//   } else if (DioErrorType.receiveTimeout == errorType && DioErrorType.sendTimeout == errorType) {
//     return "Your request has been timed out";
//   } else {
//     return "Something went wrong, Please try again later!";
//   }
// }