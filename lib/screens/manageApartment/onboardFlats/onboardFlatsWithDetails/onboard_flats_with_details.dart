import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/data/models/manageApartment/onboarding_flat_withdetails_model.dart';
import 'package:nivaas/screens/manageApartment/onboardFlats/bloc/onboard_flats_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class OnboardFlatsWithDetails extends StatefulWidget {
  final int apartmentId;
  const OnboardFlatsWithDetails({super.key, required this.apartmentId});

  @override
  State<OnboardFlatsWithDetails> createState() =>
      _OnboardFlatsWithDetailsState();
}

class _OnboardFlatsWithDetailsState extends State<OnboardFlatsWithDetails> {
  final TextEditingController _numFlatsController = TextEditingController();
  final List<TextEditingController> flatNoControllers = [];
  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> mobileNoControllers = [];
  int _numFlats = 0;
  int _currentFlatIndex = 0;

  @override
  void dispose() {
    _numFlatsController.dispose();
    for (var controller in flatNoControllers) {
      controller.dispose();
    }
    for (var controller in nameControllers) {
      controller.dispose();
    }
    for (var controller in mobileNoControllers) {
      controller.dispose();
    }
    super.dispose();
  }
  void _onNext() {
    if (flatNoControllers[_currentFlatIndex].text.isNotEmpty &&
        nameControllers[_currentFlatIndex].text.isNotEmpty &&
        mobileNoControllers[_currentFlatIndex].text.isNotEmpty) {
      setState(() {
        if (_currentFlatIndex < _numFlats - 1) {
          _currentFlatIndex++;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields for the current flat.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardFlatsBloc, OnboardFlatsState>(
      listener: (context, state) {
        if (state is OnboardFlatsLoading) {
          Center(child: AppLoader());
        } else if(state is OnboardFlatsError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),);
        } else if(state is OnboardFlatsLoaded){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Flat onboarded successfully')),);
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Textwithstar(label: 'Total Flats'),
            SizedBox(
              height: 8,
            ),
            DetailsField(
              controller: _numFlatsController,
              hintText: 'Enter Number of Flats',
              condition: true,
              onChanged:(value) {
                setState(() {
                  _numFlats = int.tryParse(_numFlatsController.text) ?? 0;
                  flatNoControllers.clear();
                  nameControllers.clear();
                  mobileNoControllers.clear();
                  for (int i = 0; i < _numFlats; i++) {
                    flatNoControllers.add(TextEditingController());
                    nameControllers.add(TextEditingController());
                    mobileNoControllers.add(TextEditingController());
                  }
                });
              },
            ),
            SizedBox(height: 10,),
            if(_numFlats > 0)
            Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                itemCount: 1,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColor.blueShade,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Flat ${_currentFlatIndex + 1}', style: txt_16_500.copyWith(color: AppColor.primaryColor1),),
                          SizedBox(height: 14,),
                          Textwithstar(label: 'Flat Number'),
                          SizedBox(height: 8,),
                          DetailsField(
                            controller: flatNoControllers[_currentFlatIndex], 
                            hintText: 'Enter Flat Number', 
                            condition: true
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Textwithstar(label: 'Owner Name'),
                          SizedBox(
                            height: 8,
                          ),
                          DetailsField(
                              controller: nameControllers[_currentFlatIndex], 
                              hintText: 'Enter Full Name', condition: true
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Textwithstar(label: 'Mobile Number'),
                          SizedBox(
                            height: 8,
                          ),
                          DetailsField(
                            controller: mobileNoControllers[_currentFlatIndex],
                            hintText: 'Enter Mobile Number',
                            condition: true,
                            maxLengthCondition: true,
                            isOnlyNumbers: true,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
            if(_numFlats > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: 
              (_currentFlatIndex < _numFlats - 1) ?
              CustomizedButton(
                label: 'Next', 
                onPressed: _onNext, 
                style: txt_14_500.copyWith(color: AppColor.white)
              )
              : CustomizedButton(
                label: _numFlats>1 ? 'Onboard Flats' : 'Onboard Flat',
                onPressed: () {
                  List<String> flatNumbers = flatNoControllers.map((controller) => controller.text).toList();
                  List<String> names = nameControllers.map((controller) => controller.text).toList();
                  List<String> mobileNumbers = mobileNoControllers.map((controller) => controller.text).toList();
                  if (flatNumbers.every((flatNumber) => flatNumber.isNotEmpty) &&
                    names.every((name) => name.isNotEmpty) &&
                    mobileNumbers.every((mobileNumber) => mobileNumber.isNotEmpty)) {
                      List<OnboardFlatDetails> flats = List.generate(flatNumbers.length, (index) {
                    return OnboardFlatDetails(
                      flatNo: flatNumbers[index],
                      ownerName: names[index],
                      ownerPhoneNo: mobileNumbers[index],
                    );
                  });
                  final onboardingDetails = OnboardingFlatWithdetailsModel(apartmentId: widget.apartmentId, flats: flats);
                  context.read<OnboardFlatsBloc>().add(OnboardFlatWithDetailsEvent(flatDetails: onboardingDetails));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields for the current flat.')),
                    );
                  }
                },
                style: txt_14_500.copyWith(color: AppColor.white)),
            )
          ],
        ),
      ),
    );
  }
}
