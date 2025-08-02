part of 'purchase_plan_bloc.dart';

abstract class PurchasePlanEvent extends Equatable {
  const PurchasePlanEvent();

  @override
  List<Object> get props => [];
}

class PurchasePlanRequestedEvent extends PurchasePlanEvent {
  final String apartmentId;
  final int months;

  const PurchasePlanRequestedEvent({
    required this.apartmentId,
    required this.months,
  });

  @override
  List<Object> get props => [apartmentId, months];
}

class PurchasePlanPaymentRequestedEvent extends PurchasePlanEvent {
  final String apartmentId;
  final int months;
  final String paymentId;

  const PurchasePlanPaymentRequestedEvent({
    required this.apartmentId,
    required this.months,
    required this.paymentId,
  });

  @override
  List<Object> get props => [apartmentId, months];
}

class CreatePaymentOrderButtonPressed extends PurchasePlanEvent {
  final int apartmentId;
  final String months;
  final String coinsToUse;

  const CreatePaymentOrderButtonPressed({
    required this.apartmentId,
    required this.months,
    required this.coinsToUse,
  });

  @override
  List<Object> get props => [apartmentId, months, coinsToUse];
}

class VerifyPaymentOrderButtonPressed extends PurchasePlanEvent {
  final String paymentId;
  final String orderId;
  final String signature;

  const VerifyPaymentOrderButtonPressed({
    required this.paymentId,
    required this.orderId,
    required this.signature,
  });

  @override
  List<Object> get props => [paymentId, orderId, signature];
}