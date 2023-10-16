// ignore_for_file: unused_import

import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/core/client/interfaces/app_client_interface.dart';
import '../../shared/core/client/resources/app_client_dio.dart';
import '../../shared/core/client/resources/app_client_http.dart';
import 'infra/datasources/local_address_datasouce.dart';
import 'infra/datasources/api_address_datasource.dart';
import 'infra/repositories/api_and_local_address_repository.dart';
import 'presenter/bloc/home_bloc.dart';
import 'presenter/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.add(ApiAndLocalAddressRepository.new);
    i.add(ApiAddress.new);
    i.add(LocalAddress.new);
    i.add(HomeBloc.new);
    i.add<AppClientInterface>(AppClientDio.new);
    // i.add<AppClientInterface>(AppClientHttp.new);
    i.add<ApiAddressDatasource>(ApiAddress.new);
    i.add<LocalAddressDatasource>(LocalAddress.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
