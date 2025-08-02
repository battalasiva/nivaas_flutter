import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/gate-management/preview/SelectedGuestsPreview.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/TextInput.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';

class AddManuallyTab extends StatefulWidget {
  final Map<String, Object?>? payload;
  const AddManuallyTab({super.key, this.payload});

  @override
  _AddManuallyTabState createState() => _AddManuallyTabState();
}

class _AddManuallyTabState extends State<AddManuallyTab> {
  final TextEditingController guestNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  List<Map<String, String>> guests = [];

  void _addGuest() {
    String name = guestNameController.text.trim();
    String mobile = mobileNumberController.text.trim();

    if (name.isEmpty || mobile.isEmpty) {
      CustomSnackbarWidget(
        context: context,
        title: 'Please Add or Select Contacts',
        backgroundColor: AppColor.red,
      );
      return;
    }

    setState(() {
      guests.add({"name": name, "number": mobile});
      guestNameController.clear();
      mobileNumberController.clear();
    });
  }

  void _removeGuest(int index) {
    setState(() {
      guests.removeAt(index);
    });
  }

  void _onNext() {
    if (guests.isEmpty) {
      CustomSnackbarWidget(
        context: context,
        title: 'Please add at least one guest.',
        backgroundColor: AppColor.red,
      );
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectedGuestsPreview(
              selectedContacts: guests, payload: widget.payload),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: EdgeInsets.all(getWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Textwithstar(label: 'Guest Name '),
            const SizedBox(height: 5),
            TextInputWidget(
              controller: guestNameController,
              keyboardType: TextInputType.text,
              hint: 'Enter Guest Name...',
            ),
            const SizedBox(height: 10),
            Textwithstar(label: 'Mobile Number '),
            const SizedBox(height: 5),
            TextInputWidget(
                controller: mobileNumberController,
                keyboardType: TextInputType.number,
                hint: 'Enter Mobile Number...',
                maxLength: 10,
                digitsOnly: true),
            const SizedBox(height: 20),

            // Add Guest Button
            Container(
              color: AppColor.white,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomizedButton(
                  label: 'Add Guest',
                  style: txt_15_500.copyWith(color: AppColor.white),
                  onPressed: _addGuest,
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Sheet with Selected Guests and Next Button
      bottomSheet: Container(
        color: AppColor.white,
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (guests.isNotEmpty) ...[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: guests.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> guest = entry.value;
                  return Chip(
                    label: Text(guest["name"]!),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () => _removeGuest(index),
                    backgroundColor: AppColor.blueShade,
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
            ],
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomizedButton(
                label: 'Next',
                style: txt_14_500.copyWith(color: AppColor.white),
                onPressed: _onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
