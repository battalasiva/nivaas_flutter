import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/toggleButton.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'bloc/admin_dues_bloc.dart';

class AdminDues extends StatefulWidget {
  final int? apartmentId;
  final String? currentApartment;
  final bool? isOwner, isAdmin, isReadOnly;
  const AdminDues({
    super.key,
    this.apartmentId,
    this.currentApartment,
    this.isAdmin,
    this.isOwner,
    this.isReadOnly,
  });

  @override
  State<AdminDues> createState() => _AdminDuesState();
}

class _AdminDuesState extends State<AdminDues> {
  bool showPaid = false;
  final Set<int> selectedIds = {};
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
    fetchAdminDues();
  }

  Future<void> fetchAdminDues() async{
    context.read<AdminDuesBloc>().add(FetchAdminDuesEvent(
          apartmentId: widget.apartmentId ?? 0,
          year: int.parse(selectedYear ?? ''),
          month: selectedMonthIndex ?? 1,
    ));
  }

  void onDonePressed() {
    final ids = selectedIds.join(",");
    if (ids.isEmpty) {
      CustomSnackbarWidget(
        context: context,
        title: "No items selected",
        backgroundColor: AppColor.orange,
      );
      return;
    }
    final status = showPaid ? "UNPAID" : "PAID";
    context.read<AdminDuesBloc>().add(UpdateDueRequestEvent(
          apartmentId: widget.apartmentId.toString(),
          status: status,
          societyDueIds: ids,
        ));
    selectedIds.clear();
    Future.delayed(const Duration(milliseconds: 1200), () {
      fetchAdminDues();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: 'Update Payment'),
      backgroundColor: AppColor.white,
      body: Padding(
        padding: EdgeInsets.all(getWidth(context) * 0.05),
        child: RefreshIndicator(
          onRefresh: fetchAdminDues,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apartment Details",
                style: txt_14_600.copyWith(color: AppColor.black),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.blueShade,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.blueShade),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Community Name: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: getWidth(context)/2.3,
                        child: Text(
                          widget.currentApartment ?? 'NA',
                          style: txt_14_500.copyWith(color: AppColor.blue),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
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
                          fetchAdminDues();
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
                          fetchAdminDues();
                        });
                      },
                    ),)
                ],
              ),
              const SizedBox(height: 15),
              ToggleButtonWidget(
                leftTitle: "Unpaid",
                rightTitle: "Paid",
                isLeftSelected: !showPaid,
                onChange: (isLeft) => setState(() {
                  showPaid = !isLeft;
                  selectedIds.clear();
                }),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocConsumer<AdminDuesBloc, AdminDuesState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is AdminDuesLoading) {
                      return const Center(child: AppLoader());
                    } else if (state is AdminDuesError) {
                      return Center(child: Text(state.error));
                    } else if (state is AdminDuesLoaded) {
                      final filteredFlats = state.dues
                          .where((due) =>
                              (showPaid && due.status == "PAID") ||
                              (!showPaid && due.status != "PAID"))
                          .toList();
                      if (filteredFlats.isEmpty) {
                        return const Center(
                          child: Text("Data Not Available"),
                        );
                      }
                      return Column(
                        children: [
                          if (filteredFlats.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: getWidth(context) * 0.68,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        " Flat Number",
                                        style: txt_12_700.copyWith(
                                            color: AppColor.black1),
                                      ),
                                      Text(
                                        "Amount",
                                        style: txt_12_700.copyWith(
                                            color: AppColor.black1),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (!widget.isReadOnly!) {
                                      setState(() {
                                        if (selectedIds.length ==
                                            filteredFlats.length) {
                                          selectedIds.clear();
                                        } else {
                                          selectedIds.addAll(
                                              filteredFlats.map((e) => e.id!));
                                        }
                                      });
                                    } else {
                                      showSnackbarForNonAdmins(context);
                                    }
                                  },
                                  child: Text(
                                    selectedIds.length == filteredFlats.length
                                        ? "Unselect All"
                                        : "Select All",
                                    style: txt_10_500.copyWith(
                                      color: AppColor.primaryColor1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: filteredFlats.length,
                              itemBuilder: (context, index) {
                                final flat = filteredFlats[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.blueShade,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(flat.flatNo ?? '',
                                                  style: txt_12_500.copyWith(
                                                      color: AppColor.blue)),
                                              Text(
                                                "\u20B9 ${flat.cost?.toStringAsFixed(2) ?? '0.00'}",
                                                style: txt_12_500.copyWith(
                                                    color: AppColor.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Checkbox(
                                        value: selectedIds.contains(flat.id),
                                        activeColor: AppColor.blue,
                                        onChanged: !widget.isReadOnly!
                                            ? (value) {
                                                setState(() {
                                                  if (value == true) {
                                                    selectedIds.add(flat.id!);
                                                  } else {
                                                    selectedIds.remove(flat.id);
                                                  }
                                                });
                                              }
                                            : (value) {
                                                showSnackbarForNonAdmins(context);
                                              },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          if (widget.isAdmin!)
                            BlocConsumer<AdminDuesBloc, AdminDuesState>(
                              listener: (context, state) {
                                if (state is UpdateDueSuccess) {
                                  CustomSnackbarWidget(
                                    context: context,
                                    title: state.message,
                                    backgroundColor: AppColor.green,
                                  );
                                }
                              },
                              builder: (context, state) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 20, top: 10),
                                  child: CustomizedButton(
                                    label: showPaid
                                        ? 'Mark as Unpaid'
                                        : 'Mark as Paid',
                                    style: txt_14_500.copyWith(
                                        color: AppColor.white),
                                    onPressed: onDonePressed,
                                  ),
                                );
                              },
                            ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
