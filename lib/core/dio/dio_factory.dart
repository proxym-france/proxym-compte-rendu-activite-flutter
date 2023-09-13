import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioFactory {
  final String _baseUrl;

  DioFactory(this._baseUrl);

  BaseOptions _createBaseOption() => BaseOptions(
        baseUrl: _baseUrl,
        receiveTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
        connectTimeout: const Duration(seconds: 5),
      );

  Dio create() {
    return Dio(_createBaseOption())
      ..interceptors.addAll([
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(),
        ),
      ]);
  }
}
