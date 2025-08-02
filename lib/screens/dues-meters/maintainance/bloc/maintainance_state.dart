part of 'maintainance_bloc.dart';

sealed class MaintainanceState extends Equatable {
  const MaintainanceState();

  @override
  List<Object> get props => [];
}

final class MaintainanceInitial extends MaintainanceState {}

final class MaintainanceLoading extends MaintainanceState {}

final class MaintainanceLoaded extends MaintainanceState {
  final CurrentBalanceModal currentBalance;

  const MaintainanceLoaded(this.currentBalance);

  @override
  List<Object> get props => [currentBalance];
}

final class MaintainanceError extends MaintainanceState {
  final String message;

  const MaintainanceError(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionInitial extends MaintainanceState {}

class TransactionLoading extends MaintainanceState {}

class TransactionLoaded extends MaintainanceState {
  final List<Content> transactions;

  const TransactionLoaded({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class TransactionError extends MaintainanceState {
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object> get props => [message];
}
class RefreshBalanceInitial extends MaintainanceState {}

class RefreshBalanceLoading extends MaintainanceState {}

class RefreshBalanceSuccess extends MaintainanceState {
  final String message;
  const RefreshBalanceSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RefreshBalanceFailure extends MaintainanceState {
  final String error;
  const RefreshBalanceFailure(this.error);

  @override
  List<Object> get props => [error];
}