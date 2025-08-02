part of 'onboard_flats_bloc.dart';

sealed class OnboardFlatsEvent extends Equatable {
  const OnboardFlatsEvent();

  @override
  List<Object> get props => [];
}

class OnboardFlatWithDetailsEvent extends OnboardFlatsEvent{
  final OnboardingFlatWithdetailsModel flatDetails;

  const OnboardFlatWithDetailsEvent({required this.flatDetails});
}

class OnboardFlatWithoutDetailsEvent extends OnboardFlatsEvent{
  final OnboardingFlatWithoutdetailsModel flatDetails;

  const OnboardFlatWithoutDetailsEvent({required this.flatDetails});
}