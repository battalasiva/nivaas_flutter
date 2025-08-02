import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/gradients.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/dues-meters/maintainance/bloc/maintainance_bloc.dart';
import 'package:nivaas/screens/dues-meters/transaction-history/transaction_history.dart';
import 'package:nivaas/widgets/cards/transaction_card.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/Custom_popup.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/others/transaction_filters.dart';
import 'package:nivaas/widgets/others/Transaction-popup/transaction_popup.dart';

class Account extends StatefulWidget {
  final int? apartmentId;
  final bool? isOwner, isAdmin, isReadOnly;
  const Account(
      {super.key,
      this.apartmentId,
      this.isOwner,
      this.isAdmin,
      this.isReadOnly});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String _balance = "0";
  String _lastUpdated = '';
  String? selectedStatus;
  int? apartmentId;
  int pageNo = 0;
  final int pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  List<dynamic> transactions = [];
  bool isLoadingMore = false;
  bool hasMore = true;
  Map<String, dynamic> appliedFilters = {"filters": []};

  @override
  void initState() {
    super.initState();
    fetchBalance();
    fetchTransactionHistory();
    _scrollController.addListener(_onScroll);
  }

  void fetchBalance() {
    context
        .read<MaintainanceBloc>()
        .add(GetCurrentBalanceEvent(apartmentId: widget.apartmentId!));
  }

  void fetchTransactionHistory() {
    if (isLoadingMore || !hasMore) return;
    setState(() {
      isLoadingMore = true;
    });
    context.read<MaintainanceBloc>().add(FetchTransactions(
          apartmentId: widget.apartmentId!,
          page: pageNo,
          size: pageSize,
          appliedFilters: appliedFilters,
    ));
  }

  Future<void> fetchbalanceTransactioDetails() async {
    fetchBalance();
    fetchTransactionHistory();
  }

  void refreshBalance(int apartmentId) {
    context.read<MaintainanceBloc>().add(RefreshBalanceRequested(apartmentId));
  }

  void _onTransactionCompleted() {
    setState(() {
      transactions.clear();
      pageNo = 0;
      hasMore = true;
    });
    fetchTransactionHistory();
    fetchBalance();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !isLoadingMore &&
        hasMore) {
      pageNo++;
      fetchTransactionHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(
        title: 'Account',
        actions: [
          if (widget.isAdmin! || widget.isOwner!)
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionHistory(
                              apartmentId: widget.apartmentId)));
                },
                child: Image.asset(
                  pdfDownload,
                  width: 25,
                  height: 25,
                  color: AppColor.white,
                ),
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchbalanceTransactioDetails,
        child: Column(
          children: [
            BlocListener<MaintainanceBloc, MaintainanceState>(
              listener: (context, state) {
                if (state is MaintainanceLoaded) {
                  setState(() {
                    _balance = state.currentBalance.currentBalance.toString();
                    _lastUpdated = state.currentBalance.lastUpdated ?? '';
                  });
                } else if (state is RefreshBalanceSuccess) {
                  CustomSnackbarWidget(
                    context: context,
                    title: state.message,
                    backgroundColor: AppColor.green,
                  );
                  fetchBalance();
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                width: getWidth(context) * 0.9,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor2,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Current Balance",
                          style: txt_17_700.copyWith(color: AppColor.white),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs $_balance",
                          style: txt_34_700.copyWith(color: AppColor.white),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Updated:",
                              style: txt_12_400.copyWith(color: AppColor.white),
                            ),
                            Text(
                              _lastUpdated == ''
                                  ? 'Never'
                                  : formatDate(_lastUpdated),
                              style: txt_12_400.copyWith(color: AppColor.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Transactions",
                    style: txt_18_700.copyWith(color: AppColor.black),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionFilters(
                            onApplyFilters: (filters) {
                              setState(() {
                                appliedFilters = filters;
                                transactions.clear();
                                pageNo = 0;
                                hasMore = true;
                              });
                              fetchTransactionHistory();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<MaintainanceBloc, MaintainanceState>(
                listener: (context, state) {
                  if (state is TransactionLoaded) {
                    print('transactions:$transactions');
                    setState(() {
                      transactions.addAll(state.transactions);
                      hasMore = state.transactions.length == pageSize;
                      isLoadingMore = false;
                    });
                  } else if (state is TransactionError) {
                    setState(() {
                      isLoadingMore = false;
                      hasMore = false;
                    });
                  }
                },
                builder: (context, state) {
                  if (state is TransactionLoading && transactions.isEmpty) {
                    return const Center(child: AppLoader());
                  } else if (transactions.isEmpty) {
                    return FutureBuilder(
                      future: Future.delayed(
                          const Duration(seconds: 3)), 
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: AppLoader());
                        } else {
                          return Center(
                            child: Text(
                              "No transactions available",
                              style: txt_16_500.copyWith(color: AppColor.black),
                            ),
                          );
                        }
                      },
                    );
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20)
                        .copyWith(bottom: getHeight(context) * 0.1),
                    itemCount: transactions.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == transactions.length) {
                        return const Center(child: AppLoader());
                      }
                      final transaction = transactions[index];
                      return GestureDetector(
                        onTap: () {
                          if (transaction.transactionType == "BILL") {
                            _showCustomPopup(
                              context,
                              title: 'Bill is Not Editable',
                              content: 'You cannot edit this bill.',
                              buttonText: 'Done',
                              backgroundColor: AppColor.white,
                              onButtonPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          } else {
                            widget.isReadOnly!
                                ? showSnackbarForNonAdmins(context)
                                : _showTransactionPopup(
                                    context,
                                    transaction.transactionType == "CREDIT"
                                        ? 'EDIT_CREDIT'
                                        : 'EDIT_DEBIT',
                                    transaction.transactionDate,
                                    transaction.transactionDescription,
                                    transaction.transactionAmount.toString(),
                                    transaction.transactionType,
                                    transaction.transactionCategory,
                                    transaction.transactionId,
                                  );
                          }
                        },
                        child: TransactionCard(
                          isCredit: transaction.transactionType == "BILL" ||
                              transaction.transactionType == "CREDIT",
                          name: (transaction.transactionType == "BILL" ||
                                  transaction.transactionType == "CREDIT")
                              ? 'Credited'
                              : 'Paid To',
                          amount: transaction.transactionAmount.toString(),
                          time: transaction.transactionDate ?? '',
                          description: transaction.transactionDescription ?? '',
                          lastUpdated: transaction.lastUpdated ?? '',
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: getHeight(context) * 0.1,
        decoration: BoxDecoration(
          gradient: widget.isReadOnly!
              ? AppGradients.greyGradient
              : AppGradients.gradient1,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => widget.isReadOnly!
                    ? showSnackbarForNonAdmins(context)
                    : _showTransactionPopup(
                        context, 'DEBIT_ADD', '', '', '', '', '', 0),
                child: Text(
                  'Add Debit',
                  textAlign: TextAlign.center,
                  style: txt_15_500.copyWith(color: AppColor.white1),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => widget.isReadOnly!
                    ? showSnackbarForNonAdmins(context)
                    : _showTransactionPopup(
                        context, 'CREDIT_ADD', '', '', '', '', '', 0),
                child: Text(
                  'Add Credit',
                  textAlign: TextAlign.center,
                  style: txt_15_500.copyWith(color: AppColor.white1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionPopup(
      BuildContext context,
      String requestType,
      transactionDate,
      transactionDescription,
      transactionAmount,
      transactionType,
      transactionCategory,
      transactionId) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return TransactionPopup(
          requestType: requestType,
          apartmentId: widget.apartmentId!,
          onTransactionCompleted: _onTransactionCompleted,
          transactionDate: transactionDate,
          transactionDescription: transactionDescription,
          transactionAmount: transactionAmount,
          transactionType: transactionType,
          transactionCategory: transactionCategory ?? '',
          transactionId: transactionId,
        );
      },
    );
  }
}

void _showCustomPopup(
  BuildContext context, {
  required String title,
  required String content,
  required String buttonText,
  required Color backgroundColor,
  required VoidCallback onButtonPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CustomPopup(
        title: title,
        content: content,
        buttonText: buttonText,
        onButtonPressed: onButtonPressed,
      );
    },
  );
}