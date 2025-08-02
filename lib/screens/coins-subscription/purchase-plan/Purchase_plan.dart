import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/coins-subscription/payment_done.dart';
import 'package:nivaas/screens/coins-subscription/purchase-plan/bloc/purchase_plan_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PurchasePlan extends StatefulWidget {
  const PurchasePlan({
    super.key,
    required this.apartmentID,
    required this.months,
    required this.coins,
    required this.balance,
    this.mobileNumber,
    this.email,
    this.apartmentName,
  });

  final int apartmentID;
  final int months;
  final double coins;
  final double balance;
  final String? mobileNumber, email, apartmentName;

  @override
  State<PurchasePlan> createState() => _PurchasePlanState();
}

class _PurchasePlanState extends State<PurchasePlan> {
  late Razorpay _razorpay;
  final razorPayKey = 'rzp_test_aa2AmRQV2HpRyT';
  final razorPaySecret = 'UMfObdnXjWv3opzzTwHwAiv8';
  double baseAmount = 0.0;
  double gstAmount = 0.0;
  double totalAmount = 0.0;
  String orderId = '';
  bool isVerifying = false;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void openCheckout(orderId, amount) async {
    var options = {
      'key': razorPayKey,
      'amount': (amount * 100).toInt(),
      'name': 'Nivaas Payment',
      'description': 'Subscription Renewal',
      'order_id': orderId,
      'timeout': 300,
      'prefill': {
        'contact': '${widget.mobileNumber}',
        'email': '${widget.email}'
      },
      'readonly': {
        'contact': true,
        'email': true,
      },
      'theme': {'color': '#233C72'},
    };
    print(options);
    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      isVerifying = true;
    });
    print(
        'Payment Success: ${response.paymentId} ${response.signature} ${response.orderId}');
    context.read<PurchasePlanBloc>().add(
          VerifyPaymentOrderButtonPressed(
            paymentId: response.paymentId.toString(),
            orderId: orderId,
            signature: response.signature.toString(),
          ),
        );
  }

  void handlePaymentFailure(PaymentFailureResponse response) {
    CustomSnackbarWidget(
      context: context,
      title: 'Payment Cancelled',
      backgroundColor: AppColor.red,
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    CustomSnackbarWidget(
      context: context,
      title: 'External Wallet Selected: ${response.walletName}',
      backgroundColor: AppColor.orange,
    );
  }

  Future<void> submitPurchaseDetails() async {
    context.read<PurchasePlanBloc>().add(
          CreatePaymentOrderButtonPressed(
            apartmentId: widget.apartmentID,
            months: widget.months.toString(),
            coinsToUse: widget.coins.toString(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Apartment ID: ${widget.apartmentID} ${widget.email} ${widget.mobileNumber} orderId : $orderId');
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Payment'),
      body: BlocConsumer<PurchasePlanBloc, PurchasePlanState>(
        listener: (context, state) {
          if (state is VerifyPaymentOrderSuccess) {
            print('Payment Verification Success: ${state.data}');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentDone(
                  isSuccess: true,
                  amountPaid: totalAmount.abs(),
                  months: widget.months,
                  apartmentName: widget.apartmentName ?? '',
                  subscriptionType: 'Premium',
                ),
              ),
            );
          }

          if (state is VerifyPaymentOrderFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentDone(
                  isSuccess: false,
                  amountPaid: totalAmount.abs(),
                  months: widget.months,
                  apartmentName: widget.apartmentName ?? '',
                  subscriptionType: 'Premium',
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is VerifyPaymentOrderLoading) {
            return const Center(child: AppLoader());
          }

          return Padding(
            padding: EdgeInsets.all(getWidth(context) * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Plan Details",
                  style: txt_14_600.copyWith(color: AppColor.black2),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Container(
                    width: getWidth(context) * 0.9,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.blueShade,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Selected Plan : ",
                              style:
                                  txt_12_600.copyWith(color: AppColor.black2),
                            ),
                            Text(
                              "Premium",
                              style: txt_14_600.copyWith(color: AppColor.blue),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Duration : ",
                              style:
                                  txt_12_600.copyWith(color: AppColor.black2),
                            ),
                            Text(
                              "${widget.months} Months",
                              style: txt_14_600.copyWith(color: AppColor.blue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Price Details
                Text(
                  "Price Details",
                  style: txt_14_600.copyWith(color: AppColor.black2),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.blueShade,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Required Coins :",
                            style: txt_12_600.copyWith(color: AppColor.black2),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Current Coins Balance :",
                            style: txt_12_600.copyWith(color: AppColor.black2),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.coins}",
                            style: txt_14_600.copyWith(
                                color: AppColor.primaryColor1),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${widget.balance}",
                            style: txt_14_600.copyWith(
                                color: AppColor.primaryColor1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.balance < widget.coins) ...[
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Plan Amount : ",
                        style: txt_14_600.copyWith(color: AppColor.black2),
                      ),
                      Text(
                        "${(widget.coins).abs()} /-",
                        style: txt_14_600.copyWith(color: AppColor.black2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coins Deducted : ",
                        style: txt_14_600.copyWith(color: AppColor.black2),
                      ),
                      Text(
                        "${(widget.balance).abs()} /-",
                        style: txt_14_600.copyWith(color: AppColor.black2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount To Be Paid : ",
                        style: txt_14_600.copyWith(color: AppColor.black2),
                      ),
                      Text(
                        "${(widget.balance - widget.coins).abs()} /-",
                        style: txt_14_600.copyWith(color: AppColor.black2),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        color: AppColor.white,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: BlocConsumer<PurchasePlanBloc, PurchasePlanState>(
          listener: (context, state) {
            if (state is CreatePaymentOrderSuccess) {
              try {
                final dynamic rawData = jsonDecode(state.data);
                if (rawData is Map<String, dynamic> &&
                    rawData['status'] == 'success') {
                  CustomSnackbarWidget(
                    context: context,
                    title: rawData['message'] ?? 'Subscription successful',
                    backgroundColor: AppColor.green,
                  );
                  Navigator.pop(context);
                  return; 
                }
                if (rawData is Map<String, dynamic>) {
                  final String? orderId = rawData['orderId'];
                  final double? totalAmount =
                      (rawData['totalCost'] ?? 0).toDouble();
                  setState(() {
                    this.orderId = orderId ?? '';
                    this.totalAmount = totalAmount ?? 0.0;
                  });
                  if (orderId != null &&
                      orderId.isNotEmpty &&
                      totalAmount != null &&
                      totalAmount > 0) {
                    openCheckout(orderId, totalAmount);
                    return;
                  }
                }
                CustomSnackbarWidget(
                  context: context,
                  title: 'Unexpected response format from server',
                  backgroundColor: AppColor.red,
                );
              } catch (e) {
                CustomSnackbarWidget(
                  context: context,
                  title: 'Failed to process payment data',
                  backgroundColor: AppColor.red,
                );
              }
            } else if (state is CreatePaymentOrderFailure) {
              CustomSnackbarWidget(
                context: context,
                title: state.error,
                backgroundColor: AppColor.red,
              );
            }
          },
          builder: (context, state) {
            final isProcessing = state is CreatePaymentOrderLoading;
            return Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 20),
              child: CustomizedButton(
                label: isProcessing ? 'Processing...' : 'Proceed To Purchase',
                style: txt_14_500.copyWith(color: AppColor.white),
                onPressed: isProcessing ? () {} : () => submitPurchaseDetails(),
              ),
            );
          },
        ),
      ),
    );
  }
}
