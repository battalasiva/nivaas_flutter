import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/Maintainance/Transaction_history_modal.dart';

abstract class FilterTransactionHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterTransactionHistoryInitial extends FilterTransactionHistoryState {}

class FilterTransactionHistoryLoading extends FilterTransactionHistoryState {}

class FilterTransactionHistoryLoaded extends FilterTransactionHistoryState {
  final TransactionHistoryModal transactionHistory;

  FilterTransactionHistoryLoaded({required this.transactionHistory});

  @override
  List<Object?> get props => [transactionHistory];
}

class FilterTransactionHistoryError extends FilterTransactionHistoryState {
  final String message;

  FilterTransactionHistoryError({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetPdfInitial extends FilterTransactionHistoryState {}

class FetchPdfLoading extends FilterTransactionHistoryState {}

class FetchPdfSuccess extends FilterTransactionHistoryState {
  final String filePath;

  FetchPdfSuccess({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

class FetchPdfError extends FilterTransactionHistoryState {
  final String message;

  FetchPdfError({required this.message});

  @override
  List<Object?> get props => [message];
}

// class FetchPdfLoading extends FilterTransactionHistoryState {}

// class FetchPdfSuccess extends FilterTransactionHistoryState {
//   final String filePath;

//   FetchPdfSuccess({required this.filePath});
// }

// class FetchPdfError extends FilterTransactionHistoryState {
//   final String message;

//   FetchPdfError({required this.message});
// }
