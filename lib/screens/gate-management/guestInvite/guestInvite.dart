import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/enums.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/core/validations/validations.dart';
import 'package:nivaas/screens/gate-management/Guest_management_helper.dart';
import 'package:nivaas/screens/gate-management/Notification-popup/Notification_popup.dart';
import 'package:nivaas/screens/gate-management/SelectGuestsTabBar-Screen/SelectGuestsTabBarScreen.dart';
import 'package:nivaas/widgets/elements/CustomDatePicker.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/CustomTimePicker.dart';
import 'package:nivaas/widgets/elements/build_dropdownfield.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/toggleButton.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class GuestInvite extends StatefulWidget {
  final int? apartmentId, flatId;
  const GuestInvite({super.key, this.apartmentId, this.flatId});

  @override
  State<GuestInvite> createState() => _GuestInviteState();
}

class _GuestInviteState extends State<GuestInvite> {
  bool showOption = false;
  String selectedOptionValue = 'ONCE';
  String selectedCategory = 'Guest';
  String selectedCategoryValue = 'GUEST';
  String? selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? selectedTime;
  String? selectedHours;
  String? endDate;
  String? selectedFrequency;
  final List<String> frequencyOptions = ["1 Week", "1 Month"];
  final TextEditingController typeController = TextEditingController();

  final List<Map<String, String>> complaintStatusTypes = List.generate(
    12,
    (index) => {'name': '${index + 1} Hours'},
  );

  void updateCategory(String label) {
    final selectedItem =
        gateManagementServices.firstWhere((item) => item['name'] == label);
    setState(() {
      selectedCategory = label;
      selectedCategoryValue = selectedItem['value'];
    });
  }

  void navigateToSelectedGuestScreen() {
    String? validationError = validateGuestInviteFields(
      selectedTime: selectedTime,
      selectedHours: selectedHours,
      endDate: endDate,
      accessType: selectedOptionValue,
    );

    if (validationError != null) {
      CustomSnackbarWidget(
        context: context,
        title: validationError,
        backgroundColor: AppColor.red,
      );
      return;
    }

    var payload = {
      "apartmentId": widget.apartmentId,
      "flatId": widget.flatId,
      // "status": "APPROVED",
      "type": selectedCategoryValue,
      "accessType": selectedOptionValue,
      "startDate": selectedDate,
      "enddate": endDate,
      "startTime": selectedTime,
      "hours": selectedHours?.split(' ')[0],
    };
    print('PAYLOAD : $payload');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectGuestsTabBarScreen(
          payload: payload,
          apartmentId: widget.apartmentId!,
          flatId: widget.flatId!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Gate Management'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(getWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: gateManagementServices.map((category) {
                return buildCategoryButton(
                  label: category['name'],
                  assetName: category['icon'],
                  selectedCategory: selectedCategory,
                  onCategorySelected: updateCategory,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ToggleButtonWidget(
              leftTitle: "Allow Once",
              rightTitle: "Frequently Invite",
              isLeftSelected: !showOption,
              onChange: (isLeft) => setState(() {
                showOption = !isLeft;
                selectedOptionValue = showOption ? 'FREQUENTLY' : 'ONCE';
              }),
            ),
            const SizedBox(height: 16),
            if (!showOption) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Date :',
                    style: txt_15_500.copyWith(color: AppColor.black2),
                  ),
                  CustomDatePicker(
                    initialDate: selectedDate,
                    hidePastDates: true,
                    format: "YYYY-MM-DD",
                    onDateSelected: (selectedDate) {
                      this.selectedDate = selectedDate;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Starting From',
                            style: txt_15_500.copyWith(color: AppColor.black2)),
                        const SizedBox(height: 10),
                        Customtimepicker(
                          is24HourFormat: true,
                          onTimeSelected: (String time) {
                            setState(() {
                              selectedTime = time;
                              print('TIME : $selectedTime');
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Valid For',
                            style: txt_15_500.copyWith(color: AppColor.black2)),
                        const SizedBox(height: 10),
                        BuildDropDownField(
                          label: 'Select',
                          useBlueShadeBackground: true,
                          items: complaintStatusTypes
                              .map((status) => status['name'] ?? "")
                              .toList(),
                          onChanged: (String? hours) {
                            setState(() {
                              selectedHours = hours;
                            });
                          },
                          value: selectedHours,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a duration';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ] else ...[
              Text("Allow Entry For Next",
                  style: txt_15_500.copyWith(color: AppColor.black2)),
              const SizedBox(height: 10),
              Row(
                children: frequencyOptions.map((option) {
                  bool isSelected = selectedFrequency == option;
                  return Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFrequency = option;
                          _calculateEndDate();
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.primaryColor1
                              : AppColor.blueShade,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(option,
                            style: txt_14_500.copyWith(
                                color: isSelected
                                    ? AppColor.white
                                    : AppColor.black1)),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Date :',
                              style:
                                  txt_15_500.copyWith(color: AppColor.black2),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: AppColor.blueShade,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: CustomDatePicker(
                                  initialDate: selectedDate,
                                  hidePastDates: true,
                                  minDate: DateTime.now(),
                                  onDateSelected: (date) {
                                    setState(() {
                                      selectedDate = date;
                                      _calculateEndDate();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Date :',
                              style:
                                  txt_15_500.copyWith(color: AppColor.black2),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 50,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: AppColor.blueShade,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  endDate ?? "--",
                                  style: txt_15_500.copyWith(
                                      color: AppColor.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
      bottomSheet: Container(
        color: AppColor.white,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CustomizedButton(
              label: 'Select Guest',
              isReadOnly: widget.flatId != null ? false : true,
              style: txt_14_500.copyWith(color: AppColor.white),
              onPressed: (widget.flatId != null)
                  ? navigateToSelectedGuestScreen
                  : () {
                      CustomSnackbarWidget(
                        context: context,
                        title: "You Don't Have Any Flat",
                        backgroundColor: AppColor.red,
                      );
                    }),
        ),
      ),
    );
  }

  void _calculateEndDate() {
    if (selectedDate != null && selectedFrequency != null) {
      DateTime start = DateFormat("yyy-MM-dd").parse(selectedDate!);
      DateTime calculatedEndDate;
      if (selectedFrequency == "1 Week") {
        calculatedEndDate = start.add(Duration(days: 7));
      } else if (selectedFrequency == "1 Month") {
        calculatedEndDate = DateTime(start.year, start.month + 1, start.day);
      } else {
        return;
      }
      setState(() {
        endDate = DateFormat("yyy-MM-dd").format(calculatedEndDate);
      });
    }
  }
}
