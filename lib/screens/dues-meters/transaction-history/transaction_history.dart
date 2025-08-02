import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/dues-meters/transaction-history/bloc/transaction_history_bloc.dart';
import 'package:nivaas/screens/dues-meters/transaction-history/bloc/transaction_history_event.dart';
import 'package:nivaas/screens/dues-meters/transaction-history/bloc/transaction_history_state.dart';
import 'package:nivaas/widgets/cards/transaction_card.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';

class TransactionHistory extends StatefulWidget {
  final int? apartmentId;
  const TransactionHistory({super.key, this.apartmentId});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  String? selectedYear;
  String? selectedMonth;
  int? selectedMonthIndex;
  String? transactionDate;
  int? yearInt;
  int? monthInt;

  final List<String> years = List.generate(
      DateTime.now().year - 2023 + 1, (index) => (2023 + index).toString());
  final ScrollController _scrollController = ScrollController();
  int pageNo = 0;
  final int pageSize = 10;
  bool isLoadingMore = false;
  bool hasMore = true;
  List<dynamic> transactionsHistory = [];
  bool isInitialLoading = true;
  bool isDownloading = false; 

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedYear = now.year.toString();
    yearInt = int.parse(selectedYear!);
    selectedMonthIndex = now.month;
    selectedMonth = months
        .firstWhere((month) => month['index'] == now.month)['name']
        .toString();
    transactionDate =
        "$selectedYear-${selectedMonthIndex!.toString().padLeft(2, '0')}";

    _fetchTransactionHistory();
    _scrollController.addListener(_onScroll);
  }

  void _fetchTransactionHistory() {
    if (isLoadingMore || !hasMore) return;

    setState(() {
      isLoadingMore = true;
      if (transactionsHistory.isEmpty) {
        isInitialLoading = true;
      }
    });

    context.read<FilterTransactionHistoryBloc>().add(
          FetchTransactionHistoryEvent(
            apartmentId: widget.apartmentId!,
            page: pageNo,
            size: pageSize,
            transactionDate: transactionDate!,
          ),
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !isLoadingMore &&
        hasMore) {
      pageNo++;
      _fetchTransactionHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Transaction History'),
      body: Padding(
        padding: EdgeInsets.all(getWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: YearDropdown(
                    years: years,
                    selectedYear: selectedYear,
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                        transactionDate =
                            "$selectedYear-${selectedMonthIndex!.toString().padLeft(2, '0')}";
                        pageNo = 0;
                        transactionsHistory.clear();
                        hasMore = true;
                        _fetchTransactionHistory();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MonthDropdown(
                    months: months,
                    selectedMonth: selectedMonth,
                    onChanged: (value) {
                      setState(() {
                        selectedMonthIndex = value;
                        selectedMonth = months
                            .firstWhere(
                                (month) => month['index'] == value)['name']
                            .toString();
                        transactionDate =
                            "$selectedYear-${selectedMonthIndex!.toString().padLeft(2, '0')}";
                        pageNo = 0;
                        transactionsHistory.clear();
                        hasMore = true;
                        _fetchTransactionHistory();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Transactions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocListener<FilterTransactionHistoryBloc,
                  FilterTransactionHistoryState>(
                listener: (context, state) {
                  if (state is FetchPdfLoading) {
                    setState(() {
                      isDownloading = true;
                    });
                  } else if (state is FetchPdfSuccess) {
                    setState(() {
                      isDownloading = false;
                    });
                    CustomSnackbarWidget(
                      context: context,
                      title: "PDF Downloaded Successfully",
                      backgroundColor: AppColor.green,
                    );
                  } else if (state is FetchPdfError) {
                    setState(() {
                      isDownloading = false;
                    });
                    CustomSnackbarWidget(
                      context: context,
                      title: 'Failed to download PDF',
                      backgroundColor: AppColor.red,
                    );
                  } else if (state is FilterTransactionHistoryLoaded) {
                    setState(() {
                      transactionsHistory
                          .addAll(state.transactionHistory.content as Iterable);
                      hasMore =
                          state.transactionHistory.content?.length == pageSize;
                      isLoadingMore = false;
                      isInitialLoading = false;
                    });
                  } else if (state is FilterTransactionHistoryError) {
                    setState(() {
                      isLoadingMore = false;
                      hasMore = false;
                      isInitialLoading = false;
                    });
                    CustomSnackbarWidget(
                      context: context,
                      title: "Failed To Fetch Transactions",
                      backgroundColor: AppColor.red,
                    );
                  }
                },
                child: isInitialLoading
                    ? const Center(child: AppLoader())
                    : transactionsHistory.isEmpty
                        ? Center(
                            child: Text(
                              "No transactions available",
                              style: txt_14_600.copyWith(color: AppColor.black1),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: transactionsHistory.length +
                                (isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == transactionsHistory.length) {
                                return const Center(
                                    child: AppLoader());
                              }
                              final transaction = transactionsHistory[index];
                              return TransactionCard(
                                isCredit: transaction.transactionType ==
                                        "CREDIT" ||
                                    transaction.transactionType == "BILL",
                                name: transaction.transactionType == "DEBIT"
                                    ? 'Paid To'
                                    : 'Credited',
                                amount:
                                    '${transaction.transactionAmount?.toStringAsFixed(2)}',
                                time: transaction.transactionDate ?? '',
                                description:
                                    transaction.transactionDescription ?? '',
                                lastUpdated:transaction.lastUpdated ?? '',
                              );
                            },
                          ),
              ),
            ),
            const SizedBox(height: 16),
            if (transactionsHistory.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 5),
                child: CustomizedButton(
                  label: isDownloading ? 'Downloading...' : 'Download PDF',
                  style: txt_15_500.copyWith(color: AppColor.white),
                  onPressed: isDownloading
                      ? () {}
                      : () {
                          BlocProvider.of<FilterTransactionHistoryBloc>(
                              context)
                              .add(
                            FetchPdfEvent(
                              apartmentId: widget.apartmentId!,
                              year: yearInt ?? 0,
                              month: selectedMonthIndex ?? 0,
                            ),
                          );
                        },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
