import 'app_client_error.dart';

class AppClientException implements Exception {
  String? message;
  AppClientError httpClientError;

  AppClientException({this.message, required this.httpClientError});

  String getMessage() {
    if (message != null) {
      return message.toString();
    }
    return httpClientError.message;
  }
}
