import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/switchApartment/switch_apartment_model.dart';
import 'package:nivaas/screens/search-community/communityAndRequest/community_and_request.dart';
import 'package:nivaas/screens/switchApartment/bloc/switch_apartment_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/build_dropdownfield.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import '../../widgets/elements/button.dart';

class SwitchApartment extends StatefulWidget {
  final String apartmentName;
  final String flatNo;
  final int apartmentId;
  final int flatId, userId;
  const SwitchApartment(
      {super.key,
      required this.apartmentName,
      required this.flatNo,
      required this.apartmentId,
      required this.flatId,
      required this.userId});

  @override
  State<SwitchApartment> createState() => _SwitchApartmentState();
}

class _SwitchApartmentState extends State<SwitchApartment> {
  late SwitchApartmentBloc apartmentBloc;
  String? selectedApartment;
  String? selectedFlat;
  int? selectedApartmentId;
  int? selectedFlatId;
  // List<String> flatNumbers = [];
  List<Flat> flats = [];

  @override
  void initState() {
    super.initState();
    context.read<SwitchApartmentBloc>().add(SwitchApartmentOrFlatEvent());
    selectedApartment = widget.apartmentName;
    selectedFlat = widget.flatNo;
    selectedApartmentId = widget.apartmentId;
    selectedFlatId = widget.flatId;
    if (widget.flatId == 0 && flats.isNotEmpty) {
    selectedFlatId = flats.first.flatId;
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Switch Flat/Apartment'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        child: BlocListener<SwitchApartmentBloc, SwitchApartmentState>(
          listener: (context, state) {
            if (state is SwitchApartmentChangedSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Flat/Apartment changed successfully")),
              );
              Navigator.pop(context);
            } else if (state is SwitchApartmentChangedFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          child: BlocBuilder<SwitchApartmentBloc, SwitchApartmentState>(
            builder: (context, state) {
              if (state is SwitchApartmentLoading) {
                return const Center(child: AppLoader());
              } else if (state is SwitchApartmentError) {
                return Text(state.message, style: TextStyle(color: Colors.red));
              }else if(state is NoFlatsState){
                return Center(child: Text('You don\'t have any approved flats'));
              } else if (state is SwitchApartmentLoaded) {
                final apartments = state.apartments;
                final selectedApartmentData = apartments.firstWhere(
                    (apartment) => apartment.apartmentId == selectedApartmentId,
                    orElse: () => apartments.first);
                flats = selectedApartmentData.flats ?? [];

                selectedFlat = selectedFlatId != null
                    ? flats.firstWhere(
                        (flat) => flat.flatId == selectedFlatId,
                        orElse: () => flats.isNotEmpty ? flats.first : Flat(flatId: 0, flatNo: 'Unknown')).flatNo
                    : flats.isNotEmpty
                        ? flats.first.flatNo
                        : null;
                selectedFlatId = flats.isNotEmpty && selectedFlatId == null
                  ? flats.first.flatId
                  : selectedFlatId;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Apartments',
                        style: txt_14_600.copyWith(color: AppColor.black2),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      BuildDropDownField(
                          label: '',
                          items: apartments
                              .map((apartment) => apartment.apartmentName)
                              .toList(),
                          onChanged: (String? apartmentSelected) {
                            setState(() {
                              selectedApartment = apartmentSelected;
                              final selectedApartmentData =
                                  apartments.firstWhere(
                                (apartment) =>
                                    apartment.apartmentName ==
                                    apartmentSelected,
                              );
                              selectedApartmentId =
                                  selectedApartmentData.apartmentId;
                              // flatNumbers =
                              //     selectedApartmentData.flatmap.values.toList();
                              // selectedFlat = flatNumbers.isNotEmpty
                              //     ? flatNumbers.first
                              //     : null;
                              flats = selectedApartmentData.flats; 
                          selectedFlat = flats.isNotEmpty ? flats.first.flatNo : null;
                          selectedFlatId = flats.isNotEmpty ? flats.first.flatId : null;
                            });
                          },
                          value: selectedApartment),
                      const SizedBox(
                        height: 17,
                      ),
                      Text(
                        'Your Flats',
                        style: txt_14_600.copyWith(color: AppColor.black2),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4, crossAxisSpacing: 25),
                            itemCount: flats.length,
                            itemBuilder: (context, index) {
                              // final flatNo = flatNumbers[index];
                              // final isSelected = selectedFlat == flatNo;
                              final flat = flats[index];
                          final isSelected = selectedFlat == flat.flatNo;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFlat = flat.flatNo;
                                    selectedFlatId = flat.flatId;
                                  });
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColor.primaryColor1
                                          : AppColor.blueShade,
                                      borderRadius: BorderRadius.circular(6)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    flat.flatNo,
                                    style: txt_14_600.copyWith(
                                        color: isSelected
                                            ? AppColor.white1
                                            : AppColor.primaryColor1),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Wanted To Add A New Flat/ \nTo Join New Community',
                              style: txt_11_500.copyWith(color: AppColor.black2),
                            ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CommunityAndRequest(source: 'switch flat',)));
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  backgroundColor: AppColor.primaryColor1),
                              child: Text(
                                'Click Here',
                                style:
                                    txt_12_500.copyWith(color: AppColor.white1),
                              ))
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 55),
                        child: CustomizedButton(
                            label: 'Change Flat/Apartment',
                            style: txt_14_500.copyWith(color: AppColor.white),
                            onPressed: () {
                              if (flats.isEmpty) {
                                context.read<SwitchApartmentBloc>()
                                .add(SetCurrentApartmentEvent(userId: widget.userId, apartmentId: selectedApartmentId!));
                              }else{
                              context
                                .read<SwitchApartmentBloc>()
                                .add(SetCurrentFlatEvent(
                                  apartmentId: selectedApartmentId!,
                                  flatId: selectedFlatId!,
                                ));
                              }
                            }),
                      )
                    ]);
              } else {
                return Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
