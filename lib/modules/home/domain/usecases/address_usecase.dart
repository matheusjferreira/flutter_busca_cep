import 'package:fpdart/fpdart.dart';

import '../../../../shared/core/client/validations/app_client_exception.dart';
import '../entities/cep_entity.dart';
import '../repositories/address_repository.dart';

abstract class AddressUsecase {
  Future<Either<AppClientException, AddressEntity?>> call(String cep);
}

class Address implements AddressUsecase {
  final AddressRepository _addressRepository;

  Address(this._addressRepository);

  @override
  Future<Either<AppClientException, AddressEntity?>> call(String cep) async {
    return await _addressRepository.getAddress(cep);
  }
}
