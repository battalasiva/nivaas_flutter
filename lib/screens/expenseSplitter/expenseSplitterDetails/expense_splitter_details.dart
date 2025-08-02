import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/expenseSplitter/expense_splitters_list_model.dart';
import 'package:nivaas/screens/expenseSplitter/expenseSplitterDetails/EditSplitterBetweenFlatsScreen.dart';
import 'package:nivaas/widgets/elements/TextInput.dart';
import 'package:nivaas/widgets/elements/TopSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/toggleButton.dart';

class ExpenseSplitterDetailsPopup extends StatefulWidget {
  final ExpenseSplittersListModel details;
  final bool? isAdmin;
  const ExpenseSplitterDetailsPopup(
      {super.key, required this.details, this.isAdmin = true});

  @override
  State<ExpenseSplitterDetailsPopup> createState() =>
      _ExpenseSplitterDetailsPopupState();
}

class _ExpenseSplitterDetailsPopupState
    extends State<ExpenseSplitterDetailsPopup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool isLeftSelected = true;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.details.name;
    amountController.text = "${widget.details.amount}";
    isLeftSelected = widget.details.splitSchedule == "ONCE" ? true : false;
  }

  void _onToggleChanged(bool isLeft) {
    setState(() => isLeftSelected = isLeft);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ToggleButtonWidget(
                                leftTitle: 'Split Once',
                                rightTitle: 'Split Monthly',
                                isLeftSelected: isLeftSelected,
                                onChange: _onToggleChanged,
                              ),
                              const SizedBox(height: 20),
                              TextInputWidget(
                                label: 'Name',
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                hint: 'Enter Name...',
                                readOnly: !widget.isAdmin!,
                              ),
                              const SizedBox(height: 10),
                              TextInputWidget(
                                label: 'Amount',
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                hint: 'Enter Amount...',
                                readOnly: !widget.isAdmin!,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomizedButton(
                          label: "Edit Split between Flats",
                          onPressed: () {
                            widget.isAdmin ?? true
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SplitterFlatsEditScreen(
                                        details: widget.details,
                                        nameController: nameController,
                                        amountController: amountController,
                                        splitSchedule:
                                            isLeftSelected ? "ONCE" : "MONTHLY",
                                      ),
                                    ),
                                  )
                                : TopSnackbarWidget.showTopSnackbar(
                                    context: context,
                                    title: "Warning",
                                    message: "Admin's Only Have Access",
                                    backgroundColor: AppColor.orange,
                                  );
                          },
                          isReadOnly: !widget.isAdmin!,
                          style: txt_14_400.copyWith(color: AppColor.white1),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
