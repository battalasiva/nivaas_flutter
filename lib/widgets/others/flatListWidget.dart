import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/search-community/flat_list_model.dart';
import 'package:nivaas/screens/prepaid-meters/Add-Consumption/AddConsumption.dart';
import 'package:nivaas/screens/prepaid-meters/add-MeterReadings/AddMeterReadings.dart';
import 'package:nivaas/screens/search-community/apartment_details/bloc/flat_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';

class FlatsListWidget extends StatefulWidget {
  final int apartmentId;
  final int? prepaidMeterId;
  final String? prepaidMeterName, meterType;
  final bool? isReadOnly;

  const FlatsListWidget({
    super.key,
    required this.apartmentId,
    this.prepaidMeterId,
    this.prepaidMeterName,
    this.meterType,
    this.isReadOnly,
  });

  @override
  State<FlatsListWidget> createState() => _FlatsListWidgetState();
}

class _FlatsListWidgetState extends State<FlatsListWidget> {
  int currentPage = 0;
  int pageSize = 20;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  List<FlatContent> flats = [];

  @override
  void initState() {
    super.initState();
    context
        .read<FlatBloc>()
        .add(FetchFlats('', widget.apartmentId, currentPage, pageSize));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet(context);
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColor.white,
      context: context,
      isScrollControlled: true,
      barrierColor: const Color.fromARGB(136, 56, 53, 53),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return BlocConsumer<FlatBloc, FlatState>(
          listener: (context, state) {
            if (state is FlatLoaded) {
              setState(() {
                if (currentPage == 0) {
                  flats = state.flats.content;
                } else {
                  flats.addAll(state.flats.content);
                }
                if (currentPage < state.flats.totalPages - 1) {
                  currentPage++;
                  hasMoreData = true;
                  isLoadingMore = true;
                  context.read<FlatBloc>().add(FetchFlats(
                      '', widget.apartmentId, currentPage, pageSize));
                } else {
                  hasMoreData = false;
                }
              });
            }
          },
          builder: (context, state) {
            return Container(
              width: getWidth(context),
              height: getHeight(context) * 0.7,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Choose Flat",
                      style: txt_16_600.copyWith(color: AppColor.black1),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: (state is FlatLoading && flats.isEmpty)
                        ? const Center(child: AppLoader())
                        : GridView.builder(
                            itemCount: flats.length + (hasMoreData ? 1 : 0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                            itemBuilder: (context, index) {
                              if (index == flats.length) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: AppLoader(),
                                  ),
                                );
                              }
                              final flat = flats[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => (widget.meterType ==
                                              'CONSUMPTION_UNITS')
                                          ? AddConsumption(
                                              flatNumber:
                                                  flat.flatNo.toString(),
                                              flatId: flat.id.toString(),
                                              apartmentId: widget.apartmentId,
                                              prepaidMeterId:
                                                  widget.prepaidMeterId,
                                              prepaidMeterName:
                                                  widget.prepaidMeterName,
                                              type: 'SINGLE_FLAT_CONSUMPTION',
                                              isReadOnly:widget.isReadOnly,
                                            )
                                          : AddMeterReadings(
                                              flatNumber:
                                                  flat.flatNo.toString(),
                                              flatId: flat.id.toString(),
                                              apartmentId: widget.apartmentId,
                                              prepaidMeterId:
                                                  widget.prepaidMeterId,
                                              prepaidMeterName:
                                                  widget.prepaidMeterName,
                                              type: 'SINGLE_FLAT_READING',
                                              isReadOnly:widget.isReadOnly,
                                            ),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColor.blueShade,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    flat.flatNo.toString(),
                                    style: txt_14_600.copyWith(
                                        color: AppColor.blue),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: getWidth(context),
                    color: AppColor.blueShade,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Ensures spacing
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right:
                                    8.0), // Add space between text and button
                            child: Text(
                              "Add ${widget.meterType == 'CONSUMPTION_UNITS' ? 'Consumption' : 'Readings'} For All Flats",
                              style: txt_14_600.copyWith(color: AppColor.blue),
                              maxLines: 1, // Limits text to one line
                              overflow: TextOverflow
                                  .ellipsis, // Hides overflowing text with "..."
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (widget.meterType ==
                                        'CONSUMPTION_UNITS')
                                    ? AddConsumption(
                                        apartmentId: widget.apartmentId,
                                        prepaidMeterId: widget.prepaidMeterId,
                                        prepaidMeterName:
                                            widget.prepaidMeterName,
                                        type: 'MULTI_FLAT_CONSUMPTION',
                                        isReadOnly:widget.isReadOnly,
                                      )
                                    : AddMeterReadings(
                                        apartmentId: widget.apartmentId,
                                        prepaidMeterId: widget.prepaidMeterId,
                                        prepaidMeterName:
                                            widget.prepaidMeterName,
                                        type: 'MULTI_FLAT_READING',
                                        isReadOnly:widget.isReadOnly,
                                      ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            'Click Here',
                            style: txt_11_600.copyWith(color: AppColor.white1),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
