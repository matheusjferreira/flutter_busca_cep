import 'package:busca_cep/modules/home/domain/entities/cep_entity.dart';
import 'package:busca_cep/modules/home/infra/datasources/api_address_datasource.dart';
import 'package:busca_cep/shared/core/client/interfaces/app_client_interface.dart';
import 'package:busca_cep/shared/core/client/validations/app_client_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AppClientInterfaceMock extends Mock implements AppClientInterface {}

void main() {
  late AppClientInterfaceMock appClient;
  late ApiAddress datasource;
  final data = {
    'cep': '01001-000',
    'logradouro': 'Praça da Sé',
    'complemento': 'lado ímpar',
    'bairro': 'Sé',
    'localidade': 'São Paulo',
    'uf': 'SP',
    'ibge': '3550308',
    'gia': '1004',
    'ddd': '11',
    'siafi': '7107',
  };

  setUpAll(() {
    appClient = AppClientInterfaceMock();
    datasource = ApiAddress(appClient);
  });

  group('ApiAddressDatasource |', () {
    test('Should be able to get address successful.', () async {
      when(
        () => appClient.get(any()),
      ).thenAnswer((_) async => AppClientResponse(data: data, statusCode: 200));

      final sut = await datasource.getAddress('01001-000');

      expect(sut, isInstanceOf<AddressEntity>());
    });

    test(
      'Should not be able to get address when request failure.',
      () async {
        when(
          () => appClient.get(any()),
        ).thenThrow(Exception());

        expect(
          () => datasource.getAddress('01001-000'),
          throwsA(isInstanceOf<Exception>()),
        );
      },
    );
  });
}
