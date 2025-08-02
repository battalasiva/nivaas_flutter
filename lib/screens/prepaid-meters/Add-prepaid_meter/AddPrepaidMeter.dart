import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/prepaid-meters/Add-prepaid_meter/AddPrepaidMeterPopup.dart';
import 'package:nivaas/screens/prepaid-meters/meter-consumption/bloc/meter_consumption_bloc.dart';
import 'package:nivaas/screens/prepaid-meters/meter-consumption/bloc/meter_consumption_event.dart';
import 'package:nivaas/screens/prepaid-meters/meter-consumption/bloc/meter_consumption_state.dart';
import 'package:nivaas/widgets/cards/PrepaidMeterCard.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class AddPrepaidMeter extends StatefulWidget {
  final int? apartmentId;
  final bool? isOwner,isAdmin,isLeftSelected,isReadOnly;
  const AddPrepaidMeter({super.key, this.apartmentId,this.isOwner,this.isAdmin,this.isLeftSelected,this.isReadOnly});
  final bool? isEdit = false;
  @override
  State<AddPrepaidMeter> createState() => _AddPrepaidMeterState();
}

class _AddPrepaidMeterState extends State<AddPrepaidMeter> {
  int? prepaidmetersLength;
  @override
  void initState() {
    super.initState();
    fetchPrepaidMeterData();
  }

  void fetchPrepaidMeterData() {
    print('object: ${widget.apartmentId}');
    context.read<PrepaidMeterBloc>().add(
          FetchPrepaidMeterList(
            apartmentId: widget.apartmentId!,
            pageNo: 0,
            pageSize: 10,
          ),
        );
  }

  void _showAddPrepaidMeterModal(BuildContext context, isEdit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) =>
          AddPrepaidMeterPopup(isEdit: isEdit, apartmentId: widget.apartmentId),
    ).then((result) {
      if (result == true) {
        Future.delayed(const Duration(seconds: 2), () {
          fetchPrepaidMeterData();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Pre-Paid Meters'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Meters', style: txt_14_600.copyWith(color: AppColor.black1)),
            SizedBox(height: getHeight(context) * 0.010),
            Expanded(
              child: BlocBuilder<PrepaidMeterBloc, PrepaidMeterState>(
                builder: (context, state) {
                  if (state is PrepaidMeterLoading) {
                    return const Center(child: AppLoader());
                  } else if (state is PrepaidMeterLoaded) {
                    print('DATA : ${state.meters} ${state.meters.totalItems}');
                    prepaidmetersLength = state.meters.totalItems;
                    if (state.meters.data == null ||
                        state.meters.data!.isEmpty) {
                      return Center(
                        child: Text(
                          "No Prepaid Meters Available",
                          style: txt_16_500.copyWith(color: AppColor.black),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.meters.data!.length,
                            itemBuilder: (context, index) {
                              bool isEdit = true;
                              final meter = state.meters.data![index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 1.0),
                                child: PrepaidMeterCard(
                                  meterName: meter.name ?? "Unnamed Meter",
                                  buttonTitle: 'View Details',
                                  isAdmin:widget.isAdmin,
                                  isLeftSelected: widget.isLeftSelected,
                                  isReadOnly:widget.isReadOnly,
                                  onAddConsumption: () async {
                                    final result = await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                      ),
                                      builder: (context) =>
                                          AddPrepaidMeterPopup(
                                        isEdit: isEdit,
                                        meterName: meter.name,
                                        costPerUnit:
                                            meter.costPerUnit.toString(),
                                        apartmentId: widget.apartmentId,
                                        meterType: meter.meterType,
                                        id:meter.id,
                                        isReadOnly:widget.isReadOnly,
                                        configRangeList: meter.configRangeList
                                            ?.map((config) => config.toJson())
                                            .toList(),
                                      ),
                                    );
                                    if (result == true) {
                                      fetchPrepaidMeterData();
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        if(prepaidmetersLength != 5 && widget.isAdmin! && !widget.isReadOnly!)
                          _buildAddPrepaidMeterButton(),
                      ],
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Prepaid Meters not Available",
                          style: txt_15_500.copyWith(color: AppColor.black)),
                          if(prepaidmetersLength != 5 && widget.isAdmin! && !widget.isReadOnly!)
                          _buildAddPrepaidMeterButton(),
                        ],
                      )
                    );
                  }
                },
                
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildAddPrepaidMeterButton() {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 50),
      child: CustomizedButton(
        label: 'Add New Prepaid Meter',
        style: txt_14_500.copyWith(color: AppColor.white),
        onPressed: () {
          _showAddPrepaidMeterModal(context, widget.isEdit);
        },
      ),
    );
  }
}
