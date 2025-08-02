import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/prepaid-meters/Add-Consumption/bloc/add_consumption_bloc.dart';
import 'package:nivaas/widgets/cards/FlatReadingCard.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomNumberTextField.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/TopSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class AddConsumption extends StatefulWidget {
  final int? apartmentId, prepaidMeterId;
  final String? prepaidMeterName, flatNumber, flatId, type;
  final bool? isReadOnly;

  const AddConsumption({
    super.key,
    this.apartmentId,
    this.prepaidMeterId,
    this.prepaidMeterName,
    this.flatNumber,
    this.flatId,
    this.type,
    this.isReadOnly,
  });

  @override
  State<AddConsumption> createState() => _AddConsumptionState();
}

class _AddConsumptionState extends State<AddConsumption> {
  final List<TextEditingController> _controllers = [];
  final List<Map<String, dynamic>> updatedConsumptionData = [];
  final TextEditingController _singleFlatController = TextEditingController();

  List<dynamic> multiFlatConsumptionData = [];

  @override
  void initState() {
    super.initState();
    if (widget.type == "MULTI_FLAT_CONSUMPTION") {
      context.read<AddConsumptionBloc>().add(
            FetchLastAddedConsumptionEvent(
              apartmentId: widget.apartmentId!,
              prepaidId: widget.prepaidMeterId ?? 0,
            ),
          );
    } else if (widget.type == 'SINGLE_FLAT_CONSUMPTION') {
      context.read<AddConsumptionBloc>().add(
            FetchLastAddedSingleFlatConsumptionEvent(
              apartmentId: widget.apartmentId!,
              prepaidId: widget.prepaidMeterId ?? 0,
              flatId: widget.flatId.toString(),
            ),
          );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _singleFlatController.dispose();
    super.dispose();
  }

  void submitConsumptionData() {
    if (widget.type == "SINGLE_FLAT_CONSUMPTION" &&
        _singleFlatController.text.isEmpty) {
      TopSnackbarWidget.showTopSnackbar(
        context: context,
        title: "Warning",
        message: "Please Enter Consumption Units",
        backgroundColor: AppColor.primaryColor2,
      );
      return;
    }

    final payload = widget.type == "MULTI_FLAT_CONSUMPTION"
        ? {
            "apartmentId": widget.apartmentId,
            "prepaidId": widget.prepaidMeterId,
            "flatConsumption": updatedConsumptionData,
          }
        : {
            "apartmentId": widget.apartmentId,
            "prepaidId": widget.prepaidMeterId,
            "flatConsumption": [
              {
                "flatId": widget.flatId,
                "unitsConsumed": _singleFlatController.text,
              }
            ],
          };

    print('payload : $payload');
    context.read<AddConsumptionBloc>().add(SubmitConsumptionData(payload));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: TopBar(title: '${widget.prepaidMeterName} Consumption'),
        body: Padding(
          padding: EdgeInsets.all(getWidth(context) * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.type == "MULTI_FLAT_CONSUMPTION") ...[
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Flats Numbers',
                        style: txt_14_600.copyWith(color: AppColor.black2),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Consumption Units',
                        style: txt_14_600.copyWith(color: AppColor.black2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: BlocConsumer<AddConsumptionBloc, AddConsumptionState>(
                    listener: (context, state) {
                      if (state is ConsumptionLoaded) {
                        multiFlatConsumptionData = state.consumptionData;
                        if (_controllers.isEmpty) {
                          for (var flat in multiFlatConsumptionData) {
                            _controllers.add(TextEditingController(
                              text: flat.unitsConsumed?.toString() ?? '',
                            ));
                            updatedConsumptionData.add({
                              'flatId': flat.flatId,
                              'flatNo': flat.flatNumber,
                              'unitsConsumed':
                                  flat.unitsConsumed?.toString() ?? '',
                            });
                          }
                        }
                      } else if (state is AddConsumptionFailure) {
                        CustomSnackbarWidget(
                          context: context,
                          title: state.error,
                          backgroundColor: AppColor.red,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is ConsumptionLoading) {
                        return const Center(child: AppLoader());
                      }

                      return ListView.builder(
                        itemCount: multiFlatConsumptionData.length,
                        padding:
                              EdgeInsets.only(bottom: getHeight(context) * 0.1),
                        itemBuilder: (context, index) {
                          final flat = multiFlatConsumptionData[index];
                          return FlatReadingCard(
                            flatNumber: flat.flatNumber!,
                            initialValue: _controllers[index].text,
                            isReadOnly:widget.isReadOnly,
                            onChanged: (value) {
                              setState(() {
                                updatedConsumptionData[index] = {
                                  'flatId': flat.flatId,
                                  'flatNo': flat.flatNumber,
                                  'unitsConsumed': value,
                                };
                                _controllers[index].text = value;
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ] else if (widget.type == "SINGLE_FLAT_CONSUMPTION") ...[
                BlocConsumer<AddConsumptionBloc, AddConsumptionState>(
                  listener: (context, state) {
                    if (state is SingleFlatConsumptionLoaded) {
                      final previousConsumptionData =
                          state.singleFlatconsumptionData;
                      setState(() {
                        _singleFlatController.text =
                            previousConsumptionData.unitsConsumed?.toString() ??
                                "0";
                      });
                    }
                  },
                  builder: (context, state) {
                    String date = "N/A";
                    if (state is SingleFlatConsumptionLoading) {
                      return const Center(child: AppLoader());
                    }
                    if (state is SingleFlatConsumptionLoaded) {
                      final previousConsumptionData =
                          state.singleFlatconsumptionData;
                      date = previousConsumptionData.date?.toString() ?? "N/A";
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date :',
                              style:
                                  txt_15_500.copyWith(color: AppColor.black2),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppColor.blueShade,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                formatDate(date),
                                style:
                                    txt_14_600.copyWith(color: AppColor.black1),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(12.0),
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
                                    widget.flatNumber ?? "N/A",
                                    style: txt_17_500.copyWith(
                                        color: AppColor.blue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Units Consumed',
                          style: txt_14_600.copyWith(color: AppColor.black1),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: AppColor.blueShade,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Consumed Units',
                                style:
                                    txt_12_500.copyWith(color: AppColor.black2),
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
                  },
                )
              ],
            ],
          ),
        ),
        bottomSheet: BlocConsumer<AddConsumptionBloc, AddConsumptionState>(
          listener: (context, state) {
            if (state is AddConsumptionSuccess) {
              CustomSnackbarWidget(
                context: context,
                title: state.message,
                backgroundColor: AppColor.green,
              );
              Navigator.pop(context);
              Navigator.pop(context);
            } else if (state is AddConsumptionFailure) {
              CustomSnackbarWidget(
                context: context,
                title: state.error,
                backgroundColor: AppColor.red,
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AddConsumptionLoading;
            return Container(
              color: AppColor.white,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50,left:20,right: 20),
                child: CustomizedButton(
                  label: isLoading ? 'Saving...' : 'SAVE',
                  style: txt_14_500.copyWith(color: AppColor.white),
                  onPressed: (isLoading || widget.isReadOnly!) ? () {showSnackbarForNonAdmins(context);} : submitConsumptionData,
                  isReadOnly: widget.isReadOnly ?? false,
                ),
              ),
            );
          },
        ));
  }
}
