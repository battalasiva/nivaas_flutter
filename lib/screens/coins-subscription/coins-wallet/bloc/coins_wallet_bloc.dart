import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/coins-subscription/coinsBalance_model.dart';
import 'package:nivaas/data/models/coins-subscription/walletTransaction_model.dart';
import 'package:nivaas/domain/repositories/coins-subscription/CoinsBalance_Repository.dart';
import 'package:nivaas/domain/repositories/coins-subscription/CoinsWallet_Repository.dart';

part 'coins_wallet_event.dart';
part 'coins_wallet_state.dart';

class CoinsWalletBloc extends Bloc<CoinsWalletEvent, CoinsWalletState> {
  final CoinsWalletRepository repository;
  final CoinsBalanceRepository balanceRepository;

  CoinsWalletBloc({required this.repository, required this.balanceRepository})
      : super(CoinsWalletInitial()) {
    on<LoadCoinsWalletEvent>((event, emit) async {
      emit(CoinsWalletLoading());
      try {
        final data = await repository.fetchWalletTransactions(
          apartmentId: event.apartmentId,
          pageNo: event.pageNo,
          pageSize: event.pageSize,
        );
        emit(CoinsWalletLoaded(data));
      } catch (error) {
        emit(CoinsWalletError(error.toString()));
      }
    });

    on<CoinsBalenceEvent>((event, emit) async {
      emit(CoinsWalletLoading());
      try {
        final balance = await balanceRepository.getCoinsBalance(
          apartmentId: event.apartmentId,
        );
        emit(CoinsBalanceLoaded(balance));
      } catch (error) {
        emit(CoinsBalanceError(error.toString()));
      }
    });
  }
}
