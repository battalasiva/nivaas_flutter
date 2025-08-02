part of 'expense_splitter_bloc.dart';

sealed class ExpenseSplitterState extends Equatable {
  const ExpenseSplitterState();
  
  @override
  List<Object> get props => [];
}

final class ExpenseSplitterInitial extends ExpenseSplitterState {}
class ExpenseSplitterListLoading extends ExpenseSplitterState {}
class ExpenseSplitterListLoaded extends ExpenseSplitterState {
  final List<ExpenseSplittersListModel> details;

  const ExpenseSplitterListLoaded({required this.details});
}
class ExpenseSplitterListFailure extends ExpenseSplitterState {
  final String message;

  const ExpenseSplitterListFailure({required this.message});
}
class EnableExpenseSplitterLoading extends ExpenseSplitterState {}
class EnableExpenseSplitterLoaded extends ExpenseSplitterState {
  final ExpenseSplittersListModel details;

  EnableExpenseSplitterLoaded({required this.details});
}
