import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';

class Customtimepicker extends StatefulWidget {
  final TimeOfDay? initialTime;
  final ValueChanged<String> onTimeSelected;
  final bool is24HourFormat; // New parameter to control 24-hour format

  const Customtimepicker({
    Key? key,
    this.initialTime,
    required this.onTimeSelected,
    this.is24HourFormat = false, // Default is false (12-hour format)
  }) : super(key: key);

  @override
  _CustomtimepickerState createState() => _CustomtimepickerState();
}

class _CustomtimepickerState extends State<Customtimepicker> {
  TimeOfDay? _selectedTime;

  void _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: widget.initialTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });

      String formattedTime;
      if (widget.is24HourFormat) {
        // Convert to 24-hour format manually
        formattedTime =
            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
      } else {
        formattedTime = _formatTime12Hour(pickedTime);
      }

      widget.onTimeSelected(formattedTime);
    }
  }

  String _formatTime12Hour(TimeOfDay time) {
    final int hour = time.hourOfPeriod;
    final String period = time.period == DayPeriod.am ? "AM" : "PM";
    return "${hour == 0 ? 12 : hour}:${time.minute.toString().padLeft(2, '0')} $period";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColor.blueShade,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: Text(
            _selectedTime != null
                ? (widget.is24HourFormat
                    ? "${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}"
                    : _formatTime12Hour(_selectedTime!))
                : "Select Time",
            style: txt_13_500.copyWith(color: AppColor.black1),
          ),
        ),
      ),
    );
  }
}
