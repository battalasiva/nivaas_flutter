import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/widgets/elements/TopSnackbarWidget.dart';

String? validatePrepaidMeterFields({
  required bool isMeterReading,
  required bool isRangeConfigured,
  required TextEditingController meterNameController,
  required TextEditingController unitCostController,
  required List<dynamic> meterReadings,
  required List<dynamic> Function() prepareRangesData,
  required bool isEdit,
}) {
  if (meterNameController.text.isEmpty) {
    return "Meter Name is required.";
  }
  if (isMeterReading) {
    if (isRangeConfigured && prepareRangesData().isEmpty) {
      return "Meter ranges are required for this configuration.";
    } else if (!isRangeConfigured && unitCostController.text.isEmpty) {
      return "Unit cost is required.";
    } else if (meterReadings.isEmpty && !isEdit ) {
      return "Flat previous readings are required.";
    }
  } else {
    if (isRangeConfigured && prepareRangesData().isEmpty) {
      return "Meter ranges are required for this configuration.";
    } else if (!isRangeConfigured && unitCostController.text.isEmpty) {
      return "Unit cost is required.";
    }
  }

  final rangesData = prepareRangesData();
  if (rangesData.isNotEmpty) {
    final firstRange = rangesData[0];
    if (firstRange['costPerUnit'] == null || firstRange['costPerUnit'] <= 0) {
      return " Cost per unit must greater than 0.";
    }
  }

  return null;
}

class RangeValidator {
  static bool validateRange({
    required BuildContext context,
    required int index,
    required List<Map<String, dynamic>> ranges,
  }) {
    if (index == 0) return true;

    double? prevMin = double.tryParse(ranges[index - 1]['minController'].text);
    double? prevMax = double.tryParse(ranges[index - 1]['maxController'].text);
    double? prevCost = double.tryParse(ranges[index - 1]['costController'].text);

    double? currentMin = double.tryParse(ranges[index]['minController'].text);
    double? currentMax = double.tryParse(ranges[index]['maxController'].text);
    double? currentCost = double.tryParse(ranges[index]['costController'].text);

    // Validate if min and cost values exist
    if (prevMin == null || prevCost == null || currentMin == null || currentCost == null) {
      TopSnackbarWidget.showTopSnackbar(
        context: context,
        title: "Warning",
        message: "Please enter valid Ranges.",
        backgroundColor: AppColor.orange,
      );
      return false;
    }
    if (ranges.length > 1 && (ranges[0]['maxController'].text == null || ranges[0]['maxController'].text == '')) {
      TopSnackbarWidget.showTopSnackbar(
        context: context,
        title: "Warning",
        message: "Max Value must be entered for the first range when multiple ranges exist.",
        backgroundColor: AppColor.orange,
      );
      return false;
    }
    // Min Value must be greater than the previous Min
    if (currentMin <= prevMin) {
      TopSnackbarWidget.showTopSnackbar(
        context: context,
        title: "Warning",
        message: "Min Value must be greater than previous Min.",
        backgroundColor: AppColor.orange,
      );
      return false;
    }

    // Cost per Unit must be greater than the previous Cost
    // if (currentCost <= prevCost) {
    //   TopSnackbarWidget.showTopSnackbar(
    //     context: context,
    //     title: "Warning",
    //     message: "Cost per Unit must be greater than the previous Cost.",
    //     backgroundColor: AppColor.orange,
    //   );
    //   return false;
    // }

    // Ensure previous max values (except last one) are never null
    if (index < ranges.length - 1 && (prevMax == null || currentMax == null)) {
      TopSnackbarWidget.showTopSnackbar(
        context: context,
        title: "Warning",
        message: "Max Value must be entered for all ranges except the last one.",
        backgroundColor: AppColor.orange,
      );
      return false;
    }

    // Ensure min and max difference is greater than 1
    if (currentMax != null && (currentMax - currentMin) <= 1) {
      TopSnackbarWidget.showTopSnackbar(
        context: context,
        title: "Warning",
        message: "The difference between Min and Max must be greater than 1.",
        backgroundColor: AppColor.orange,
      );
      return false;
    }

    return true;
  }

  static bool validateAllRanges(BuildContext context, List<Map<String, dynamic>> ranges) {
    Set<String> seenRanges = {}; // Set to track unique (min, max) pairs

    for (int i = 0; i < ranges.length; i++) {
      double? min = double.tryParse(ranges[i]['minController'].text);
      double? max = double.tryParse(ranges[i]['maxController'].text);

      // Ensure duplicate min-max values are not entered
      if (min != null && max != null) {
        String rangeKey = "$min-$max";

        if (seenRanges.contains(rangeKey)) {
          TopSnackbarWidget.showTopSnackbar(
            context: context,
            title: "Warning",
            message: "Duplicate ranges found.",
            backgroundColor: AppColor.orange,
          );
          return false;
        }
        seenRanges.add(rangeKey);
      }

      if (!validateRange(context: context, index: i, ranges: ranges)) {
        return false;
      }
    }
    return true;
  }
}

String? validateGuestInviteFields({
  required String? selectedTime,
  required String? selectedHours,
  required String? endDate,
  required String? accessType,
}) {
  if (accessType == "ONCE") {
    if (selectedTime == null || selectedTime.isEmpty) {
      return "Please select a valid time";
    }
    if (selectedHours == null || selectedHours.isEmpty) {
      return "Please select valid hours";
    }
  } else if (accessType == "FREQUENTLY") {
    if (endDate == null || endDate.isEmpty) {
      return "Please select an end date";
    }
  }
  return null; // No validation errors
}


String? validateSplitData({
  required String splitterName,
  required String amount,
  required List<TextEditingController> percentageControllers,
}) {
  if (splitterName.isEmpty) {
    return "Please enter a splitter name.";
  }

  final double? parsedAmount = double.tryParse(amount);
  if (parsedAmount == null || parsedAmount <= 0) {
    return "Please enter a valid amount.";
  }

  for (int i = 0; i < percentageControllers.length; i++) {
    final text = percentageControllers[i].text;
    final value = double.tryParse(text);
    if (value == null || value <= 0) {
      return "Please enter valid split values for all flats.";
    }
  }

  return null; // all valid
}
