import 'package:fpdart/fpdart.dart';

import '../../../../shared/core/client/validations/app_client_exception.dart';
import '../entities/cep_entity.dart';

abstract class AddressRepository {
  Future<Either<AppClientException, AddressEntity?>> getAddress(String cep);
}
