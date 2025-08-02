part of 'transaction_popup_bloc.dart';

sealed class TransactionPopupState extends Equatable {
  const TransactionPopupState();
  
  @override
  List<Object> get props => [];
}

class TransactionPopupInitial extends TransactionPopupState {}

//ADD_DEBIT
final class AddDebitMaintainanceInitial extends TransactionPopupState {}

final class AddDebitMaintainanceLoading extends TransactionPopupState {}

final class AddDebitMaintainanceLoaded extends TransactionPopupState {
  final String message;

  const AddDebitMaintainanceLoaded(this.message);

  @override
  List<Object> get props => [message];
}

final class AddDebitMaintainanceError extends TransactionPopupState {
  final String error;

  const AddDebitMaintainanceError(this.error);
}
//ADDD_CREDIT
final class AddCreditMaintainanceInitial extends TransactionPopupState {}

final class AddCreditMaintainanceLoading extends TransactionPopupState {}

final class AddCreditMaintainanceLoaded extends TransactionPopupState {
  final String message;

  const AddCreditMaintainanceLoaded(this.message);
}

final class AddCreditMaintainanceError extends TransactionPopupState {
  final String error;

  const AddCreditMaintainanceError(this.error);
}

//EDIT_DEBIT
class EditDebitMaintainanceLoading extends TransactionPopupState {}

class EditDebitMaintainanceSuccess extends TransactionPopupState {}

class EditDebitMaintainanceFailures extends TransactionPopupState {
  final String error;

  const EditDebitMaintainanceFailures(this.error);

  @override
  List<Object> get props => [error];
}
//EDIT_CREDIT
class EditCreditMaintainanceInitial extends TransactionPopupState {}

class EditCreditMaintainanceLoading extends TransactionPopupState {}

class EditCreditMaintainanceSuccess extends TransactionPopupState {}

class EditCreditMaintainanceFailure extends TransactionPopupState {
  final String error;

  const EditCreditMaintainanceFailure(this.error);

  @override
  List<Object> get props => [error];
}
//DELETE_DEBIT

class DeleteDebitHistoryLoading extends TransactionPopupState {}

class DeleteDebitHistorySuccess extends TransactionPopupState {}

class DeleteDebitHistoryFailure extends TransactionPopupState {
  final String error;

  const DeleteDebitHistoryFailure({required this.error});

  @override
  List<Object> get props => [error];
}

//DELETE_CREDIT
class DeleteCreditHistoryLoading extends TransactionPopupState {}

class DeleteCreditHistorySuccess extends TransactionPopupState {}

class DeleteCreditHistoryFailure extends TransactionPopupState {
  final String error;

  const DeleteCreditHistoryFailure({required this.error});

  @override
  List<Object> get props => [error];
}