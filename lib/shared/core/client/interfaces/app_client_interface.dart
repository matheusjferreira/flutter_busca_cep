import 'package:busca_cep/shared/core/client/validations/app_client_response.dart';

abstract class AppClientInterface {
  Future<AppClientResponse> get(String cep);
}
