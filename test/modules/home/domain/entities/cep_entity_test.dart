import 'package:busca_cep/modules/home/domain/entities/cep_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Address Entity | ', () {
    test('Should test hashCode', () async {
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

      expect(addressEntity.hashCode, addressEntity.hashCode);
    });
  });
}
