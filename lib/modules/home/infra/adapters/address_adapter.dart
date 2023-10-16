import '../../../../shared/core/errors/app_error.dart';
import '../../domain/entities/cep_entity.dart';

class AddressAdapter {
  static AddressEntity fromJson(Map<String, dynamic> json) {
    try {
      return AddressEntity(
        cep: json['cep'] ?? '',
        logradouro: json['logradouro'] ?? '',
        complemento: json['complemento'] ?? '',
        bairro: json['bairro'] ?? '',
        localidade: json['localidade'] ?? '',
        uf: json['uf'] ?? '',
        ibge: json['ibge'] ?? '',
        gia: json['gia'] ?? '',
        ddd: json['ddd'] ?? '',
        siafi: json['siafi'] ?? '',
      );
    } catch (error, stackTrace) {
      throw AdapterError(
        message: error.toString(),
        code: 'home_cep_error',
        stackTrace: stackTrace,
      );
    }
  }

  static Map<String, dynamic> toJson(AddressEntity? cepEntity) {
    try {
      return {
        'cep': cepEntity?.cep ?? '',
        'logradouro': cepEntity?.logradouro ?? '',
        'complemento': cepEntity?.complemento ?? '',
        'bairro': cepEntity?.bairro ?? '',
        'localidade': cepEntity?.localidade ?? '',
        'uf': cepEntity?.uf ?? '',
        'ibge': cepEntity?.ibge ?? '',
        'gia': cepEntity?.gia ?? '',
        'ddd': cepEntity?.ddd ?? '',
        'siafi': cepEntity?.siafi ?? '',
      };
    } catch (error, stackTrace) {
      throw AdapterError(
        message: error.toString(),
        code: 'home_cep_error',
        stackTrace: stackTrace,
      );
    }
  }
}
