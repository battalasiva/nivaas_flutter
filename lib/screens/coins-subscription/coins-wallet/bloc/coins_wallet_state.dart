part of 'coins_wallet_bloc.dart';

sealed class CoinsWalletState extends Equatable {
  const CoinsWalletState();

  @override
  List<Object> get props => [];
}

class CoinsWalletInitial extends CoinsWalletState {}

class CoinsWalletLoading extends CoinsWalletState {}

class CoinsWalletLoaded extends CoinsWalletState {
  final List<Content> content;

  const CoinsWalletLoaded(this.content);

  @override
  List<Object> get props => [content];
}

class CoinsWalletError extends CoinsWalletState {
  final String message;

  const CoinsWalletError(this.message);

  @override
  List<Object> get props => [message];
}

class CoinsBalanceLoading extends CoinsWalletState {}

class CoinsBalanceLoaded extends CoinsWalletState {
  final double balance;

  const CoinsBalanceLoaded(this.balance);
}

class CoinsBalanceError extends CoinsWalletState {
  final String message;

  const CoinsBalanceError(this.message);
}
