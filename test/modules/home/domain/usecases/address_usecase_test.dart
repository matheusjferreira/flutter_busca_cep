import 'package:busca_cep/modules/home/domain/entities/cep_entity.dart';
import 'package:busca_cep/modules/home/domain/repositories/address_repository.dart';
import 'package:busca_cep/modules/home/domain/usecases/address_usecase.dart';
import 'package:busca_cep/shared/core/client/validations/app_client_error.dart';
import 'package:busca_cep/shared/core/client/validations/app_client_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class AddressRepositoryMock extends Mock implements AddressRepository {}

void main() {
  late AddressRepository repository;

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

  setUp(() {
    repository = AddressRepositoryMock();
  });

  group('AddressUsecase | ', () {
    test('Should return a address from CEP.', () async {
      /// Arrange.
      when(() => repository.getAddress('01001-000')).thenAnswer(
        (_) async => Right(addressEntity),
      );

      /// SUT: System Under Test.
      final sut = Address(repository);

      /// ACT.
      final result = await sut('01001-000');

      /// Assert.
      expect(result.match(identity, identity), isA<AddressEntity>());
    });

    test('Should return a AppClientException.', () async {
      /// Arrange.
      when(() => repository.getAddress('01001-000')).thenAnswer((_) async =>
          Left(AppClientException(httpClientError: AppClientError.notFound)));

      /// SUT: System Under Test.
      final sut = Address(repository);

      /// ACT.
      final result = await sut('01001-000');
      final failure = await result.match(identityFuture, identityFuture);

      /// Assert.
      expect(
        result.match(identity, identity),
        isA<AppClientException>(),
      );
      expect(
        (failure as AppClientException).httpClientError,
        equals(AppClientError.notFound),
      );
    });
  });
}
