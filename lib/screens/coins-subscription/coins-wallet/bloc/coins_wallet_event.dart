part of 'coins_wallet_bloc.dart';

sealed class CoinsWalletEvent extends Equatable {
  const CoinsWalletEvent();

  @override
  List<Object> get props => [];
}

class LoadCoinsWalletEvent extends CoinsWalletEvent {
  final int apartmentId;
  final int pageNo;
  final int pageSize;

  const LoadCoinsWalletEvent({
    required this.apartmentId,
    required this.pageNo,
    required this.pageSize,
  });

  @override
  List<Object> get props => [apartmentId, pageNo, pageSize];
}

class CoinsBalenceEvent extends CoinsWalletEvent {
  final int apartmentId;

  const CoinsBalenceEvent({required this.apartmentId});

  @override
  List<Object> get props => [apartmentId];
}
