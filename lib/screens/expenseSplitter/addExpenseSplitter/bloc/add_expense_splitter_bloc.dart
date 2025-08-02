import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/expenseSplitter/add_expense_splitter_usecase.dart';

import '../../../../data/models/expenseSplitter/add_expense_splitter_model.dart';

part 'add_expense_splitter_event.dart';
part 'add_expense_splitter_state.dart';

class AddExpenseSplitterBloc extends Bloc<AddExpenseSplitterEvent, AddExpenseSplitterState> {
  final AddExpenseSplitterUsecase addExpenseSplitterUsecase;
  AddExpenseSplitterBloc(this.addExpenseSplitterUsecase) : super(AddExpenseSplitterInitial()) {
    on<CreateExpenseSplitterEvent>((event, emit) async{
      emit(AddExpenseSplitterLoading());
      try {
        final response = await addExpenseSplitterUsecase.call(event.splitDetails
        );
        emit(AddExpenseSplitterSuccess());
      } catch (e) {
        emit(AddExpenseSplitterFailure(message: e.toString()));
      }
    });
  }
}
