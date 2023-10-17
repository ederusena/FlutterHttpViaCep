import 'package:dio/dio.dart';

class JsonPlacehoderCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  JsonPlacehoderCustomDio() {
    _dio.options.baseUrl = "https://jsonplaceholder.typicode.com";
  }
}
