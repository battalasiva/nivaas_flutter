part of 'expense_splitter_details_bloc.dart';

sealed class ExpenseSplitterDetailsEvent extends Equatable {
  const ExpenseSplitterDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetExpenseSplitterDetailsEvent extends ExpenseSplitterDetailsEvent{
  final int splitterId;

  GetExpenseSplitterDetailsEvent({required this.splitterId});

}

class SubmitEditSplitterDetails extends ExpenseSplitterDetailsEvent {
  final int id;
  final Map<String, dynamic> payload;

  SubmitEditSplitterDetails(this.id, this.payload);
}