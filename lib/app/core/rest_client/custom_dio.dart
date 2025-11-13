import 'package:delivery_app/app/core/config/env/env.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class CustomDio extends DioForNative {
  CustomDio()
    : super(
        BaseOptions(
          baseUrl: Env.i['backend_base_url'] ?? '',
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 60),
        ),
      ) {
    interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );
  }

  CustomDio auth() {
    return this;
  }

  CustomDio unauth() {
    return this;
  }
}
