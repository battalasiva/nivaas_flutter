part of 'add_expense_splitter_bloc.dart';

sealed class AddExpenseSplitterEvent extends Equatable {
  const AddExpenseSplitterEvent();

  @override
  List<Object> get props => [];
}

class CreateExpenseSplitterEvent extends AddExpenseSplitterEvent {
  // final int apartmentId;
  // final  double amount;
  // final  String splitType, splitterName;
  final  AddExpenseSplitterModel splitDetails;

  const CreateExpenseSplitterEvent({required this.splitDetails});
}