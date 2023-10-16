import 'package:dio/dio.dart';

import '../interfaces/app_client_interface.dart';
import '../urls/app_client_urls.dart';
import '../validations/app_client_error.dart';
import '../validations/app_client_exception.dart';
import '../validations/app_client_interceptors.dart';
import '../validations/app_client_response.dart';

class AppClientDio implements AppClientInterface {
  final dio = createDio();
  late final String baseUrl;

  AppClientDio._internal() {
    baseUrl = AppClientUrls.baseUrl;
  }

  static final _singleton = AppClientDio._internal();

  factory AppClientDio() => _singleton;

  static Dio createDio() {
    final dio = Dio(BaseOptions(
      receiveTimeout: const Duration(milliseconds: 15000),
      connectTimeout: const Duration(milliseconds: 15000),
      sendTimeout: const Duration(milliseconds: 15000),
    ))
      ..interceptors.add(AppClientInterceptors());
    return dio;
  }

  @override
  Future<AppClientResponse> get(String url) async {
    try {
      Response<dynamic> response = await dio.get('$baseUrl$url');

      return AppClientResponse(
        data: response.data,
        statusCode: response.statusCode ?? 0,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final messageBadRequest = e.response?.data['message'];
        throw AppClientException(
          httpClientError: AppClientError.notFound,
          message: messageBadRequest,
        );
      } else if (e.response?.statusCode == 404) {
        throw AppClientException(
          httpClientError: AppClientError.notFound,
        );
      } else if (e.response == null) {
        throw AppClientException(
          httpClientError: AppClientError.requestError,
        );
      } else {
        throw AppClientException(
          httpClientError: AppClientError.internalServerError,
        );
      }
    }
  }
}
