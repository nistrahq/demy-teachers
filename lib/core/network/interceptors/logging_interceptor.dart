import 'package:demy_teachers/config/logger/logger_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LoggerConfig.log('[API →] ${options.method} ${options.uri}');
    if (options.data != null) LoggerConfig.log('[BODY] ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LoggerConfig.log('[API ←] [${response.statusCode}] ${response.realUri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LoggerConfig.error('[API ERROR] ${err.message}');
    handler.next(err);
  }
}