part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLodiang extends HomeState {}

final class HomeLoaded extends HomeState {
  final AddressEntity? cepEntity;

  HomeLoaded({required this.cepEntity});
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
