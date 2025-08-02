part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();
  
  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}
class SplashLoading extends SplashState {}

class SplashSuccess extends SplashState {
  final CurrentCustomerModel user;

  const SplashSuccess({required this.user});
}

class SplashFailureTokenNotFound extends SplashState {}
class SplashApartmentNotFound extends SplashState {
  final CurrentCustomerModel user;

  const SplashApartmentNotFound({required this.user});
}
class SplashApartmentAdmin extends SplashState {
  final CurrentCustomerModel user;

  const SplashApartmentAdmin({required this.user});
}

class SplashFailure extends SplashState {
  final String message;

  const SplashFailure({required this.message});
}
