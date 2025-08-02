part of 'apartment_onboarding_bloc.dart';

sealed class ApartmentOnboardingEvent extends Equatable {
  const ApartmentOnboardingEvent();

  @override
  List<Object> get props => [];
}

class PostApartmentDetailsEvent extends ApartmentOnboardingEvent {
  final ApartmentOnboard apartment;

  PostApartmentDetailsEvent({required this.apartment});
}