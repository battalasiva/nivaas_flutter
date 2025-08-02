part of 'subscription_bloc.dart';

sealed class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object> get props => [];
}

final class SubscriptionInitial extends SubscriptionState {}

final class SubscriptionLoadingState extends SubscriptionState {}

final class SubscriptionLoadedState extends SubscriptionState {
  final List<Map<String, dynamic>> plans;

  const SubscriptionLoadedState(this.plans);

  @override
  List<Object> get props => [plans];
}

final class SubscriptionErrorState extends SubscriptionState {
  final String message;

  const SubscriptionErrorState(this.message);

  @override
  List<Object> get props => [message];
}
