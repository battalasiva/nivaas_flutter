import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/prepaid-meters/add-MeterReadings/bloc/add_meter_readings_bloc.dart';
import 'package:nivaas/widgets/cards/FlatPrevReadingCard.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomNumberTextField.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class AddMeterReadings extends StatefulWidget {
  final String? flatNumber, type, prepaidMeterName;
  final String? flatId;
  final int? apartmentId, prepaidMeterId;
  final bool? isReadOnly;

  const AddMeterReadings({
    super.key,
    this.flatNumber,
    this.flatId,
    this.apartmentId,
    this.prepaidMeterId,
    this.type,
    this.prepaidMeterName,
    this.isReadOnly,
  });

  @override
  State<AddMeterReadings> createState() => _AddMeterReadingsState();
}

class _AddMeterReadingsState extends State<AddMeterReadings> {
  final Map<String, TextEditingController> _controllers = {};
  final List<Map<String, dynamic>> formattedReadings = [];
  final TextEditingController _singleFlatController = TextEditingController();
  bool _isPreviousReadingEditable = false;
  final TextEditingController _previousReadingController =
      TextEditingController();
  List<dynamic> readings = [];
  Map<String, dynamic> singleMeterReadings = {};
  bool hasBeenEdited = false;
  @override
  void initState() {
    super.initState();
    _previousReadingController.text = '0';
    if (widget.type == "MULTI_FLAT_READING") {
      context.read<AddMeterReadingsBloc>().add(FetchMeterReadingsEvent(
            apartmentId: widget.apartmentId!,
            prepaidMeterId: widget.prepaidMeterId!,
          ));
    } else if (widget.type == "SINGLE_FLAT_READING") {
      context.read<AddMeterReadingsBloc>().add(FetchSingleMeterReadings(
            apartmentId: widget.apartmentId!,
            prepaidMeterId: widget.prepaidMeterId!,
            flatId: int.parse(widget.flatId!),
          ));
    }
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    _singleFlatController.dispose();
    super.dispose();
  }

  void _updateFormattedReadings() {
    formattedReadings.clear();
    if (widget.type == "MULTI_FLAT_READING") {
      _controllers.forEach((flatId, controller) {
        final readingValue = double.tryParse(controller.text) ?? 0.0;
        formattedReadings
            .add({"readingValue": readingValue, "flatId": int.parse(flatId)});
      });
    } else if (widget.type == "SINGLE_FLAT_READING") {
      final readingValue = double.tryParse(_singleFlatController.text) ?? 0.0;
      if (_isPreviousReadingEditable) {
        formattedReadings.add({
          "readingValue": readingValue,
          "previousReading": _previousReadingController.text,
          "flatId": int.parse(widget.flatId!)
        });
      } else {
        formattedReadings.add({
          "readingValue": readingValue,
          "flatId": int.parse(widget.flatId!)
        });
      }
    }
  }

  void _enablePreviousReadingEdit() {
    setState(() {
      _isPreviousReadingEditable = true;
    });
  }

  void _submitReadings() {
    _updateFormattedReadings();
    final payload = {
      "prepaidId": widget.prepaidMeterId,
      "apartmentId": widget.apartmentId,
      "flatReading": formattedReadings,
    };
    if (widget.type == "SINGLE_FLAT_READING") {
      if (_isPreviousReadingEditable && _previousReadingController.text.isNotEmpty) {
        (formattedReadings.isNotEmpty &&
                double.tryParse(
                        formattedReadings[0]['readingValue'].toString())! >
                    double.tryParse(
                        formattedReadings[0]['previousReading'].toString())!)
            ? context
                .read<AddMeterReadingsBloc>()
                .add(SubmitMeterReadingEvent(payload: payload))
            : CustomSnackbarWidget(
                context: context,
                title: 'Current reading must greater than previous reading!!',
                backgroundColor: AppColor.red,
              );
      } else {
        (singleMeterReadings['readingValue'] < formattedReadings[0]['readingValue']) ? 
          context
              .read<AddMeterReadingsBloc>()
              .add(SubmitMeterReadingEvent(payload: payload)) : CustomSnackbarWidget(
                context: context,
                title: 'Current reading must greater than previous reading!!',
                backgroundColor: AppColor.red,
              );
      }
    } else {
      hasBeenEdited
          ? context
              .read<AddMeterReadingsBloc>()
              .add(SubmitMeterReadingEvent(payload: payload))
          : CustomSnackbarWidget(
              context: context,
              title: 'Current reading must greater than previous reading!',
              backgroundColor: AppColor.red,
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('READINGS : $formattedReadings');
    return Scaffold(
      appBar: TopBar(title: '${widget.prepaidMeterName} Reading'),
      backgroundColor: AppColor.white,
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.type == "MULTI_FLAT_READING"
              ? BlocConsumer<AddMeterReadingsBloc, AddMeterReadingsState>(
                  listener: (context, state) {
                    if (state is GetMeterReadingsError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is GetMeterReadingsLoading) {
                      return const Center(child: AppLoader());
                    } else if (state is GetMeterReadingsLoaded) {
                      readings = state.readings;
                    } else if (state is GetMeterReadingsError) {
                      return Center(child: Text(state.message));
                    }
                    if (readings.isEmpty) {
                      return const Center(child: Text('No data available.'));
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Flats Numbers',
                                  style: txt_14_600.copyWith(
                                      color: AppColor.black2),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Old Readings',
                                  style: txt_14_600.copyWith(
                                      color: AppColor.black2),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'New Readings',
                                  style: txt_14_600.copyWith(
                                      color: AppColor.black2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                                bottom: getHeight(context) * 0.1),
                            itemCount: readings.length,
                            itemBuilder: (context, index) {
                              final reading = readings[index];
                              final flatId = reading.flatId.toString();
                              if (!_controllers.containsKey(flatId)) {
                                _controllers[flatId] = TextEditingController(
                                  text: reading.readingValue?.toString() ?? '',
                                );
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0.0),
                                child: Flatprevreadingcard(
                                  flatNumber:
                                      reading.flatNumber ?? 'Unknown Flat',
                                  readingValue:
                                      reading.readingValue.toString(),
                                  previousReading: reading.previousReading.toString(),
                                  initialValue: _controllers[flatId]!.text,
                                  onChanged: (value) {
                                    _controllers[flatId]!.text = value;
                                    _updateFormattedReadings();
                                  },
                                  onValidation: (value) {
                                    hasBeenEdited = value;
                                  },
                                  isReadOnly: widget.isReadOnly ?? false,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                )
              : Column(
                  children: [
                    BlocConsumer<AddMeterReadingsBloc, AddMeterReadingsState>(
                      listener: (context, state) {
                        if (state is GetSingleMeterReadingsLoaded) {
                          singleMeterReadings = state.reading.toJson();
                        }
                      },
                      builder: (context, state) {
                        return BlocBuilder<AddMeterReadingsBloc,
                            AddMeterReadingsState>(
                          builder: (context, state) {
                            if (state is GetSingleMeterReadingsLoading) {
                              return const Center(child: AppLoader());
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Date :',
                                        style: txt_15_500.copyWith(
                                            color: AppColor.black2),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 6.0),
                                        decoration: BoxDecoration(
                                          color: AppColor.blueShade,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          formatDate(
                                              singleMeterReadings['date'] ??
                                                  'NA'),
                                          style: txt_14_600.copyWith(
                                              color: AppColor.black1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: AppColor.blueShade,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Flat Number',
                                              style: txt_12_500.copyWith(
                                                  color: AppColor.black2),
                                            ),
                                            Text(
                                              widget.flatNumber ?? "NA",
                                              style: txt_17_500.copyWith(
                                                  color: AppColor.blue),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Previous Meter Reading',
                                              style: txt_12_500.copyWith(
                                                  color: AppColor.black2),
                                            ),
                                            Row(
                                              children: [
                                                _isPreviousReadingEditable
                                                    ? SizedBox(
                                                        width: 100,
                                                        child:
                                                            CustomNumberTextField(
                                                          controller:
                                                              _previousReadingController,
                                                          context: context,
                                                          hintText:
                                                              "Enter previous value",
                                                          fillColor:
                                                              AppColor.white,
                                                          center: true,
                                                          decimalsOnly: true,
                                                        ),
                                                      )
                                                    : Text(
                                                        singleMeterReadings[
                                                                    'readingValue']
                                                                ?.toString() ??
                                                            "NA",
                                                        style:
                                                            txt_17_500.copyWith(
                                                                color: AppColor
                                                                    .blue),
                                                      ),
                                                if (!_isPreviousReadingEditable &&
                                                    (singleMeterReadings['readingValue'] == 0 || singleMeterReadings['readingValue'] == null))
                                                  GestureDetector(
                                                    onTap:
                                                        _enablePreviousReadingEdit,
                                                    child: Icon(Icons.edit,
                                                        color: AppColor.blue,
                                                        size: 18),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // **Current Reading Section**
                                  Text(
                                    'Current Reading',
                                    style: txt_14_600.copyWith(
                                        color: AppColor.black1),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: AppColor.blueShade,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Current Meter Reading',
                                          style: txt_12_500.copyWith(
                                              color: AppColor.black2),
                                        ),
                                        const SizedBox(width: 40),
                                        Expanded(
                                          child: CustomNumberTextField(
                                            controller: _singleFlatController,
                                            context: context,
                                            hintText: "Enter value",
                                            fillColor: AppColor.white,
                                            center: true,
                                            decimalsOnly: true,
                                            isNonEditableFormat: widget.isReadOnly ?? false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        );
                      },
                    )
                  ],
                )),
      bottomSheet: Container(
        color: AppColor.white,
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: BlocConsumer<AddMeterReadingsBloc, AddMeterReadingsState>(
          listener: (context, state) {
            if (state is PostMeterReadingsSuccess) {
              CustomSnackbarWidget(
                  context: context,
                  title: state.message,
                  backgroundColor: AppColor.primaryColor1);
              if (state.message == 'Reading Added/Updated') {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            } else if (state is PostMeterReadingsError) {
              CustomSnackbarWidget(
                  context: context,
                  title: state.message,
                  backgroundColor: AppColor.red);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomizedButton(
                label: state is PostMeterReadingsLoading ? 'Saving...' : 'SAVE',
                style: txt_14_500.copyWith(color: AppColor.white),
                onPressed:
                    (state is PostMeterReadingsLoading || widget.isReadOnly!) ? () {showSnackbarForNonAdmins(context);} : _submitReadings,
                isReadOnly: widget.isReadOnly ?? false,
              ),
            );
          },
        ),
      ),
    );
  }
}
