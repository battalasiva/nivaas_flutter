import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/search-community/flat_list_model.dart';
import 'package:nivaas/screens/search-community/apartment_details/bloc/flat_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/box_image.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/sizes.dart';
import '../../../widgets/elements/bottom_tab.dart';
import '../../../widgets/elements/button.dart';
import 'bloc/checkin_request_bloc.dart';

class CheckInEntry extends StatefulWidget {
  final int apartmentId;
  const CheckInEntry({super.key, required this.apartmentId});

  @override
  State<CheckInEntry> createState() => _CheckInEntryState();
}

class _CheckInEntryState extends State<CheckInEntry> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  String selectedItem = 'Guest';
  int pageNo = 0;
  final int pageSize = 20;
  String? selectedFlat;
  int? selectedFlatId;
  List<String> flatNumbers = [];
  Set<String> uniqueFlatNumbers = {};
  List<String> filteredNumbers = [];
  final TextEditingController _searchController = TextEditingController();
  bool isLoadingMore = false;
  bool showFlatNumbers = false;
  List<FlatContent> flatNums = [];

  @override
  void initState() {
    super.initState();
    _fetchFlats();
  }

  void _fetchFlats() {
    flatNumbers.clear();
    uniqueFlatNumbers.clear();
    flatNums.clear();
    pageNo = 0;
    _loadFlats();
  }

  void _loadFlats() {
    context
        .read<FlatBloc>()
        .add(FetchFlats('Owner', widget.apartmentId, pageNo, pageSize));
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredNumbers = flatNumbers;
      } else {
        filteredNumbers = flatNumbers
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      print('filtered numbers ---------- $filteredNumbers');
      showFlatNumbers = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          showFlatNumbers = false;
        });
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: TopBar(title: 'Check In Entry'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoxImage(
                          label: 'Guest',
                          imagePath: guestIcon,
                          selectedItem: selectedItem,
                          onSelect: (label) {
                            setState(() {
                              selectedItem = label;
                            });
                          },
                        ),
                        BoxImage(
                          label: 'Cab',
                          imagePath: cab,
                          selectedItem: selectedItem,
                          onSelect: (label) {
                            setState(() {
                              selectedItem = label;
                            });
                          },
                        ),
                        BoxImage(
                          label: 'Delivery',
                          imagePath: motorcycle,
                          selectedItem: selectedItem,
                          onSelect: (label) {
                            setState(() {
                              selectedItem = label;
                            });
                          },
                        ),
                        BoxImage(
                          label: 'Service',
                          imagePath: services,
                          selectedItem: selectedItem,
                          onSelect: (label) {
                            setState(() {
                              selectedItem = label;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Flat Number',
                    style: txt_14_600.copyWith(color: AppColor.black2),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BlocListener<FlatBloc, FlatState>(
                    listener: (context, state) {
                      if (state is FlatFailure) {
                        Center(child: Text(state.message));
                      } else if (state is FlatLoaded) {
                        flatNums.addAll(state.flats.content);
                        print('flatNums : $flatNums');
                        print(flatNums.length);
                        if (pageNo < state.flats.totalPages - 1) {
                          pageNo++;
                          _loadFlats();
                        }
                        flatNums.forEach((flat) {
                          if (uniqueFlatNumbers.add(flat.flatNo)) {
                            flatNumbers.add(flat.flatNo);
                          }
                        });
                        print(flatNumbers);
                        filteredNumbers = flatNumbers
                            .where((item) => item
                                .toLowerCase()
                                .contains(_searchController.text.toLowerCase()))
                            .toList();
                      }
                    },
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _searchController,
                          onChanged: filterSearchResults,
                          onTap: () {
                            setState(() {
                              showFlatNumbers = true;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Search for a flat...",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a flat number';
                            }
                            return null;
                          },
                        ),
                        if (showFlatNumbers && filteredNumbers.isNotEmpty)
                          Container(
                            height: getHeight(context) * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.greyBorder),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredNumbers.length,
                              itemBuilder: (context, index) {
                                print(filteredNumbers.length);
                                if (index == filteredNumbers.length) {
                                  return isLoadingMore
                                      ? AppLoader()
                                      : SizedBox.shrink();
                                } else {
                                  return ListTile(
                                    title: Text(filteredNumbers[index]),
                                    onTap: () {
                                      setState(() {
                                        selectedFlat = filteredNumbers[index];
                                        selectedFlatId = flatNums
                                            .firstWhere((flat) =>
                                                flat.flatNo == selectedFlat)
                                            .id;
                                        _searchController.text = selectedFlat!;
                                        showFlatNumbers = false;
                                      });
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Name',
                    style: txt_14_600.copyWith(color: AppColor.black2),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  DetailsField(
                    controller: name, hintText: 'Enter Name', condition: true,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Mobile Number',
                    style: txt_14_600.copyWith(color: AppColor.black2),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  DetailsField(
                    controller: mobileNumber,
                    hintText: 'Enter Mobile Number',
                    condition: true,
                    maxLengthCondition: true,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Mobile number is required';
                      }
                      if (value.length < 10) {
                        return 'Please enter a valid mobile number';
                      }
                      return null;
                    },
                    isOnlyNumbers: true,
                  ),
                  SizedBox(height: showFlatNumbers ? 80 : getHeight(context) * 0.3,),
                  BlocListener<CheckinRequestBloc, CheckinRequestState>(
                    listener: (context, state) {
                      if (state is CheckinRequestSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Checkin request raised successfully')));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BottomTab()),
                        );
                      } else if (state is CheckinRequestFailure) {
                        print(state.message);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 55),
                        child: CustomizedButton(
                            label: 'Check In',
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context
                                    .read<CheckinRequestBloc>()
                                    .add(SendCheckinRequestEvent(
                                        apartmentId: widget.apartmentId,
                                        flatId: selectedFlatId!,
                                        type: selectedItem == 'Guest'
                                            ? 'GUEST'
                                            : selectedItem == 'Cab'
                                                ? 'VEHICLE_BOOKING'
                                                : selectedItem == 'Delivery'
                                                    ? 'DELIVERY'
                                                    : selectedItem == 'Service'
                                                        ? 'SERVICE'
                                                        : '',
                                        name: name.text,
                                        mobileNumber: mobileNumber.text));
                              }
                            },
                            style: txt_14_500.copyWith(color: AppColor.white)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
