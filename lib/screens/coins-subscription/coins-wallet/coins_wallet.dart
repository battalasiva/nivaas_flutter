import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/coins-subscription/coins-wallet/bloc/coins_wallet_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class CoinsWallet extends StatefulWidget {
  final int? apartmentId;
  const CoinsWallet({super.key, this.apartmentId});

  @override
  State<CoinsWallet> createState() => _CoinsWalletState();
}

class _CoinsWalletState extends State<CoinsWallet> {
  double walletBalance = 0.0; // Variable to store balance
  List transactions = []; // Variable to store transactions

  @override
  void initState() {
    super.initState();
    
    context.read<CoinsWalletBloc>().add(
          CoinsBalenceEvent(apartmentId: widget.apartmentId!),
        );

    Future.delayed(Duration(milliseconds: 100), () {
      context.read<CoinsWalletBloc>().add(
            LoadCoinsWalletEvent(
              apartmentId: widget.apartmentId!,
              pageNo: 0,
              pageSize: 40,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Coins Wallet'),
      body: Column(
        children: [
          BlocConsumer<CoinsWalletBloc, CoinsWalletState>(
            listener: (context, state) {
              if (state is CoinsBalanceLoaded) {
                setState(() {
                  walletBalance = state.balance;
                });
              }
              if (state is CoinsWalletLoaded) {
                setState(() {
                  transactions = state.content;
                });
              }
            },
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor1,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wallet Balance",
                            style: txt_16_700.copyWith(color: AppColor.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "₹ $walletBalance",
                            style: txt_24_600.copyWith(color: AppColor.white),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      coins,
                      height: 100,
                    ),
                  ],
                ),
              );
            },
          ),

          // Recent Transactions Heading
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Wallet Transactions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Transactions List using BlocBuilder
          Expanded(
            child: BlocBuilder<CoinsWalletBloc, CoinsWalletState>(
              builder: (context, state) {
                if (state is CoinsWalletLoading) {
                  return const Center(child: AppLoader());
                }

                if (transactions.isEmpty) {
                  return Center(
                    child: Text(
                      'No transactions available',
                      style: txt_14_400.copyWith(color: AppColor.black2),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return WalletTransactionCard(
                      amount: transaction.amount!.toDouble(),
                      transactionType: transaction.transactionType!,
                      transactionDate: transaction.transactionDate!,
                      notes: transaction.notes!,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class WalletTransactionCard extends StatelessWidget {
  final double amount;
  final String transactionType;
  final String transactionDate;
  final String notes;

  const WalletTransactionCard({
    super.key,
    required this.amount,
    required this.transactionType,
    required this.transactionDate,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCredit = transactionType == "CREDIT";
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColor.blueShade,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Arrow Icon
          Image.asset(
            isCredit ? creditArrow : debitArrow,
            height: 28,
            width: 28,
          ),
          const SizedBox(width: 10),
          // Transaction Details and Amount in one row
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row for Title and Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Transaction Title
                    Flexible(
                      child: Text(
                        isCredit ? "Bonus Credited" : "Bonus Debited",
                        style: txt_16_700.copyWith(color: AppColor.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Amount
                    Text(
                      "₹ ${amount.toStringAsFixed(0)}",
                      style: txt_17_700.copyWith(color: AppColor.primaryColor1),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Notes
                Text(
                  notes,
                  style: txt_14_500.copyWith(color: AppColor.black),
                ),
                const SizedBox(height: 4),

                // Date
                Text(
                  formatDate(transactionDate),
                  style: txt_14_500.copyWith(color: AppColor.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}