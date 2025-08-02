import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/search-community/apartment_details/onboarding_request.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/build_dropdownfield.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/colors.dart';
import 'bloc/flat_bloc.dart';

class ApartmentDetails extends StatefulWidget {
  final String city;
  final String apartmentName;
  final int apartmentId;
  final String district;
  final String state;
  final String source;
  const ApartmentDetails({
    super.key,
    required this.apartmentName,
    required this.apartmentId,
    required this.city,
    required this.district,
    required this.state,
    required this.source
  });

  @override
  State<ApartmentDetails> createState() => _ApartmentDetailsState();
}

class _ApartmentDetailsState extends State<ApartmentDetails> {
  List<String> memberTypes = ['Owner', 'Tenant'];
  String? selectedFlat;
  String? selectedMemberType;
  int? selectedFlatId;
  List<String> flatNumbers = [];
  Set<String> uniqueFlatNumbers = {};
  List<String> filteredNumbers = [];
  bool showFlatNumbers = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int pageNo = 0;
  int pageSize = 20;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          showFlatNumbers = false;
        });
      }
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoadingMore) {
      setState(() {
        isLoadingMore = true;
        pageNo++;
        // context.read<FlatBloc>().add(FetchFlats(selectedMemberType!, widget.apartmentId, pageNo, pageSize));
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<FlatBloc>().add(FetchFlats(selectedMemberType!, widget.apartmentId, pageNo, pageSize));
        });
      });
    }
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
        _searchController.clear();
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        resizeToAvoidBottomInset: true,
        appBar: TopBar(title: widget.apartmentName),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: getWidth(context),
                height: getHeight(context) * 0.25,
                child: Image.asset(
                  apartment,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.apartmentName,
                      style: txt_14_600.copyWith(color: AppColor.black2),
                    ),
                    Text('${widget.city}, ${widget.district}, ${widget.state}',
                        style: txt_12_400.copyWith(color: AppColor.black2)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Member Type',
                        style: txt_12_700.copyWith(color: AppColor.black2)),
                    const SizedBox(
                      height: 10,
                    ),
                    BuildDropDownField(
                      label: 'Choose member Type',
                      items: memberTypes,
                      value: selectedMemberType,
                      onChanged: (value) {
                        setState(() {
                          selectedMemberType = value;
                          selectedFlat = null;
                          pageNo = 0;
                          _searchController.clear();
                          flatNumbers = [];
                          uniqueFlatNumbers.clear();
                          print('$pageNo, $pageSize');
                          if (value != null) {
                            context
                                .read<FlatBloc>()
                                .add(FetchFlats(value, widget.apartmentId, pageNo,pageSize));
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text('Flat Number',
                        style: txt_12_700.copyWith(color: AppColor.black2)),
                    const SizedBox(
                      height: 10,
                    ),
                    selectedMemberType != null
                        ? BlocBuilder<FlatBloc, FlatState>(
                            builder: (context, state) {
                              if (state is FlatLoading) {
                                return AppLoader();
                              } else if(state is FlatFailure){
                                return Center(child: Text(state.message));
                              } else if (state is FlatLoaded) {
                                if (state.flats.content.isEmpty) {
                                  return Text(
                                      'No flats available for the selected member type and apartment.');
                                }
                                if (!state.flats.content
                                    .any((flat) => flat.flatNo == selectedFlat)) {
                                  selectedFlat = null;
                                }
                                state.flats.content.forEach((flat) {
                                  if (uniqueFlatNumbers.add(flat.flatNo)) {
                                    flatNumbers.add(flat.flatNo);
                                  }
                                });
                                print(flatNumbers);
                                filteredNumbers = flatNumbers.where((item) => item.toLowerCase().contains(_searchController.text.toLowerCase()))
                                  .toList();
                                return Column(
                                  children: [
                                    TextField(
                                      controller: _searchController,
                                      onChanged: filterSearchResults,
                                      focusNode: _focusNode,
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
                                    ),
                                    if (showFlatNumbers && filteredNumbers.isNotEmpty)
                                      Container(
                                        height: getHeight(context)*0.3,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColor.greyBorder),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          shrinkWrap: true,
                                          itemCount: filteredNumbers.length,
                                          itemBuilder: (context, index) {
                                            print(filteredNumbers.length);
                                            if (index == filteredNumbers.length) {
                                              return isLoadingMore ? AppLoader() : SizedBox.shrink();
                                            } else {
                                              return ListTile(
                                                title: Text(filteredNumbers[index]),
                                                onTap: () {
                                                  setState(() {
                                                    selectedFlat = filteredNumbers[index];
                                                    selectedFlatId = state.flats.content
                                                        .firstWhere((flat) => flat.flatNo == selectedFlat).id;
                                                    _searchController.text = selectedFlat!;
                                                    showFlatNumbers = false;
                                                    _focusNode.unfocus();
                                                  });
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                  ],
                                );
                              }  
                              else if (state is FlatFailure) {
                                return Text('Error: ${state.message}');
                              } else {
                                return SizedBox();
                              }
                            },
                          )
                        : GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Please select Member Type first')),
                              );
                            },
                            child: Container(
                              width: getWidth(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Flat Number',
                                style: txt_12_600.copyWith(color: AppColor.grey),
                              ),
                            ),
                          ),
                    // const Spacer(),
                    SizedBox(height: 200,),
                    CustomizedButton(
                        label: 'Send Request',
                        style: txt_14_500.copyWith(color: AppColor.white),
                        onPressed: () {
                          if (selectedMemberType != null &&
                              selectedFlat != null) {
                            context.read<FlatBloc>().add(SendRequest(
                                selectedMemberType!, selectedFlatId!));
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OnboardingRequest(source: 'flat',)),
                              (route) => false,
                            );
                          }else if(selectedFlat == null){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Please Select Valid Flat Number')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Please select both Member Type and Flat')),
                            );
                          }
                        }),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
