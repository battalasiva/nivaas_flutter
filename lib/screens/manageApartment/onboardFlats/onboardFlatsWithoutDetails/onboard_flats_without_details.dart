import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/manageApartment/onboarding_flat_withoutdetails_model.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';

import '../bloc/onboard_flats_bloc.dart';

class OnboardFlatsWithoutDetails extends StatefulWidget {
  final int apartmentId;
  const OnboardFlatsWithoutDetails({super.key, required this.apartmentId});

  @override
  State<OnboardFlatsWithoutDetails> createState() =>
      _OnboardFlatsWithoutDetailsState();
}

class _OnboardFlatsWithoutDetailsState
    extends State<OnboardFlatsWithoutDetails> {
  final TextEditingController _numFlatsController = TextEditingController();
  final List<TextEditingController> _flatControllers = [];
  int _numFlats = 0;

  @override
  void dispose() {
    _numFlatsController.dispose();
    for (var controller in _flatControllers) {
      controller.dispose();
    }
    super.dispose();
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
        }
        else if(state is OnboardFlatsLoaded){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Flat onboarded successfully')),);
            Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  _flatControllers.clear();
                  for (int i = 0; i < _numFlats; i++) {
                    _flatControllers.add(TextEditingController());
                  }
                });
              },
            ),
            SizedBox(height: 20,),
            if(_numFlats >0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Flat', style: txt_14_600.copyWith(color: AppColor.black2),),
                  Text('Flat Number', style: txt_14_600.copyWith(color: AppColor.black2))
                ],
              ),
            ),
            SizedBox(height: 8,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _numFlats,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColor.blueShade,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Flat ${index + 1}', style: txt_16_500.copyWith(color: AppColor.primaryColor1),),
                          Spacer(),
                          Flexible(
                            child: DetailsField(
                              controller: _flatControllers[index], 
                              hintText: 'Enter Flat Number', 
                              condition: true,
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Enter Flat Number';
                                }
                                return null;
                              },
                            ),
                          )
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
              child: CustomizedButton(
                  label: _numFlats>1 ? 'Onboard Flats' : 'Onboard Flat',
                  onPressed: () {
                    List<String> flatNumbers = _flatControllers.map((controller) => controller.text).toList();
                    if (flatNumbers.every((flatNumber) => flatNumber.isNotEmpty)) {
                      List<OnboardFlat> flats = flatNumbers.map((flatNo) => OnboardFlat(flatNo: flatNo)).toList();
                      final onboardFlats = OnboardingFlatWithoutdetailsModel(apartmentId: widget.apartmentId, flats: flats);
                      context.read<OnboardFlatsBloc>().add(OnboardFlatWithoutDetailsEvent(flatDetails: onboardFlats));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields.')),
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
