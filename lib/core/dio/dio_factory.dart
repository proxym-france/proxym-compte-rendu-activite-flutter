import 'package:dio/dio.dart';
import 'package:mycra_timesheet_app/core/dio/logger_interceptor.dart';


class DioFactory {
  final String _baseUrl;

  DioFactory(this._baseUrl);

  BaseOptions _createBaseOption() => BaseOptions(
        baseUrl: _baseUrl,
        receiveTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
        connectTimeout: const Duration(seconds: 5),
      );

  Dio create() => Dio(_createBaseOption())
    ..interceptors.addAll([
      LoggerInterceptor(),
    ]);
}
