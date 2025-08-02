part of 'apartment_onboarding_bloc.dart';

sealed class ApartmentOnboardingState extends Equatable {
  const ApartmentOnboardingState();
  
  @override
  List<Object> get props => [];
}

final class ApartmentOnboardingInitial extends ApartmentOnboardingState {}
final class ApartmentOnboardingLoading extends ApartmentOnboardingState {}
final class ApartmentOnboardingLoaded extends ApartmentOnboardingState {
  final String message;

  ApartmentOnboardingLoaded({required this.message});
}
final class ApartmentOnboardingError extends ApartmentOnboardingState {
  final String error;

  ApartmentOnboardingError({required this.error});
}
