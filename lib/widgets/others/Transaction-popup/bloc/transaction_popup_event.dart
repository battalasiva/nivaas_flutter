part of 'transaction_popup_bloc.dart';

sealed class TransactionPopupEvent extends Equatable {
  const TransactionPopupEvent();

  @override
  List<Object> get props => [];
}
//ADD_DEBIT
class AddDebitMaintainanceEvent extends TransactionPopupEvent {
    final int apartmentId;
    final String amount;
    final String description;
    final String transactionDate;
    final String type;

    const AddDebitMaintainanceEvent({
      required this.apartmentId,
      required this.amount,
      required this.description,
      required this.transactionDate,
      required this.type,
    });
    @override
    List<Object> get props => [apartmentId, amount, description, transactionDate, type];
}

//ADD_CREDIT
final class AddCreditMaintainanceEvent extends TransactionPopupEvent {
  final Map<String, dynamic> payload;

  const AddCreditMaintainanceEvent({required this.payload});
}

//EDIT_DEBIT
class EditDebitMaintainanceRequested extends TransactionPopupEvent {
  final int itemId;
  final Map<String, dynamic> payload;

  const EditDebitMaintainanceRequested(
      {required this.itemId, required this.payload});

  @override
  List<Object> get props => [itemId, payload];
}

//EDIT_CREDIT
class EditCreditMaintainanceRequested extends TransactionPopupEvent {
  final int itemId;
  final Map<String, dynamic> payload;

  const EditCreditMaintainanceRequested(
      {required this.itemId, required this.payload});

  @override
  List<Object> get props => [itemId, payload];
}

//DELETE_DEBIT

class DeleteDebitHistoryRequested extends TransactionPopupEvent {
  final int apartmentId;
  final int itemId;

  const DeleteDebitHistoryRequested(
      {required this.apartmentId, required this.itemId});

  @override
  List<Object> get props => [apartmentId, itemId];
}
//DELETE_CREDIT
class DeleteCreditHistoryRequested extends TransactionPopupEvent {
  final int apartmentId;
  final int itemId;

  DeleteCreditHistoryRequested(
      {required this.apartmentId, required this.itemId});

  @override
  List<Object> get props => [apartmentId, itemId];
}