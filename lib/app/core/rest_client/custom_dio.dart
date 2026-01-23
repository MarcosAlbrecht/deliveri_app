import 'package:delivery_app/app/core/config/env/env.dart';
import 'package:delivery_app/app/core/rest_client/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class CustomDio extends DioForNative {
  late AuthInterceptor _authInterceptor;
  CustomDio()
    : super(
        BaseOptions(
          baseUrl: Env.i['backend_base_url'] ?? '',
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 60),
        ),
      ) {
    _authInterceptor = AuthInterceptor(this);
    interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );
  }

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  CustomDio unauth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
