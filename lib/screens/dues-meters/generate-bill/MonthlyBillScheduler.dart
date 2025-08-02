import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/dues-meters/generate-bill/bloc/generate_bill_bloc.dart';
import 'package:nivaas/screens/prepaid-meters/Add-prepaid_meter/AddPrepaidMeter.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomDatePicker.dart';
import 'package:nivaas/widgets/elements/CustomNumberTextField.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:intl/intl.dart';

class MonthlyBillScheduler extends StatefulWidget {
  final int? apartmentId;
  final String? currentApartment;
  final bool? isAdmin, isReadOnly;
  const MonthlyBillScheduler(
      {super.key,
      this.apartmentId,
      this.currentApartment,
      this.isAdmin,
      this.isReadOnly});

  @override
  State<MonthlyBillScheduler> createState() => _MonthlyBillSchedulerState();
}

class _MonthlyBillSchedulerState extends State<MonthlyBillScheduler> {
  final TextEditingController _maintenanceController = TextEditingController();
  String? selectedDate = 'NA';
  final List<int> selectedMeterIds = [];
  List<dynamic>? localMeters;

  @override
  void initState() {
    super.initState();
    context
        .read<GenerateBillBloc>()
        .add(FetchLastAddedGenerateBill(widget.apartmentId!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Monthly Bill Scheduler'),
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getWidth(context) * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apartment Details",
                style: txt_14_600.copyWith(color: AppColor.black1),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColor.blueShade,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Community Name:",
                      style: txt_12_500.copyWith(color: AppColor.black),
                    ),
                    SizedBox(
                      width: getWidth(context) / 2.3,
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
              Text(
                "Select Bill's To Be Posted",
                style: txt_14_600.copyWith(color: AppColor.black1),
              ),
              const SizedBox(height: 8),
              BlocConsumer<GenerateBillBloc, GenerateBillState>(
                listener: (context, state) {
                  if (state is GenerateBillLoaded) {
                    final data = state.bill.maintenanceData;
                    if (data != null) {
                      setState(() {
                        _maintenanceController.text =
                            data.cost?.toString() ?? "";
                        localMeters = data.jtPrePaidMeterDTOs ?? [];
                        selectedDate = data.notifyOn.toString();
                        _initializeSelectedMeterIds(localMeters!);
                      });
                    }
                  } else if (state is GenerateBillError) {
                    CustomSnackbarWidget(
                      context: context,
                      title: state.error,
                      backgroundColor: AppColor.red,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is GenerateBillLoading) {
                    return const Center(child: AppLoader());
                  }
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Bill Date",
                                style:
                                    txt_13_600.copyWith(color: AppColor.black1),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CustomDatePicker(
                                format: 'DD',
                                initialDate: selectedDate,
                                isNonEditableFormat:
                                    widget.isReadOnly ?? false,
                                showCurrentDate: false,
                                hideFutureDates: false,
                                onDateSelected: (String date) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                },
                                minDate: DateTime(2023, 1, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColor.blueShade,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Monthly Maintenance",
                                style:
                                    txt_12_500.copyWith(color: AppColor.blue),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CustomNumberTextField(
                                controller: _maintenanceController,
                                context: context,
                                hintText: "Enter value",
                                fillColor: AppColor.white,
                                center: true,
                                isNonEditableFormat: widget.isReadOnly!,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (localMeters == null || localMeters!.isEmpty)
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 50),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "No Prepaid Meters Configured.\n",
                                      style: txt_14_400.copyWith(
                                          color: AppColor.black1),
                                    ),
                                    WidgetSpan(
                                      child: GestureDetector(
                                        onTap: widget.isAdmin!
                                            ? () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddPrepaidMeter(
                                                      apartmentId:
                                                          widget.apartmentId,
                                                      isOwner: false,
                                                      isAdmin: widget.isAdmin,
                                                      isLeftSelected: false,
                                                      isReadOnly: false,
                                                    ),
                                                  ),
                                                );
                                              }
                                            : () => showSnackbarForNonAdmins(
                                                context),
                                        child: Text(
                                          "CLICK HERE",
                                          style: txt_14_700.copyWith(
                                            color: AppColor.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: " to add a Prepaid Meter",
                                      style: txt_14_400.copyWith(
                                          color: AppColor.black1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: localMeters!.length,
                          itemBuilder: (context, index) {
                            final meter = localMeters![index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              elevation: 0,
                              color: AppColor.blueShade,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(
                                  meter.name ?? "Unnamed Meter",
                                  style:
                                      txt_12_500.copyWith(color: AppColor.blue),
                                ),
                                trailing: Checkbox(
                                  value: selectedMeterIds.contains(meter.id),
                                  activeColor: AppColor.blue,
                                  onChanged: widget.isReadOnly == true
                                      ? null
                                      : (bool? value) {
                                          setState(() {
                                            if (value == true) {
                                              selectedMeterIds.add(meter.id!);
                                            } else {
                                              selectedMeterIds
                                                  .remove(meter.id!);
                                            }
                                          });
                                        },
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: BlocConsumer<GenerateBillBloc, GenerateBillState>(
        listener: (context, state) {
          if (state is PostGenerateBillSuccess) {
            CustomSnackbarWidget(
              context: context,
              title: state.message,
              backgroundColor: AppColor.green,
            );
            Navigator.pop(context);
          } else if (state is PostGenerateBillFailure) {
            CustomSnackbarWidget(
              context: context,
              title: state.error,
              backgroundColor: AppColor.red,
            );
          }
        },
        builder: (context, state) {
          return Container(
            color: AppColor.white,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
              child: CustomizedButton(
                label: state is PostGenerateBillLoading
                    ? 'Saving...'
                    : 'Schedule Bill',
                style: txt_15_500.copyWith(color: AppColor.white),
                onPressed: state is PostGenerateBillLoading
                    ? () {}
                    : () => _generateBill(context),
                isReadOnly: widget.isReadOnly!,
              ),
            ),
          );
        },
      ),
    );
  }

  void _initializeSelectedMeterIds(List<dynamic> meters) {
    selectedMeterIds.clear();
    for (var meter in meters) {
      if (meter.isPrepaidMaintenance == true) {
        selectedMeterIds.add(meter.id!);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('dd').format(picked);
      });
    }
  }

  void _generateBill(BuildContext context) {
    if (_maintenanceController.text.isEmpty) {
      CustomSnackbarWidget(
        context: context,
        title: 'Please Enter Monthly Maintenance!!',
        backgroundColor: AppColor.orange,
      );
    } else if (widget.isReadOnly!) {
      showSnackbarForNonAdmins(context);
    } else {
      final payload = {
        "notifyOn": selectedDate,
        "cost": _maintenanceController.text,
        "apartmentId": widget.apartmentId,
        "prepaidId": selectedMeterIds,
      };
      context.read<GenerateBillBloc>().add(PostGenerateBillRequested(payload));
    }
  }
}
