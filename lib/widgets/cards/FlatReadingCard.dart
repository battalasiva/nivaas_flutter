import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';

class FlatReadingCard extends StatefulWidget {
  final String flatNumber;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final bool? isReadOnly;

  const FlatReadingCard({
    Key? key,
    required this.flatNumber,
    required this.initialValue,
    required this.onChanged,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<FlatReadingCard> createState() => _FlatReadingCardState();
}

class _FlatReadingCardState extends State<FlatReadingCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      color: AppColor.blueShade,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.flatNumber,
                style: txt_14_400.copyWith(color: AppColor.blue),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10, top: 3, bottom: 3),
                child: TextField(
                  keyboardType: TextInputType.number,
                  readOnly: widget.isReadOnly ?? false,
                  enabled: !widget.isReadOnly!, 
                  controller: _controller,
                  onChanged: widget.onChanged,
                  style: const TextStyle(fontSize: 14),
                  onTap: () {
                    _controller.clear();
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    hintText: 'Enter a value',
                    hintStyle: const TextStyle(fontSize: 14),
                    filled: true,
                    fillColor: AppColor.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  enableInteractiveSelection: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
