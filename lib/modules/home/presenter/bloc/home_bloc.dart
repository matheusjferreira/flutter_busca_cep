import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/cep_entity.dart';
import '../../infra/repositories/api_and_local_address_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiAndLocalAddressRepository _cepRepository;

  HomeBloc(this._cepRepository) : super(HomeInitial()) {
    on<GetAddressEvent>(getAddress);
  }

  Future<void> getAddress(
    GetAddressEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLodiang());

    AddressEntity? cepEntity;

    var result = await _cepRepository.getAddress(event.cep);

    result.fold(
      (l) => emit(HomeError(message: l.getMessage())),
      (r) => cepEntity = r,
    );

    emit(HomeLoaded(cepEntity: cepEntity));
  }
}
