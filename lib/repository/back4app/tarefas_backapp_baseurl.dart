import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trilhapp/repository/back4app/back4app_dio_interceptor.dart';

class TarefasBack4ppBaseUrl {
  final _dio = Dio();

  Dio get dio => _dio;

  TarefasBack4ppBaseUrl() {
    _dio.options.baseUrl = dotenv.get("BACK4APP_BASE_URL");
    _dio.interceptors.add(Back4AppDioInterceptor());
  }
}
