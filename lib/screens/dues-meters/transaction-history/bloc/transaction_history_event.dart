import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FilterTransactionHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTransactionHistoryEvent extends FilterTransactionHistoryEvent {
  final int apartmentId;
  final int page;
  final int size;
  final String transactionDate;

  FetchTransactionHistoryEvent({
    required this.apartmentId,
    required this.page,
    required this.size,
    required this.transactionDate,
  });

  @override
  List<Object> get props => [apartmentId, page, size, transactionDate];
}

class FetchPdfEvent extends FilterTransactionHistoryEvent {
  final int apartmentId;
  final int year;
  final int month;

  FetchPdfEvent({
    required this.apartmentId,
    required this.year,
    required this.month,
  });

  @override
  List<Object> get props => [apartmentId, year, month];
}
// class FetchPdfEvent extends FilterTransactionHistoryEvent {
//   final int apartmentId;
//   final int year;
//   final int month;
//   final BuildContext context;

//   FetchPdfEvent({
//     required this.apartmentId,
//     required this.year,
//     required this.month,
//     required this.context,
//   });
// }

class AlertDialogEvent {
  final String title;
  final String message;

  AlertDialogEvent({required this.title, required this.message});
}
