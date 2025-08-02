part of 'onboard_flats_bloc.dart';

sealed class OnboardFlatsState extends Equatable {
  const OnboardFlatsState();
  
  @override
  List<Object> get props => [];
}

final class OnboardFlatsInitial extends OnboardFlatsState {}
final class OnboardFlatsLoading extends OnboardFlatsState {}
final class OnboardFlatsLoaded extends OnboardFlatsState {}
final class OnboardFlatsError extends OnboardFlatsState {
  final String message;

  const OnboardFlatsError({required this.message});

}
