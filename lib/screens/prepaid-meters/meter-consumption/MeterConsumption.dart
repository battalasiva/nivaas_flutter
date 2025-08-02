import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/prepaid-meters/meter-consumption/bloc/meter_consumption_bloc.dart';
import 'package:nivaas/screens/prepaid-meters/meter-consumption/bloc/meter_consumption_event.dart';
import 'package:nivaas/screens/prepaid-meters/meter-consumption/bloc/meter_consumption_state.dart';
import 'package:nivaas/widgets/cards/PrepaidMeterCard.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/others/flatListWidget.dart';

class MeterConsumption extends StatefulWidget {
  final int? apartmentId;
  final bool? isAdmin,isLeftSelected,isReadOnly;
  const MeterConsumption({super.key, this.apartmentId, this.isAdmin,this.isLeftSelected,this.isReadOnly});

  @override
  State<MeterConsumption> createState() => _MeterConsumptionState();
}

class _MeterConsumptionState extends State<MeterConsumption> {
  List<dynamic>? meterData;

  @override
  void initState() {
    super.initState();
    context.read<PrepaidMeterBloc>().add(
          FetchPrepaidMeterList(
            apartmentId: widget.apartmentId!,
            pageNo: 0,
            pageSize: 5,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Meter Consumption'),
      body: BlocConsumer<PrepaidMeterBloc, PrepaidMeterState>(
        listener: (context, state) {
          if (state is PrepaidMeterLoaded) {
            meterData = state.meters.data;
          }
        },
        builder: (context, state) {
          if (state is PrepaidMeterLoading) {
            return const Center(child: AppLoader());
          } else if (meterData == null || meterData!.isEmpty) {
            return Center(
              child: Text(
                "Prepaid meters Not Available",
                style: txt_15_500.copyWith(color: AppColor.black1),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Meters",
                    style: txt_14_600.copyWith(color: AppColor.black1),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: meterData!.length,
                      itemBuilder: (context, index) {
                        final meter = meterData![index];
                        return PrepaidMeterCard(
                          meterName: meter.name ?? "Unnamed Meter",
                          buttonTitle: meter.meterType == 'CONSUMPTION_UNITS'
                              ? 'Add Consumption'
                              : 'Add Reading',
                          isAdmin: widget.isAdmin,
                          isLeftSelected:widget.isLeftSelected,
                          isReadOnly:widget.isReadOnly,
                          onAddConsumption: () async {
                            final selectedFlat = await showDialog<String>(
                              context: context,
                              builder: (context) => FlatsListWidget(
                                apartmentId: widget.apartmentId!,
                                prepaidMeterId: meter.id!,
                                prepaidMeterName: meter.name,
                                meterType: meter.meterType,
                                isReadOnly: widget.isReadOnly,
                              ),
                            );
                            if (selectedFlat != null) {
                              print("Selected: $selectedFlat");
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
