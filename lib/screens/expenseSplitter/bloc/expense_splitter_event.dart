part of 'expense_splitter_bloc.dart';

sealed class ExpenseSplitterEvent extends Equatable {
  const ExpenseSplitterEvent();

  @override
  List<Object> get props => [];
}

class FetchExpenseSplittersListEvent extends ExpenseSplitterEvent {
  final int apartmentId;

  const FetchExpenseSplittersListEvent({required this.apartmentId});
}
class EnableExpenseSplitterEvent extends ExpenseSplitterEvent {
  final int splitterId;
  final bool isEnabled;

  const EnableExpenseSplitterEvent({required this.splitterId, required this.isEnabled});
}