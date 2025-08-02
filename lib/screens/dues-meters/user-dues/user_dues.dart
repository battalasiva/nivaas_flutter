import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/dues/userDue_model.dart';
import 'package:nivaas/screens/dues-meters/user-dues/ViewBillScreen.dart';
import 'package:nivaas/screens/dues-meters/user-dues/bloc/user_dues_bloc.dart';
import 'package:nivaas/screens/dues-meters/user-dues/bloc/user_dues_event.dart';
import 'package:nivaas/screens/dues-meters/user-dues/bloc/user_dues_state.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/others/Admin_prepaidMeter.dart';

class UserDues extends StatefulWidget {
  final int? apartmentId, flatID;
  const UserDues({super.key, this.apartmentId, this.flatID});

  @override
  State<UserDues> createState() => _UserDuesState();
}

class _UserDuesState extends State<UserDues> {
  List<UserDuesModal> userDuesList = [];
  String? selectedYear;
  String? selectedMonth;
  int? selectedMonthIndex = DateTime.now().month;

  final List<String> years = List.generate(
      DateTime.now().year - 2023 + 1, (index) => (2023 + index).toString());

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year.toString();
    selectedMonth = months[DateTime.now().month - 1]['name'].toString();
    _fetchUserDues();
  }

  void _fetchUserDues() {
    context.read<UserDuesBloc>().add(
          FetchUserDuesEvent(
            apartmentId: widget.apartmentId ?? 0,
            flatId: widget.flatID ?? 1,
            year: int.parse(selectedYear ?? '0'),
            month: selectedMonthIndex ?? 0,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Society Dues'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(context) * 0.05, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: YearDropdown(
                    years: years,
                    selectedYear: selectedYear,
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                        userDuesList.clear();
                        _fetchUserDues();
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
                        userDuesList.clear();
                        _fetchUserDues();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<UserDuesBloc, UserDuesState>(
              builder: (context, state) {
                if (state is UserDuesLoading) {
                  return const Center(child: AppLoader());
                } else if (state is UserDuesLoaded) {
                  userDuesList = state.userDues;
                }
                if (userDuesList.isEmpty) {
                  return const Center(
                    child: Text('No Dues Available'),
                  );
                }

                if (userDuesList.length == 1) {
                  return _buildSingleDuesView(userDuesList.first);
                }

                return ListView.builder(
                  itemCount: userDuesList.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return _buildDuesCard(userDuesList[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleDuesView(UserDuesModal userDues) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.blueShade,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Dues',
                      style: txt_14_500.copyWith(color: AppColor.black2)),
                  Text('Rs ${userDues.cost}',
                      style: txt_14_700.copyWith(
                          color: userDues.status == 'PAID'
                              ? AppColor.green
                              : AppColor.red)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Status',
                      style: txt_14_500.copyWith(color: AppColor.black2)),
                  Text(userDues.status,
                      style: txt_14_700.copyWith(
                          color: userDues.status == 'PAID'
                              ? AppColor.green
                              : AppColor.red)),
                ],
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Due Date: ${formatDate(userDues.dueDate)}',
                  style: txt_10_500.copyWith(
                      color: AppColor.primaryColor1.withOpacity(0.54)),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(context) * 0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detailed Bill',
                  style: txt_14_600.copyWith(color: AppColor.black2),
                ),
                const SizedBox(height: 10),
                Container(
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
                        'Monthly Maintenance',
                        style: txt_14_400.copyWith(color: AppColor.black2),
                      ),
                      Text(
                        'Rs ${userDues.fixedCost}',
                        style: txt_14_400.copyWith(color: AppColor.black2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                if (userDues.expenseSplitters != null &&
                    userDues.expenseSplitters!.isNotEmpty) ...[
                  // Text(
                  //   'Splitter Details',
                  //   style: txt_14_600.copyWith(color: AppColor.black2),
                  // ),
                  ...userDues.expenseSplitters!.map((splitter) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: AppColor.blueShade,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            splitter.name ?? '',
                            style: txt_12_500.copyWith(color: AppColor.black2),
                          ),
                          Text(
                            'Rs ${splitter.splitCost?.toStringAsFixed(2) ?? '0.00'}',
                            style: txt_12_500.copyWith(color: AppColor.black2),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
                // 👇 Maintenance Details
                if (userDues.maintenanceDetails != null &&
                    userDues.maintenanceDetails!.isNotEmpty)
                  ...userDues.maintenanceDetails!.map((maintenanceDetail) {
                    return Admin_prepaidMeter(
                      meterName: maintenanceDetail.name ?? '',
                      costPerUnit: maintenanceDetail.costPerUnit.toString(),
                      unitsConsumed: maintenanceDetail.unitsConsumed.toString(),
                      previousReading:
                          maintenanceDetail.previousReading?.toString(),
                      currentReading:
                          maintenanceDetail.currentReading.toString(),
                      meterCost: (maintenanceDetail.costPerUnit ?? 0.0) *
                          (maintenanceDetail.unitsConsumed ?? 0.0),
                      dueDate: userDues.dueDate ?? 'NA',
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
                    );
                  }).toList()
                else
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Prepaid meters not configured to this bill",
                        style: txt_14_500.copyWith(color: AppColor.black2),
                      ),
                    ),
                  ),

                const SizedBox(height: 10),

                // 👇 Expense Splitter Section
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDuesCard(UserDuesModal userDues) {
    return Card(
      elevation: 0,
      color: AppColor.blueShade,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.primaryColor1,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              '${formatDate(userDues.dueDate)} Bills/Dues',
              style: txt_14_700.copyWith(color: AppColor.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Due : ',
                          style: txt_13_400.copyWith(color: AppColor.black1),
                        ),
                        Text(
                          'Rs ${userDues.cost}',
                          style: txt_13_400.copyWith(color: AppColor.green),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Status : ',
                          style: txt_13_400.copyWith(color: AppColor.black1),
                        ),
                        Text(
                          userDues.status == "PAID" ? "Paid" : "Unpaid",
                          style: txt_13_400.copyWith(
                            color: userDues.status == "PAID"
                                ? AppColor.green
                                : AppColor.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // View Bill Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewBillScreen(
                            maintenanceDetails: userDues.maintenanceDetails,
                            fixedCost: userDues.fixedCost,
                            dueDate: userDues.dueDate,
                            status: userDues.status,
                            totalCost: userDues.cost,
                            expenseSplitters: userDues.expenseSplitters),
                      ),
                    );
                  },
                  child: Text(
                    'View Bill',
                    style: txt_13_500.copyWith(color: AppColor.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
