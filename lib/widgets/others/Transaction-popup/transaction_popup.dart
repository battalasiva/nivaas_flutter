import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nivaas/core/constants/enums.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/CustomDatePicker.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/TextInput.dart';
import 'package:nivaas/widgets/elements/TopSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/build_dropdownfield.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';
import 'package:nivaas/widgets/others/Transaction-popup/bloc/transaction_popup_bloc.dart';

class TransactionPopup extends StatefulWidget {
  final String requestType;
  final int apartmentId;
  final Function onTransactionCompleted;
  final String transactionDate;
  final String transactionDescription;
  final String transactionAmount;
  final String transactionType;
  final String transactionCategory;
  final int transactionId;
  const TransactionPopup({
    Key? key,
    required this.requestType,
    required this.apartmentId,
    required this.onTransactionCompleted,
    required this.transactionDate,
    required this.transactionDescription,
    required this.transactionAmount,
    required this.transactionType,
    required this.transactionCategory,
    required this.transactionId,
  }) : super(key: key);
  @override
  _TransactionPopupState createState() => _TransactionPopupState();
}

class _TransactionPopupState extends State<TransactionPopup> {
  late String selectedStatus;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  String? selectedDate, buttonLabel;
  @override
  void initState() {
    super.initState();
    selectedStatus = widget.transactionCategory;
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (widget.requestType == 'EDIT_CREDIT' ||
        widget.requestType == 'EDIT_DEBIT') {
      _populateFields(widget.transactionAmount, widget.transactionDate,
          widget.transactionDescription, widget.transactionCategory);
    }
  }

  void _populateFields(transactionAmount, transactionDate,
      transactionDescription, transactionCategory) {
    selectedDate = formatDate(transactionDate,forPayload: true);
    _descriptionController.text = transactionDescription;
    _amountController.text = transactionAmount;
    _typeController.text = transactionCategory;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  void submitTransaction(BuildContext context) {
    if (selectedDate == null ||
        _descriptionController.text.isEmpty ||
        _amountController.text.isEmpty ||
        ((widget.requestType == 'EDIT_CREDIT' ||
                widget.requestType == 'CREDIT_ADD')
            ? _typeController.text.isEmpty
            : selectedStatus.isEmpty)) {
      TopSnackbarWidget.showTopSnackbar(
        context: context,
        title: "Warning",
        message: "Please fill All Required Fields",
        backgroundColor: AppColor.orange,
      );
      return;
    }

    final payload = {
      "transactionDate": selectedDate,
      "description": _descriptionController.text,
      "amount": _amountController.text,
      "apartmentId": widget.apartmentId,
      (widget.requestType == 'CREDIT_ADD' ||
              widget.requestType == 'EDIT_CREDIT')
          ? "creditType"
          : "type": widget.requestType == 'CREDIT_ADD' ||
              widget.requestType == 'EDIT_CREDIT'
          ? _typeController.text
          : selectedStatus,
    };
    print('PAYLOAD : ${payload}');
    switch (widget.requestType) {
      case 'CREDIT_ADD':
        context
            .read<TransactionPopupBloc>()
            .add(AddCreditMaintainanceEvent(payload: payload));
        break;
      case 'DEBIT_ADD':
        context.read<TransactionPopupBloc>().add(AddDebitMaintainanceEvent(
              apartmentId: widget.apartmentId,
              amount: _amountController.text,
              description: _descriptionController.text,
              transactionDate: selectedDate!,
              type: selectedStatus,
            ));
        break;

      case 'EDIT_CREDIT':
        context
            .read<TransactionPopupBloc>()
            .add(EditCreditMaintainanceRequested(
              itemId: widget.transactionId,
              payload: payload,
            ));
        break;
      case 'EDIT_DEBIT':
        context.read<TransactionPopupBloc>().add(EditDebitMaintainanceRequested(
              itemId: widget.transactionId,
              payload: payload,
            ));
        break;
    }
  }

  void _removeTransaction() {
    final removeType =
        widget.requestType == 'EDIT_DEBIT' ? 'remove_debit' : 'remove_credit';
    if (removeType == 'remove_credit') {
      context.read<TransactionPopupBloc>().add(DeleteCreditHistoryRequested(
          itemId: widget.transactionId, apartmentId: widget.apartmentId));
    } else {
      context.read<TransactionPopupBloc>().add(DeleteDebitHistoryRequested(
          itemId: widget.transactionId, apartmentId: widget.apartmentId));
    }
    // Future.delayed(const Duration(milliseconds: 200), () {
    //   widget.onTransactionCompleted();
    //   Navigator.of(context).pop();
    // });
  }

  @override
  Widget build(BuildContext context) {
    String heading;
    String buttonLabel;

    switch (widget.requestType) {
      case 'CREDIT_ADD':
        heading = 'Add Credit';
        buttonLabel = 'Add Credit';
        break;
      case 'DEBIT_ADD':
        heading = 'Add Debit';
        buttonLabel = 'Add Debit';
        break;
      case 'EDIT_CREDIT':
        heading = 'Edit Credit';
        buttonLabel = 'Update Credit';
        break;
      case 'EDIT_DEBIT':
        heading = 'Edit Debit';
        buttonLabel = 'Update Debit';
        break;
      default:
        heading = '';
        buttonLabel = '';
    }

    final isCredit = widget.requestType == 'CREDIT_ADD' ||
        widget.requestType == 'EDIT_CREDIT';
    final isEdit = widget.requestType == 'EDIT_CREDIT' ||
        widget.requestType == 'EDIT_DEBIT';
    var removeButtonLabel =
        widget.requestType == 'EDIT_DEBIT' ? 'Remove Debit' : 'Remove Credit';

    return Builder(
        builder: (popupContext) => Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        heading,
                        style: txt_18_700.copyWith(color: AppColor.black2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                          style: txt_14_700.copyWith(color: AppColor.black2),
                        ),
                        CustomDatePicker(
                          initialDate: selectedDate,
                          hideFutureDates: true,
                          onDateSelected: (selectedDate) {
                            this.selectedDate = selectedDate;
                          },
                          minDate: DateTime(2023, 1, 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (!isCredit) ...[
                      Textwithstar(label: 'Select Type'),
                      const SizedBox(height: 5),
                      BuildDropDownField(
                        label: 'Select',
                        items: MaintenanceTypes.map(
                          (status) => status['name'] ?? "",
                        ).toList(),
                        onChanged: (String? statusSelected) {
                          setState(() {
                            selectedStatus = statusSelected!;
                          });
                        },
                        value: selectedStatus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a status';
                          }
                          return null;
                        },
                      ),
                    ] else ...[
                      Textwithstar(label: 'Type'),
                      TextInputWidget(
                        controller: _typeController,
                        keyboardType: TextInputType.text,
                        hint: 'Enter Type...',
                        validator: (value) => value == null || value == ''
                            ? 'Type is required'
                            : null,
                      ),
                    ],
                    const SizedBox(height: 16),
                    Textwithstar(label: 'Description'),
                    TextInputWidget(
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      hint: 'Enter Description...',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Description is required'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Textwithstar(label: 'Amount'),
                    TextInputWidget(
                      controller: _amountController,
                      digitsOnly: true,
                      keyboardType: TextInputType.number,
                      hint: 'Enter Amount...',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Amount is required'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    BlocConsumer<TransactionPopupBloc, TransactionPopupState>(
                      listener: (context, state) {
                        if (state is EditDebitMaintainanceSuccess ||
                            state is EditCreditMaintainanceSuccess ||
                            state is AddDebitMaintainanceLoaded ||
                            state is AddCreditMaintainanceLoaded ||
                            state is AddDebitMaintainanceError ||
                            state is AddCreditMaintainanceError) {
                          CustomSnackbarWidget(
                              context: context,
                              title: 'Transaction Successful',
                              backgroundColor: AppColor.green);
                          widget.onTransactionCompleted();
                          Navigator.pop(context);
                        } else if (state is EditDebitMaintainanceFailures) {
                          CustomSnackbarWidget(
                              context: context,
                              title: state.error,
                              backgroundColor: AppColor.red);
                        }
                      },
                      builder: (context, state) {
                        print('STATE : $state');
                        if (state is EditDebitMaintainanceLoading ||
                            state is EditCreditMaintainanceLoading ||
                            state is AddDebitMaintainanceLoading ||
                            state is AddCreditMaintainanceLoading) {
                          buttonLabel = 'Saving...';
                        } else {
                          buttonLabel = 'Save';
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: CustomizedButton(
                            label: buttonLabel,
                            style: txt_15_500.copyWith(color: AppColor.white),
                            onPressed: state is AddDebitMaintainanceLoading ||
                                    state is AddCreditMaintainanceLoading ||
                                    state is EditDebitMaintainanceLoading ||
                                    state is EditCreditMaintainanceLoading
                                ? () {}
                                : () => submitTransaction(popupContext),
                          ),
                        );
                      },
                    ),
                    if (isEdit)
                      BlocConsumer<TransactionPopupBloc, TransactionPopupState>(
                        listener: (context, state) {
                          if (
                            state is DeleteCreditHistorySuccess ||
                            state is DeleteDebitHistorySuccess) {
                          CustomSnackbarWidget(
                              context: context,
                              title: 'Deleted Successfully',
                              backgroundColor: AppColor.green);
                          widget.onTransactionCompleted();
                          Navigator.pop(context);
                        } else if (state is EditDebitMaintainanceFailures) {
                          CustomSnackbarWidget(
                              context: context,
                              title: state.error,
                              backgroundColor: AppColor.red);
                        }
                        },
                        builder: (context, state) {
                          if (state is DeleteDebitHistoryLoading ||
                              state is DeleteCreditHistoryLoading) {
                            removeButtonLabel = 'Removing...';
                          }
                          return Center(
                            child: TextButton(
                              onPressed: _removeTransaction,
                              child: Text(
                                removeButtonLabel,
                                style: txt_14_700.copyWith(
                                    color: AppColor.red),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ));
  }
}
