import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/Maintainance/Transaction_history_modal.dart';
import 'package:nivaas/data/models/Maintainance/current_balance_Modal.dart';
import 'package:nivaas/domain/repositories/maintainance/current_balance_repository.dart';
import 'package:nivaas/domain/repositories/maintainance/transaction_history_repositoty.dart';
import 'package:nivaas/domain/usecases/maintainance/refresh_balance_usecase.dart';

part 'maintainance_event.dart';
part 'maintainance_state.dart';

class MaintainanceBloc extends Bloc<MaintainanceEvent, MaintainanceState> {
  final CurrentBalanceRepository repository;
  final TransactionRepository transactionRepository;
  final RefreshBalanceUseCase refreshBalanceUsecase;

  MaintainanceBloc(
      {required this.repository,
      required this.transactionRepository,
      required this.refreshBalanceUsecase})
      : super(MaintainanceInitial()) {
    on<GetCurrentBalanceEvent>((event, emit) async {
      emit(MaintainanceLoading());
      try {
        final currentBalance =
            await repository.getCurrentBalance(event.apartmentId);
        emit(MaintainanceLoaded(currentBalance));
      } catch (error) {
        emit(MaintainanceError(error.toString()));
      }
    });
    on<FetchTransactions>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions = await transactionRepository.getTransactions(
          apartmentId: event.apartmentId,
          page: event.page,
          size: event.size,
          appliedFilters: event.appliedFilters,
        );
        emit(TransactionLoaded(transactions: transactions));
      } catch (e) {
        emit(TransactionError(message: e.toString()));
      }
    });
     on<RefreshBalanceRequested>((event, emit) async {
      emit(RefreshBalanceLoading());
      try {
        final message = await refreshBalanceUsecase.execute(event.apartmentId);
        emit(RefreshBalanceSuccess(message));
      } catch (e) {
        emit(RefreshBalanceFailure(e.toString()));
      }
    });
    
  }
}
