import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/dues/userDue_model.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/others/Admin_prepaidMeter.dart';

class ViewBillScreen extends StatefulWidget {
  final String? dueDate, status;
  final double? fixedCost, totalCost;
  final List<MaintenanceDetail>? maintenanceDetails;
  final List<ExpenseSplitters>? expenseSplitters;

  const ViewBillScreen({
    super.key,
    this.maintenanceDetails,
    this.fixedCost,
    this.dueDate,
    this.status,
    this.totalCost,
    this.expenseSplitters,
  });

  @override
  State<ViewBillScreen> createState() => _ViewBillScreenState();
}

class _ViewBillScreenState extends State<ViewBillScreen> {
  late List<MaintenanceDetail> parsedMaintenanceDetails;
  late List<ExpenseSplitters> parsedExpenseSplitters;

  @override
  void initState() {
    super.initState();
    parsedMaintenanceDetails = widget.maintenanceDetails ?? [];
    parsedExpenseSplitters = widget.expenseSplitters ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Bill'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Top Summary
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColor.blueShade,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow('Total Cost:',
                      'Rs ${widget.totalCost?.toStringAsFixed(2) ?? "0.00"}'),
                  const SizedBox(height: 8),
                  _buildRow('Due Date:', formatDate(widget.dueDate ?? 'NA')),
                  const SizedBox(height: 8),
                  _buildRow(
                    'Status:',
                    widget.status ?? 'NA',
                    valueColor: widget.status?.toLowerCase() == 'paid'
                        ? AppColor.green
                        : AppColor.red,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Maintenance Fixed Cost
            Text('Detailed Bill',
                style: txt_14_600.copyWith(color: AppColor.black1)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: AppColor.blueShade,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monthly Maintenance',
                    style: txt_14_400.copyWith(color: AppColor.black2),
                  ),
                  Text(
                    'Rs ${widget.fixedCost}',
                    style: txt_14_400.copyWith(color: AppColor.black2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (parsedExpenseSplitters.isNotEmpty) ...[
              // const SizedBox(height: 10),
              // Text('Splitter Details',
              //     style: txt_14_600.copyWith(color: AppColor.black2)),
              const SizedBox(height: 10),
              ...parsedExpenseSplitters.map((splitter) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColor.blueShade,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        splitter.name ?? '',
                        style: txt_12_500.copyWith(color: AppColor.blue),
                      ),
                      Text(
                        'Rs ${splitter.splitCost?.toStringAsFixed(2) ?? '0.00'}',
                        style: txt_12_500.copyWith(color: AppColor.black2),
                      ),
                    ],
                  ),
                );
              }).toList()
            ],
            // Prepaid Meter Details
            if (parsedMaintenanceDetails.isNotEmpty)
              ...parsedMaintenanceDetails.map((maintenanceDetail) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Admin_prepaidMeter(
                    meterName: maintenanceDetail.name ?? '',
                    costPerUnit: maintenanceDetail.costPerUnit.toString(),
                    unitsConsumed: maintenanceDetail.unitsConsumed.toString(),
                    previousReading:
                        maintenanceDetail.previousReading?.toString() ?? '0.0',
                    meterCost: (maintenanceDetail.costPerUnit ?? 0.0) *
                        (maintenanceDetail.unitsConsumed ?? 0.0),
                    dueDate: widget.dueDate ?? 'NA',
                    costPerPrepaidMeter:
                        maintenanceDetail.costPerPrepaidMeter.toString(),
                    configRangeList: maintenanceDetail.configRangeList
                            ?.map<Map<String, dynamic>>((config) => {
                                  'startRange': config.startRange,
                                  'endRange': config.endRange,
                                  'costPerUnit': config.costPerUnit,
                                })
                            .toList() ??
                        [],
                  ),
                );
              }).toList()
            else
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Prepaid meters not configured to this bill",
                    style: txt_14_400.copyWith(color: AppColor.black2),
                  ),
                ),
              ),

            // Expense Splitter Section (only show if data is present)
            
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: txt_12_500.copyWith(color: AppColor.black1)),
        Text(value,
            style: txt_14_500.copyWith(color: valueColor ?? AppColor.black1)),
      ],
    );
  }
}
