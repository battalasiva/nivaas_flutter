import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/others/ContactUsModel.dart';

class PaymentDone extends StatelessWidget {
  final bool isSuccess;
  final double amountPaid;
  final int months;
  final String apartmentName;
  final String subscriptionType;

  const PaymentDone({
    Key? key,
    required this.isSuccess,
    required this.amountPaid,
    required this.months,
    required this.apartmentName,
    required this.subscriptionType,
  }) : super(key: key);

  void showContactUsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ContactUsModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Apartment Name $apartmentName');
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: EdgeInsets.all(getWidth(context) * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(
                    isSuccess ? Icons.check_circle : Icons.cancel,
                    size: 150,
                    color:isSuccess ? AppColor.green : AppColor.red,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              isSuccess ? "Payment Successful" : "Payment Failed",
              style: txt_18_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 5),
            Card(
              elevation: 0,
              color: AppColor.blueShade,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow("Apartment Name", apartmentName),
                    _buildDetailRow("Amount", "${amountPaid.toString()} /-"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildSupportButton(context),
            if (!isSuccess) ...[
              const SizedBox(height: 20),
              Text(
                "Payment failed due to some issues. The amount will be refunded back with in 7 working days.",
                textAlign: TextAlign.center,
                style: txt_14_500.copyWith(color: AppColor.red),
              ),
            ],
          ],
        ),
      ),
      bottomSheet: Container(
        color: AppColor.white,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Padding(
          padding: EdgeInsets.only(bottom: 40),
          child: CustomizedButton(
              label: 'DONE',
              style: txt_15_500.copyWith(color: AppColor.white),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              }),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: txt_13_400.copyWith(color: AppColor.black1)),
          SizedBox(
            child: Text(
              value,
              style: txt_14_500.copyWith(color: AppColor.blue),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportButton(context) {
    return GestureDetector(
      onTap: () {
        showContactUsModal(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColor.blueShade,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.support_agent, color: AppColor.black, size: 20),
            const SizedBox(width: 8),
            Text(
              "Contact Nivaas Support",
              style: txt_14_500.copyWith(color: AppColor.black),
            ),
          ],
        ),
      ),
    );
  }
}
