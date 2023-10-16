import 'package:busca_cep/modules/home/domain/entities/cep_entity.dart';
import 'package:busca_cep/modules/home/infra/datasources/api_address_datasource.dart';
import 'package:busca_cep/modules/home/infra/datasources/local_address_datasouce.dart';
import 'package:busca_cep/modules/home/infra/repositories/api_and_local_address_repository.dart';
import 'package:busca_cep/shared/core/client/validations/app_client_error.dart';
import 'package:busca_cep/shared/core/client/validations/app_client_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class ApiAddressMock extends Mock implements ApiAddress {}

class LocalAddressMock extends Mock implements LocalAddress {}

class AppClientExceptionFake extends Fake implements AppClientException {}

void main() {
  late ApiAddress apiDatasource;
  late LocalAddress cepLocalDatasource;
  final addressEntity = AddressEntity(
    cep: '01001-000',
    logradouro: 'Praça da Sé',
    complemento: 'lado ímpar',
    bairro: 'Sé',
    localidade: 'São Paulo',
    uf: 'SP',
    ibge: '3550308',
    gia: '1004',
    ddd: '11',
    siafi: '7107',
  );

  setUpAll(() {
    apiDatasource = ApiAddressMock();
    cepLocalDatasource = LocalAddressMock();
  });

  group('ApiAndLocalAddressRepository |', () {
    test('Should return AddressEntity when request is successful.', () async {
      when(() => cepLocalDatasource.read(
            table: 'Address',
            field: 'cep',
            arg: '01001-000',
          )).thenAnswer(
        (_) async => {},
      );

      when(() => apiDatasource.getAddress('01001-000'))
          .thenAnswer((_) async => addressEntity);

      when(() => cepLocalDatasource.create(addressEntity))
          .thenAnswer((_) async => 01);

      final sut =
          ApiAndLocalAddressRepository(apiDatasource, cepLocalDatasource);
      final result = await sut.getAddress('01001-000');

      expect(result.isRight(), true);
      expect(result, isA<Right<AppClientException, AddressEntity>>());
    });

    test('Should return AppClientException when request is failure.', () async {
      when(() => cepLocalDatasource.read(
            table: 'Address',
            field: 'cep',
            arg: '01001-000',
          )).thenAnswer(
        (_) async => {},
      );

      when(() => apiDatasource.getAddress('01001-000')).thenThrow(
          AppClientException(httpClientError: AppClientError.notFound));

      when(() => cepLocalDatasource.create(addressEntity))
          .thenAnswer((_) async => 01);

      final sut =
          ApiAndLocalAddressRepository(apiDatasource, cepLocalDatasource);
      final result = await sut.getAddress('01001-000');

      expect(result.isLeft(), true);
      expect(result, isA<Left<AppClientException, AddressEntity>>());
    });
  });
}
