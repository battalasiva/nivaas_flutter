part of 'purchase_plan_bloc.dart';

abstract class PurchasePlanState extends Equatable {
  const PurchasePlanState();

  @override
  List<Object> get props => [];
}

class PurchasePlanInitial extends PurchasePlanState {}

class PurchasePlanLoading extends PurchasePlanState {}

class PurchasePlanSuccess extends PurchasePlanState {
  final String result;
  final bool isError;

  const PurchasePlanSuccess(this.result, {this.isError = false});

  @override
  List<Object> get props => [result, isError];
}


class PurchasePlanFailure extends PurchasePlanState {
  final String error;

  const PurchasePlanFailure(this.error);

  @override
  List<Object> get props => [error];
}


class PurchasePlanPaymentInitial extends PurchasePlanState {}

class PurchasePlanPaymentLoading extends PurchasePlanState {}

class PurchasePlanPaymentSuccess extends PurchasePlanState {
  final String result;
  final bool isError;

  const PurchasePlanPaymentSuccess(this.result, {this.isError = false});

  @override
  List<Object> get props => [result, isError];
}


class PurchasePlanPaymentFailure extends PurchasePlanState {
  final String error;

  const PurchasePlanPaymentFailure(this.error);

  @override
  List<Object> get props => [error];
}

//create-order
class CreatePaymentOrderInitial extends PurchasePlanState {}

class CreatePaymentOrderLoading extends PurchasePlanState {}

class CreatePaymentOrderSuccess extends PurchasePlanState {
  final String message;
  final dynamic data;

  const CreatePaymentOrderSuccess(this.message, this.data);

  @override
  List<Object> get props => [message, data];
}

class CreatePaymentOrderFailure extends PurchasePlanState {
  final String error;

  const CreatePaymentOrderFailure(this.error);

  @override
  List<Object> get props => [error];
}

//verify-order
class VerifyPaymentOrderInitial extends PurchasePlanState {}

class VerifyPaymentOrderLoading extends PurchasePlanState {}

class VerifyPaymentOrderSuccess extends PurchasePlanState {
  final String message;
  final dynamic data;

  const VerifyPaymentOrderSuccess(this.message, this.data);

  @override
  List<Object> get props => [message, data];
}

class VerifyPaymentOrderFailure extends PurchasePlanState {
  final String error;

  const VerifyPaymentOrderFailure(this.error);

  @override
  List<Object> get props => [error];
}
