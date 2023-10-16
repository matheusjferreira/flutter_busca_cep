import 'dart:convert';

import 'package:http/http.dart' as http;

import '../interfaces/app_client_interface.dart';
import '../urls/app_client_urls.dart';
import '../validations/app_client_error.dart';
import '../validations/app_client_exception.dart';
import '../validations/app_client_response.dart';

class AppClientHttp implements AppClientInterface {
  late final String baseUrl;

  AppClientHttp._internal() {
    baseUrl = AppClientUrls.baseUrl;
  }

  static final _singleton = AppClientHttp._internal();

  factory AppClientHttp() => _singleton;

  @override
  Future<AppClientResponse> get(String url) async {
    http.Response response = await http
        .get(
      Uri.parse('$baseUrl$url'),
    )
        .catchError((onError) {
      throw AppClientException(
        httpClientError: AppClientError.requestError,
      );
    });

    if (response.statusCode == 200) {
      return AppClientResponse(
        data: jsonDecode(response.body),
        statusCode: response.statusCode,
      );
    } else {
      if (response.statusCode == 400) {
        final decode = jsonDecode(response.body);
        final messageBadRequest = decode['message'];
        throw AppClientException(
          httpClientError: AppClientError.notFound,
          message: messageBadRequest,
        );
      } else if (response.statusCode == 404) {
        throw AppClientException(
          httpClientError: AppClientError.notFound,
        );
      } else {
        throw AppClientException(
          httpClientError: AppClientError.internalServerError,
        );
      }
    }
  }
}
