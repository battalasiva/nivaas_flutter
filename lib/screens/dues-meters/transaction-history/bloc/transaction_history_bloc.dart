import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/domain/usecases/maintainance/filter_transaction_history_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/get_pdf_usecase.dart';
import 'package:nivaas/screens/dues-meters/transaction-history/bloc/transaction_history_event.dart';
import 'package:nivaas/screens/dues-meters/transaction-history/bloc/transaction_history_state.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';

class AlertDialogEvent {
  final String title;
  final String message;

  AlertDialogEvent({required this.title, required this.message});
}

class FilterTransactionHistoryBloc
    extends Bloc<FilterTransactionHistoryEvent, FilterTransactionHistoryState> {
  final FilterTransactionHistoryUseCase useCase;
  final GetPdfUseCase getPdfUseCase;
  final ApiClient apiClient;
  final StreamController<AlertDialogEvent> dialogController =
      StreamController<AlertDialogEvent>();

  FilterTransactionHistoryBloc({
    required this.useCase,
    required this.apiClient,
    required this.getPdfUseCase,
  }) : super(FilterTransactionHistoryInitial()) {
    on<FetchTransactionHistoryEvent>((event, emit) async {
      emit(FilterTransactionHistoryLoading());
      try {
        final result = await useCase.execute(
          apartmentId: event.apartmentId,
          page: event.page,
          size: event.size,
          transactionDate: event.transactionDate,
        );
        emit(FilterTransactionHistoryLoaded(transactionHistory: result));
      } catch (e) {
        emit(FilterTransactionHistoryError(message: e.toString()));
      }
    });
    on<FetchPdfEvent>((event, emit) async {
      emit(FetchPdfLoading());
      try {
        final filePath = await getPdfUseCase.fetchPdf(
          apartmentId: event.apartmentId,
          year: event.year,
          month: event.month,
        );
        emit(FetchPdfSuccess(filePath: filePath));
      } catch (e) {
        emit(FetchPdfError(message: e.toString()));
      }
    });


    // on<FetchPdfEvent>((event, emit) async {
    //   CustomSnackbarWidget(
    //       context: event.context,
    //       title: "PDF Processing",
    //       backgroundColor: AppColor.green);
    //   try {
    //     final response = await ApiClient().get(
    //       'customer/report/apartment/${event.apartmentId}/year/${event.year}/month/${event.month}',
    //     );
    //     if (response.statusCode == 200) {
    //       CustomSnackbarWidget(
    //           context: event.context,
    //           title: "PDF Downloaded Sucessfully",
    //           backgroundColor: AppColor.green);
    //     } else {
    //       throw Exception(
    //           "Failed to fetch PDF. Status Code: ${response.statusCode}");
    //     }
    //   } catch (e) {
    //     ScaffoldMessenger.of(event.context).showSnackBar(
    //       SnackBar(
    //         content: Text('Error: ${e.toString()}'),
    //       ),
    //     );
    //   }
    // });
  }

  @override
  Future<void> close() {
    dialogController.close();
    return super.close();
  }
}
