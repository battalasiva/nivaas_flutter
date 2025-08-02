part of 'subscription_bloc.dart';

sealed class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class FetchSubscriptionPlansEvent extends SubscriptionEvent {
  final int customerId;

  const FetchSubscriptionPlansEvent(this.customerId);

  @override
  List<Object> get props => [customerId];
}
