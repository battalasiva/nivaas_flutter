import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/repositories/maintainance/add_credit_history_repository.dart';
import 'package:nivaas/domain/usecases/maintainance/add_debit_history_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/delete_credit_history_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/delete_debit_history_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/edit_credit_maintainance_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/edit_debit_maintainance_usecase.dart';

part 'transaction_popup_event.dart';
part 'transaction_popup_state.dart';

class TransactionPopupBloc extends Bloc<TransactionPopupEvent, TransactionPopupState> {
  final PostDebitHistoryUseCase postDebitHistoryUseCase;
  final AddCreditMaintainanceRepository addCreditMaintainanceRepository;
  final EditDebitMaintainanceUseCase editDebitMaintainanceUseCase;
  final EditCreditMaintainanceUseCase editCreditMaintainanceUseCase;
  final DeleteDebitHistoryUseCase deleteDebitHistoryUseCase;
  final DeleteCreditHistoryUseCase deleteCreditHistoryUseCase;
  TransactionPopupBloc(this.postDebitHistoryUseCase,this.addCreditMaintainanceRepository,this.editDebitMaintainanceUseCase,this.editCreditMaintainanceUseCase,this.deleteDebitHistoryUseCase,this.deleteCreditHistoryUseCase) : super(TransactionPopupInitial()) {
    on<AddDebitMaintainanceEvent>((event, emit) async {
      emit(AddDebitMaintainanceLoading());
      try {
        final message = await postDebitHistoryUseCase(
          event.apartmentId,
          event.amount,
          event.description,
          event.transactionDate,
          event.type,
        );
        emit(AddDebitMaintainanceLoaded(message));
      } catch (error) {
        emit(AddDebitMaintainanceError(error.toString()));
      }
    });
    on<AddCreditMaintainanceEvent>((event, emit) async {
      emit(AddCreditMaintainanceLoading());
      try {
        final addCreditMaintainance = await addCreditMaintainanceRepository
            .postAddCreditMaintainance(event.payload);
        emit(AddCreditMaintainanceLoaded(addCreditMaintainance));
      } catch (error) {
        emit(AddCreditMaintainanceError(error.toString()));
      }
    });
    on<EditDebitMaintainanceRequested>((event, emit) async {
      emit(EditDebitMaintainanceLoading());
      try {
        await editDebitMaintainanceUseCase.execute(
          event.itemId,
          event.payload,
        );
        emit(EditDebitMaintainanceSuccess());
      } catch (error) {
        emit(EditDebitMaintainanceFailures(error.toString()));
      }
    });
    on<EditCreditMaintainanceRequested>((event, emit) async {
      emit(EditCreditMaintainanceLoading());
      try {
        await editCreditMaintainanceUseCase.execute(
          event.itemId,
          event.payload,
        );
        emit(EditCreditMaintainanceSuccess());
      } catch (error) {
        emit(EditCreditMaintainanceFailure(error.toString()));
      }
    });
    on<DeleteDebitHistoryRequested>((event, emit) async {
      emit(DeleteDebitHistoryLoading());
      try {
        await deleteDebitHistoryUseCase.execute(
          event.apartmentId,
          event.itemId,
        );
        emit(DeleteDebitHistorySuccess());
      } catch (e) {
        emit(DeleteDebitHistoryFailure(error: e.toString()));
      }
    });
    on<DeleteCreditHistoryRequested>((event, emit) async {
      emit(DeleteCreditHistoryLoading());
      try {
        await deleteCreditHistoryUseCase.execute(
          event.apartmentId,
          event.itemId,
        );
        emit(DeleteCreditHistorySuccess());
      } catch (e) {
        emit(DeleteCreditHistoryFailure(error: e.toString()));
      }
    });
  }
}
