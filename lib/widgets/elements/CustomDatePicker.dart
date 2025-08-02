import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart'; 
class CustomDatePicker extends StatefulWidget {
  final String format;
  final bool showCurrentDate;
  final bool hideFutureDates;
  final bool hidePastDates;
  final bool showYearMonth;
  final DateTime? minDate;
  final DateTime? maxDate;
  final Function(String) onDateSelected;
  final String? initialDate;
  final bool isNonEditableFormat; 

  const CustomDatePicker({
    Key? key,
    required this.onDateSelected,
    this.format = 'YYYY-MM-DD',
    this.showCurrentDate = false,
    this.hideFutureDates = false,
    this.hidePastDates = false,
    this.showYearMonth = false,
    this.minDate,
    this.maxDate,
    this.initialDate,
    this.isNonEditableFormat = false, // ✅ Default to false
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null && widget.initialDate!.isNotEmpty) {
      selectedDate = widget.initialDate!;
    } else if (widget.showCurrentDate) {
      final now = DateTime.now();
      selectedDate = _formatDate(now);
      widget.onDateSelected(selectedDate!);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    if (widget.isNonEditableFormat) {
      showSnackbarForNonAdmins(context);
      return;
    }

    final now = DateTime.now();
    final DateTime firstDate = widget.hidePastDates ? now : (widget.minDate ?? DateTime(2023, 1, 1));
    final DateTime lastDate = widget.hideFutureDates ? now : (widget.maxDate ?? DateTime(2100, 1, 1));

    if (widget.showYearMonth) {
      final DateTime? picked = await showMonthYearPicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate,
      );

      if (picked != null) {
        setState(() {
          selectedDate = _formatDate(picked);
          widget.onDateSelected(selectedDate!);
        });
      }
    } else {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate,
      );

      if (picked != null) {
        setState(() {
          selectedDate = _formatDate(picked);
          widget.onDateSelected(selectedDate!);
        });
      }
    }
  }

  String _formatDate(DateTime date) {
    if (widget.showYearMonth) {
      return DateFormat('yyyy-MM').format(date);
    }
    switch (widget.format) {
      case 'DD':
        return DateFormat('dd').format(date);
      case 'DD-MM':
        return DateFormat('dd-MM').format(date);
      case 'YYYY-MM':
        return DateFormat('yyyy-MM').format(date);
      case 'MM-DD':
        return DateFormat('MM-dd').format(date);
      case 'YYYY-MM-DD':
        return DateFormat('yyyy-MM-dd').format(date);
      default:
        return DateFormat('dd MMM yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColor.blueShade.withOpacity(widget.isNonEditableFormat ? 0.5 : 1), // Optional: dim when non-editable
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            selectedDate ?? "Pick Date",
            style: txt_14_500.copyWith(
              color: widget.isNonEditableFormat ? Colors.grey : AppColor.black1,
            ),
          ),
        ),
      ),
    );
  }
}


/// Custom function to show Month-Year Picker
Future<DateTime?> showMonthYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  DateTime? selectedDate = initialDate;

  return showDialog<DateTime>(
    context: context,
    builder: (context) {
      int selectedYear = initialDate.year;
      int selectedMonth = initialDate.month;

      return AlertDialog(
        title: Text("Select Month & Year"),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Year Picker
            DropdownButton<int>(
              value: selectedYear,
              items: List.generate(
                (DateTime.now().year >= 2024)
                    ? DateTime.now().year - 2024 + 1
                    : 1,
                (index) => 2024 + index,
              ).map((year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text(year.toString()),
                );
              }).toList(),
              onChanged: (year) {
                if (year != null) {
                  selectedYear = year;
                }
              },
            ),

            DropdownButton<int>(
              value: selectedMonth,
              items: List.generate(12, (index) => index + 1).map((month) {
                return DropdownMenuItem(
                  value: month,
                  child: Text(DateFormat.MMMM().format(DateTime(0, month))),
                );
              }).toList(),
              onChanged: (month) {
                if (month != null) {
                  selectedMonth = month;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, DateTime(selectedYear, selectedMonth, 1));
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}
