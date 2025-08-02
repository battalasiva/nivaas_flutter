import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/expenseSplitter/edit_splitter_details_usecase.dart';
import 'package:nivaas/domain/usecases/expenseSplitter/expense_splitter_details_usecase.dart';

import '../../../../data/models/expenseSplitter/expense_splitter_details_model.dart';

part 'expense_splitter_details_event.dart';
part 'expense_splitter_details_state.dart';

class ExpenseSplitterDetailsBloc extends Bloc<ExpenseSplitterDetailsEvent, ExpenseSplitterDetailsState> {
  // final ExpenseSplitterDetailsUsecase expenseSplitterDetailsUsecase;
  final EditSplitterDetailsUseCase editSplitterDetailsUseCase;
  ExpenseSplitterDetailsBloc(this.editSplitterDetailsUseCase) : super(ExpenseSplitterDetailsInitial()) {
    // on<GetExpenseSplitterDetailsEvent>((event, emit) async{
    //   emit(ExpenseSplitterDetailsLoading());
    //   try {
    //     final response = await expenseSplitterDetailsUsecase.getDetails(event.splitterId);
    //     emit(ExpenseSplitterDetailsLoaded(details: response));
    //   } catch (e) {
    //     emit(ExpenseSplitterDetailsFailure(message: e.toString()));
    //   }
    // });
    on<SubmitEditSplitterDetails>((event, emit) async {
      emit(EditSplitterDetailsLoading());
      try {
        await editSplitterDetailsUseCase.call(event.id, event.payload);
        emit(EditSplitterDetailsSuccess());
      } catch (e) {
        emit(EditSplitterDetailsFailure(e.toString()));
      }
    });
  }
}
