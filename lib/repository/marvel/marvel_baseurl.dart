import 'package:dio/dio.dart';

class MarvelBaseUrl {
  final _dio = Dio();

  Dio get dio => _dio;

  MarvelBaseUrl() {
    _dio.options.baseUrl = "https://gateway.marvel.com/v1/public";
  }
}
