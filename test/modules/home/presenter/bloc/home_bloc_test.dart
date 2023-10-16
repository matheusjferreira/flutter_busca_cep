import 'package:bloc_test/bloc_test.dart';
import 'package:busca_cep/modules/home/domain/entities/cep_entity.dart';
import 'package:busca_cep/modules/home/infra/repositories/api_and_local_address_repository.dart';
import 'package:busca_cep/modules/home/presenter/bloc/home_bloc.dart';
import 'package:busca_cep/shared/core/client/validations/app_client_error.dart';
import 'package:busca_cep/shared/core/client/validations/app_client_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockApiAndLocalAddressRepository extends Mock
    implements ApiAndLocalAddressRepository {}

void main() {
  group('HomeBloc | ', () {
    late HomeBloc homeBloc;
    late MockApiAndLocalAddressRepository mockRepository;
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
      mockRepository = MockApiAndLocalAddressRepository();
      homeBloc = HomeBloc(mockRepository);
    });

    blocTest<HomeBloc, HomeState>(
      'Emits HomeLoaded when getAddress is successful.',
      build: () {
        when(() => mockRepository.getAddress('01001-000'))
            .thenAnswer((_) async => Right(addressEntity));

        return homeBloc;
      },
      act: (bloc) => bloc.add(GetAddressEvent(cep: '01001-000')),
      expect: () => [isA<HomeLodiang>(), isA<HomeLoaded>()],
    );

    blocTest<HomeBloc, HomeState>(
      'Emits HomeError, HomeLoaded when getAddress is failure.',
      build: () {
        when(() => mockRepository.getAddress('01001-000')).thenAnswer(
            (_) async => Left(
                AppClientException(httpClientError: AppClientError.notFound)));

        return homeBloc;
      },
      act: (bloc) => bloc.add(GetAddressEvent(cep: '01001-000')),
      expect: () => [isA<HomeLodiang>(), isA<HomeError>(), isA<HomeLoaded>()],
    );
  });
}
