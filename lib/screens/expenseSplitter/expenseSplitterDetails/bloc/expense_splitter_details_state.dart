part of 'expense_splitter_details_bloc.dart';

sealed class ExpenseSplitterDetailsState extends Equatable {
  const ExpenseSplitterDetailsState();
  
  @override
  List<Object> get props => [];
}

final class ExpenseSplitterDetailsInitial extends ExpenseSplitterDetailsState {}
class ExpenseSplitterDetailsLoading extends ExpenseSplitterDetailsState {}
class ExpenseSplitterDetailsLoaded extends ExpenseSplitterDetailsState {
  final ExpenseSplitterDetailsModel details;

  const ExpenseSplitterDetailsLoaded({required this.details});
}
class ExpenseSplitterDetailsFailure extends ExpenseSplitterDetailsState {
  final String message;

  const ExpenseSplitterDetailsFailure({required this.message});
}

class EditSplitterDetailsInitial extends ExpenseSplitterDetailsState {}

class EditSplitterDetailsLoading extends ExpenseSplitterDetailsState {}

class EditSplitterDetailsSuccess extends ExpenseSplitterDetailsState {}

class EditSplitterDetailsFailure extends ExpenseSplitterDetailsState {
  final String message;

  EditSplitterDetailsFailure(this.message);
}