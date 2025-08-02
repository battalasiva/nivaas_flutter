part of 'add_expense_splitter_bloc.dart';

sealed class AddExpenseSplitterState extends Equatable {
  const AddExpenseSplitterState();
  
  @override
  List<Object> get props => [];
}

final class AddExpenseSplitterInitial extends AddExpenseSplitterState {}
class AddExpenseSplitterLoading extends AddExpenseSplitterState {}
class AddExpenseSplitterSuccess extends AddExpenseSplitterState {}
class AddExpenseSplitterFailure extends AddExpenseSplitterState {
  final String message;

  AddExpenseSplitterFailure({required this.message});
}
