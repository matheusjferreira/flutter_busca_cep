import 'package:fpdart/fpdart.dart';

import '../../../../shared/core/client/validations/app_client_exception.dart';
import '../../domain/entities/cep_entity.dart';
import '../../domain/repositories/address_repository.dart';
import '../adapters/address_adapter.dart';
import '../datasources/api_address_datasource.dart';
import '../datasources/local_address_datasouce.dart';

class ApiAndLocalAddressRepository extends AddressRepository {
  final ApiAddressDatasource _apiDatasource;
  final LocalAddressDatasource _cepLocalDatasource;

  ApiAndLocalAddressRepository(
    this._apiDatasource,
    this._cepLocalDatasource,
  );

  @override
  Future<Either<AppClientException, AddressEntity>> getAddress(
      String cep) async {
    try {
      final getFromLocalDataBase = await _cepLocalDatasource.read(
        table: 'Address',
        field: 'cep',
        arg: cep,
      );

      final cepEntity = AddressAdapter.fromJson(getFromLocalDataBase ?? {});

      if (cepEntity.cep.isNotEmpty || cepEntity.cep != '') {
        await _cepLocalDatasource.create(cepEntity);
        return Right(cepEntity);
      }

      final getFromApi = await _apiDatasource.getAddress(cep);
      await _cepLocalDatasource.create(getFromApi);

      return Right(getFromApi);
    } on AppClientException catch (e) {
      return Left(e);
    }
  }
}
