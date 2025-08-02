import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/expenseSplitter/expense_splitters_list_usecase.dart';

import '../../../data/models/expenseSplitter/expense_splitter_details_model.dart';
import '../../../data/models/expenseSplitter/expense_splitters_list_model.dart';

part 'expense_splitter_event.dart';
part 'expense_splitter_state.dart';

class ExpenseSplitterBloc extends Bloc<ExpenseSplitterEvent, ExpenseSplitterState> {
  final ExpenseSplittersListUsecase expenseSplittersListUsecase;
  ExpenseSplitterBloc(this.expenseSplittersListUsecase) : super(ExpenseSplitterInitial()) {
    on<FetchExpenseSplittersListEvent>((event, emit) async{
      emit(ExpenseSplitterListLoading());
      try {
        final response = await expenseSplittersListUsecase.call(event.apartmentId);
        emit(ExpenseSplitterListLoaded(details: response));
      } catch (e) {
        emit(ExpenseSplitterListFailure(message: e.toString()));
      }
    });

    on<EnableExpenseSplitterEvent>((event, emit) async{
      emit(EnableExpenseSplitterLoading());
      try {
        final response = await expenseSplittersListUsecase.executeEnable(event.splitterId, event.isEnabled);
        emit(EnableExpenseSplitterLoaded(details: response));
      } catch (e) {
        emit(ExpenseSplitterListFailure(message: e.toString()));
      }
    });
  }
}
