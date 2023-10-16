import '../../../../shared/core/client/interfaces/app_client_interface.dart';
import '../../domain/entities/cep_entity.dart';
import '../adapters/address_adapter.dart';

abstract class ApiAddressDatasource {
  Future<AddressEntity> getAddress(String cep);
}

class ApiAddress extends ApiAddressDatasource {
  final AppClientInterface _appClient;

  ApiAddress(this._appClient);

  @override
  Future<AddressEntity> getAddress(String cep) async {
    cep = cep.replaceAll("-", "");
    var response = await _appClient.get('/ws/$cep/json/');

    return AddressAdapter.fromJson(response.data);
  }
}
