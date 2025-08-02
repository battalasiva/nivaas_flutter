import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/core/validations/validations.dart';
import 'package:nivaas/screens/prepaid-meters/Add-Previous-MeterReading/AddPreviousMeterReading.dart';
import 'package:nivaas/screens/prepaid-meters/Add-prepaid_meter/bloc/add_prepaid_meter_bloc.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/TextInput.dart';
import 'package:nivaas/widgets/elements/TopSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';
import 'package:nivaas/widgets/elements/toggleButton.dart';

class AddPrepaidMeterPopup extends StatefulWidget {
  final bool? isEdit, isReadOnly;
  final String? meterName, costPerUnit, meterType;
  final int? apartmentId, id;
  final List<Map<String, dynamic>>? configRangeList;

  const AddPrepaidMeterPopup({
    super.key,
    this.isEdit,
    this.meterName,
    this.costPerUnit,
    this.apartmentId,
    this.meterType,
    this.configRangeList,
    this.id,
    this.isReadOnly,
  });
  @override
  State<AddPrepaidMeterPopup> createState() => _AddPrepaidMeterPopupState();
}

class _AddPrepaidMeterPopupState extends State<AddPrepaidMeterPopup> {
  bool isMeterReading = false;
  bool isRangeConfigured = false;
  late TextEditingController meterNameController, unitCostController;
  List<Map<String, dynamic>> ranges = [];
  List<Map<String, dynamic>> meterReadings = [];
  @override
  void initState() {
    super.initState();
    isMeterReading = (widget.meterType == 'METER_READING') ? true : false;
    meterNameController = TextEditingController(text: widget.meterName);
    unitCostController = TextEditingController(text: widget.costPerUnit ?? '');
    if (widget.configRangeList != null && widget.configRangeList!.isNotEmpty) {
      isRangeConfigured = true;
      ranges = widget.configRangeList!.map((config) {
        return {
          'id': config['id'],
          'minController': TextEditingController(
              text: config['startRange']?.toString() ?? ''),
          'maxController': TextEditingController(
              text: config['endRange']?.toString() ?? 'Any'),
          'costController': TextEditingController(
              text: config['costPerUnit']?.toString() ?? ''),
        };
      }).toList();
    }
  }

  @override
  void dispose() {
    meterNameController.dispose();
    unitCostController.dispose();
    for (var range in ranges) {
      range['minController'].dispose();
      range['maxController'].dispose();
      range['costController'].dispose();
    }
    super.dispose();
  }

  void initializeRanges(List<Map<String, dynamic>>? configRangeList) {
    if (configRangeList != null && configRangeList.isNotEmpty) {
      ranges = configRangeList.map((config) {
        return {
          'id': config['id'],
          'minController': TextEditingController(
            text: config['startRange']?.toString() ?? '',
          ),
          'maxController': TextEditingController(
            text: config['endRange']?.toString() ?? 'Any',
          ),
          'costController': TextEditingController(
            text: config['costPerUnit']?.toString() ?? '',
          ),
        };
      }).toList();
    }
  }

  void addNewRange() {
    if (widget.isReadOnly ?? false) {
      TopSnackbarWidget.showTopSnackbar(
        context: context,
        title: "Warning",
        message: "Admin's Only Have Access",
        backgroundColor: AppColor.orange,
      );
      return;
    }
    if (!RangeValidator.validateAllRanges(context, ranges)) {
      return;
    }

    setState(() {
      if (ranges.isNotEmpty) {
        String previousMin = ranges.last['minController'].text;
        int newMin = int.tryParse(previousMin) ?? 0;
        ranges.last['maxController'].text = '${newMin - 1}';
      }
      ranges.add({
        'minController': TextEditingController(text: ''),
        'maxController': TextEditingController(text: 'Any'),
        'costController': TextEditingController(),
      });
    });
  }

  void removeRange(int index) {
    setState(() {
      ranges[index]['minController'].dispose();
      ranges[index]['maxController'].dispose();
      ranges[index]['costController'].dispose();
      ranges.removeAt(index);
      if (index > 0 && index < ranges.length) {
        ranges[index - 1]['maxController'].text = 'Any';
      }
    });
  }

  List<Map<String, dynamic>> prepareRangesData() {
    return ranges.map((range) {
      final id = range.containsKey('id') ? range['id'] : null;
      return {
        if (id != null) 'id': id,
        "costPerUnit": double.tryParse(range['costController'].text) ?? 0.0,
        "startRange": double.tryParse(range['minController'].text) ?? 0.0,
        "endRange": range['maxController'].text == 'Any'
            ? null
            : double.tryParse(range['maxController'].text) ?? 0.0,
      };
    }).toList();
  }

  void handleSubmit() {
    final bloc = context.read<AddPrepaidMeterBloc>();
    final errorMessage = validatePrepaidMeterFields(
      isMeterReading: isMeterReading,
      isRangeConfigured: isRangeConfigured,
      meterNameController: meterNameController,
      unitCostController: unitCostController,
      meterReadings: meterReadings,
      prepareRangesData: prepareRangesData,
      isEdit: widget.isEdit!,
    );
    if (!RangeValidator.validateAllRanges(context, ranges)) {
      return;
    }

    if (errorMessage != null) {
      TopSnackbarWidget.showTopSnackbar(
        context: context,
        title: "Warning",
        message: errorMessage,
        backgroundColor: AppColor.orange,
      );
      return;
    }
    final addPrepaidmeterwithoutRangePayload = {
      "costPerUnit": unitCostController.text,
      "name": meterNameController.text,
      "apartmentId": widget.apartmentId,
      "meterType": isMeterReading ? '' : "CONSUMPTION_UNITS"
    };
    final addPrepaidmeterWithRange = {
      "name": meterNameController.text,
      "apartmentId": widget.apartmentId,
      "meterType": isMeterReading ? '' : "CONSUMPTION_UNITS",
      "meterRanges": prepareRangesData(),
    };
    final addPrepaidMeterReadingwithoutRange = {
      "name": meterNameController.text,
      "apartmentId": widget.apartmentId,
      "meterType": "METER_READING",
      "costPerUnit": unitCostController.text,
      "flatPreviousReadings": meterReadings,
    };
    final addPrepaidMeterReadingwithRange = {
      "name": meterNameController.text,
      "apartmentId": widget.apartmentId,
      "meterType": "METER_READING",
      "meterRanges": prepareRangesData(),
      "flatPreviousReadings": meterReadings,
    };
    final editPrepaidmeterwithoutRangePayload = {
      "id": widget.id,
      "costPerUnit": unitCostController.text,
      "name": meterNameController.text,
      "apartmentId": widget.apartmentId,
      // "meterType": "CONSUMPTION_UNITS",
    };
    final editPrepaidmeterWithRange = {
      "id": widget.id,
      "name": meterNameController.text,
      "apartmentId": widget.apartmentId,
      "meterRanges": prepareRangesData(),
    };
    final editPrepaidMeterReadingwithoutRange = {
      "id": widget.id,
      "name": meterNameController.text,
      "apartmentId": widget.apartmentId,
      "costPerUnit": unitCostController.text,
      // "flatPreviousReadings": meterReadings,
      // "meterType": "METER_READING",
    };
    final editPrepaidMeterReadingwithRange = {
      "id": widget.id,
      "name": meterNameController.text,
      "apartmentId": widget.apartmentId,
      "meterRanges": prepareRangesData(),
      // "flatPreviousReadings": meterReadings,
    };
    if (widget.isEdit!) {
      if (isMeterReading) {
        bloc.add(EditPrepaidMeterData(isRangeConfigured
            ? editPrepaidMeterReadingwithRange
            : editPrepaidMeterReadingwithoutRange));
      } else {
        print('PAYLOAD : $editPrepaidmeterwithoutRangePayload');
        bloc.add(EditPrepaidMeterData(isRangeConfigured
            ? editPrepaidmeterWithRange
            : editPrepaidmeterwithoutRangePayload));
      }
    } else {
      if (isMeterReading) {
        bloc.add(SubmitPrepaidMeterData(isRangeConfigured
            ? addPrepaidMeterReadingwithRange
            : addPrepaidMeterReadingwithoutRange));
      } else {
        bloc.add(SubmitPrepaidMeterData(isRangeConfigured
            ? addPrepaidmeterWithRange
            : addPrepaidmeterwithoutRangePayload));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                (widget.isEdit ?? false)
                    ? 'View/Edit Prepaid Meter'
                    : 'Add Prepaid Meter',
                style: txt_14_600.copyWith(color: AppColor.black1),
              ),
            ),
            const SizedBox(height: 20),
            ToggleButtonWidget(
              leftTitle: "Meter Reading",
              rightTitle: "Consumption Units",
              isLeftSelected: isMeterReading,
              isReadOnly: widget.isReadOnly ?? false,
              onChange: (isLeft) {
                if (widget.isEdit!) {
                  TopSnackbarWidget.showTopSnackbar(
                    context: context,
                    title: "Warning",
                    message: "Meter Type couldn't modified",
                    backgroundColor: AppColor.orange,
                  );
                } else {
                  setState(() {
                    isMeterReading = isLeft;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Textwithstar(label: 'Meter Name '),
            TextInputWidget(
              controller: meterNameController,
              hint: 'Enter Meter Name...',
              readOnly: widget.isReadOnly ?? false,
            ),
            const SizedBox(height: 10),
            if (!isRangeConfigured) ...[
              Textwithstar(label: 'Cost Per Unit '),
              TextInputWidget(
                controller: unitCostController,
                hint: 'Enter Cost Per Unit...',
                decimalOnly: true,
                maxLength: 10,
                suffix: "/unit",
                readOnly: widget.isReadOnly ?? false,
              ),
              const SizedBox(height: 10),
            ],
            if (isMeterReading && !widget.isEdit!)
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.blueShade,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Previous Meter reading',
                      style: txt_14_700,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPreviousMeterReading(
                                apartmentId: widget.apartmentId),
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            meterReadings = result;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "Add",
                        style: TextStyle(color: AppColor.white),
                      ),
                    )
                  ],
                ),
              ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.blueShade,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Configure Range & Unit Cost',
                    style: txt_14_700,
                  ),
                  Switch(
                    value: isRangeConfigured,
                    onChanged: widget.isReadOnly ?? false
                        ? (value) {
                            TopSnackbarWidget.showTopSnackbar(
                              context: context,
                              title: "Warning",
                              message: "Admin's Only Have Access",
                              backgroundColor: AppColor.orange,
                            );
                          }
                        : (value) {
                            setState(() {
                              isRangeConfigured = value;
                            });
                          },
                    activeColor: AppColor.primaryColor2,
                  ),
                ],
              ),
            ),
            if (isRangeConfigured) ...[
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ranges.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.blueShade,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: getWidth(context) * 0.20,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextField(
                                  controller: ranges[index]['minController'],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: "Min Value",
                                    hintStyle: txt_11_500.copyWith(
                                        color: AppColor.black1),
                                    border: InputBorder.none,
                                  ),
                                  enableInteractiveSelection: false,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      if (index > 0 && value.isNotEmpty) {
                                        int newMin = int.tryParse(value) ?? 0;
                                        ranges[index - 1]['maxController']
                                            .text = '${newMin - 1}';
                                      }
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: getWidth(context) * 0.2,
                                child: Text(
                                  (double.tryParse(ranges[index]
                                                      ['maxController']
                                                  .text) ??
                                              0) >
                                          0
                                      ? ranges[index]['maxController'].text
                                      : 'Any',
                                  textAlign: TextAlign.center,
                                  style:
                                      txt_12_500.copyWith(color: AppColor.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: AppColor.greyBorder,
                              width: 1.0,
                            ),
                          ),
                          width: getWidth(context) * 0.4,
                          child: TextField(
                            controller: ranges[index]['costController'],
                            decoration: InputDecoration(
                              hintText: "Cost per unit",
                              hintStyle:
                                  txt_11_500.copyWith(color: AppColor.black1),
                              border: InputBorder.none,
                              suffix: Text(
                                "/unit  ",
                                style: TextStyle(color: AppColor.primaryColor2),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            enableInteractiveSelection: false,
                            inputFormatters: [
                              // FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}$')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(
                      color:widget.isReadOnly ?? false ? AppColor.greyBackground : AppColor.primaryColor2,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: addNewRange,
                    child: Text(
                      'Add New Range',
                      style: txt_13_600.copyWith(color: widget.isReadOnly ?? false ? AppColor.greyBorder : AppColor.primaryColor2),
                    ),
                  ),
                ),
              )
            ],
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: BlocConsumer<AddPrepaidMeterBloc, AddPrepaidMeterState>(
                listener: (context, state) {
                  if (state is AddPrepaidMeterSuccess) {
                    CustomSnackbarWidget(
                        context: context,
                        title: state.message,
                        backgroundColor: AppColor.blue);
                    Navigator.pop(context, true);
                  } else if (state is EditPrepaidMeterSuccess) {
                    CustomSnackbarWidget(
                        context: context,
                        title: state.message,
                        backgroundColor: AppColor.blue);
                    Navigator.pop(context, true);
                  } else if (state is AddPrepaidMeterFailure) {
                    CustomSnackbarWidget(
                        context: context,
                        title: state.error,
                        backgroundColor: AppColor.red);
                  }
                },
                builder: (context, state) {
                  final isLoading = state is AddPrepaidMeterLoading ||
                      state is EditPrepaidMeterLoading;
                  return CustomizedButton(
                    label: isLoading ? 'Saving...' : 'SAVE',
                    style: txt_15_500.copyWith(color: AppColor.white),
                    onPressed: (isLoading || widget.isReadOnly!)
                        ? () {
                            TopSnackbarWidget.showTopSnackbar(
                              context: context,
                              title: "Warning",
                              message: "Admin's Only Have Access",
                              backgroundColor: AppColor.orange,
                            );
                          }
                        : () => handleSubmit(),
                    isReadOnly: widget.isReadOnly ?? false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
