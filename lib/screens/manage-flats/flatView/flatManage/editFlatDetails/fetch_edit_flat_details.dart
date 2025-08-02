import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/TopSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../data/models/manageFlats/flat_details_model.dart';
import '../../../../../widgets/elements/button.dart';
import 'bloc/flat_details_bloc.dart';

class FetchEditFlatDetails extends StatefulWidget {
  final int flatId;
  final bool isOwner;

  const FetchEditFlatDetails({required this.flatId, required this.isOwner, super.key});

  @override
  State<FetchEditFlatDetails> createState() => _FetchEditFlatDetailsState();
}

class _FetchEditFlatDetailsState extends State<FetchEditFlatDetails> {
  List<String> parkingOptions = ['Yes', 'No'];
  List<String> furnitureOptions = ['Yes', 'No'];
  List<String> facingOptions = ['EAST', 'WEST', 'NORTH', 'SOUTH'];
  String? parkingAvailability;
  String? furnitureAvailability;
  String? selectedFacing;
  TextEditingController floorNo = TextEditingController();
  TextEditingController noOfRooms = TextEditingController();
  TextEditingController sqFeet = TextEditingController();
  TextEditingController rentAmount = TextEditingController();
  TextEditingController depositAmount = TextEditingController();
  TextEditingController availableDate = TextEditingController();

  bool isEditable = false;
  final _formKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<FlatDetailsBloc>(context);
    bloc.add(FetchFlatDetailsEvent(widget.flatId));
  }
  
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FlatDetailsBloc>(context);
    return BlocConsumer<FlatDetailsBloc, FlatDetailsState>(
      listener: (context, state) {
        if (state is FlatDetailsLoaded) {
          final flatDetails = state.flatDetails;
          floorNo.text = flatDetails.floorNo.toString();
          noOfRooms.text = flatDetails.totalRooms.toString();
          sqFeet.text = flatDetails.squareFeet.toString();
          selectedFacing = flatDetails.facing;
          parkingAvailability = flatDetails.parkingAvailable != null &&
                  flatDetails.parkingAvailable!
              ? 'Yes'
              : 'No';
        }else if (state is FlatDetailsUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Details updated successfully!'),
          ));
          setState(() {
            isEditable = false;
          });
          Navigator.pop(context);
        } else if(state is FlatDetailsLoading){
          AppLoader();
        } else if (state is FlatDetailsFailure) {
          TopSnackbarWidget.showTopSnackbar(
            context: context,
            message: 'Failed to update details: ${state.message}'
          );
        }
      },
      builder: (context, state) {
        print('---------Current State: $state');
          return Container(
            height: isEditable? getHeight(context) * 0.55 : getHeight(context) * 0.45,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: Form(
              key: _formKey1,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Floor',
                              style: txt_14_600.copyWith(color: AppColor.black2),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DetailsField(
                              controller: floorNo,
                              hintText: 'Enter Floor no',
                              condition: isEditable,
                              isOnlyNumbers: true,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'No of Rooms',
                                        style: txt_14_600.copyWith(color: AppColor.black2),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      DetailsField(
                                        controller: noOfRooms,
                                        hintText: 'Enter no of rooms',
                                        condition: isEditable,
                                        isOnlyNumbers: true,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sq Feet',
                                        style: txt_14_600.copyWith(
                                            color: AppColor.black2),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      DetailsField(
                                        controller: sqFeet,
                                        hintText: 'Enter Sq Feet',
                                        condition: isEditable,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Textwithstar(label: 'Facing'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      _BuildDropDown(
                                        label: 'Select facing',
                                        items: facingOptions,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedFacing = value;
                                          });
                                        },
                                        value: selectedFacing,
                                        isEditable: isEditable,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Select Facing';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Parking Available',
                                        style: txt_14_600.copyWith(
                                            color: AppColor.black2),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      _BuildDropDown(
                                        label: 'Select',
                                        items: parkingOptions,
                                        onChanged: (value) {
                                          setState(() {
                                            parkingAvailability = value;
                                          });
                                        },
                                        value: parkingAvailability,
                                        isEditable: isEditable,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             'Rent Amount',
                            //             style: txt_14_600.copyWith(
                            //                 color: AppColor.black2),
                            //           ),
                            //           SizedBox(
                            //             height: 10,
                            //           ),
                            //           DetailsField(
                            //             controller: rentAmount,
                            //             hintText: 'Enter Rent Amount',
                            //             condition: isEditable,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             'Deposit Amount',
                            //             style: txt_14_600.copyWith(
                            //                 color: AppColor.black2),
                            //           ),
                            //           SizedBox(
                            //             height: 10,
                            //           ),
                            //           DetailsField(
                            //             controller: depositAmount,
                            //             hintText: 'Enter Deposit Amount',
                            //             condition: isEditable,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             'Available from',
                            //             style: txt_14_600.copyWith(
                            //                 color: AppColor.black2),
                            //           ),
                            //           SizedBox(
                            //             height: 10,
                            //           ),
                            //           DetailsField(
                            //             controller: availableDate,
                            //             hintText: 'Choose Date',
                            //             condition: isEditable,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             'Furniture',
                            //             style: txt_14_600.copyWith(
                            //                 color: AppColor.black2),
                            //           ),
                            //           SizedBox(
                            //             height: 10,
                            //           ),
                            //           _BuildDropDown(
                            //             label: 'Select',
                            //             items: furnitureOptions,
                            //             onChanged: (value) {},
                            //             value: furnitureAvailability,
                            //             isEditable: isEditable,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 55,
                            ),
                            if(isEditable)
                            CustomizedButton(
                                label: 'Save',
                                onPressed: () {
                                  if (isEditable) {
                                      final parsedRooms = int.tryParse(noOfRooms.text) ?? 0;
                          final parsedSqFeet = double.tryParse(sqFeet.text) ?? 0.0;
                          print('Parsed noOfRooms: $parsedRooms');
                          print('Parsed sqFeet: $parsedSqFeet');
                                    final updatedFlatDetails = FlatDetailsModel(
                                      facing: selectedFacing!,
                                      totalRooms: parsedRooms,
                                      squareFeet: parsedSqFeet,
                                      floorNo: int.parse(floorNo.text),
                                      parkingAvailable: parkingAvailability == 'Yes',
                                      // rentAmount: double.parse(rentAmount.text),
                                      // depositAmount: double.parse(depositAmount.text),
                                      // availableFrom: availableDate.text,
                                      // furniture: furnitureAvailability == 'Yes'
                                    );
                                    if (_formKey1.currentState?.validate() ?? false) {
                                      print('Form is valid');
                                    }
                                    if(selectedFacing!.isNotEmpty)
                                    {
                                      bloc.add(UpdateFlatDetailsEvent(
                                        flatId: widget.flatId,
                                        flatDetails: updatedFlatDetails));
                                    }
                                  } else{
                                    Navigator.pop(context);
                                  }
                                },
                                style: txt_14_500.copyWith(color: AppColor.white1))
                          ],
                        ),
                      ),
                      widget.isOwner ?
                      Positioned(
                          top: 20,
                          right: 20,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isEditable = !isEditable;
                              });
                            },
                            child: Text(
                              isEditable ? '' : 'Edit',
                              style: txt_14_600.copyWith(
                                  color: AppColor.primaryColor2),
                            )
                          )
                        )
                      : SizedBox()
                    ],
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}

class _BuildDropDown extends StatelessWidget {
  final String label;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? value;
  final bool isEditable;
  final FormFieldValidator<String>? validator;

  const _BuildDropDown({
    required this.label,
    required this.items,
    required this.onChanged,
    required this.value,
    this.isEditable = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          hint: Text(label,
              style: txt_11_600.copyWith(color: AppColor.greyText2)),
          isExpanded: true,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          value: items.contains(value) ? value : null,
          onChanged: isEditable ? onChanged : null,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          ),
          icon: Icon(Icons.keyboard_arrow_down, color: AppColor.black2),
          isDense: true,
        ),
      ],
    );
  }
}
