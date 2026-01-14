import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SharedPreferences.getInstance().then((prefs) => prefs.getString('accessToken'));

    options.headers['Authorization'] = 'Bearer $token';

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await SharedPreferences.getInstance().then((prefs) => prefs.clear());
      handler.next(err);
    }

    handler.next(err);
  }
}
