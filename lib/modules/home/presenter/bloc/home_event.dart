part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetAddressEvent extends HomeEvent {
  final String cep;

  GetAddressEvent({required this.cep});
}
