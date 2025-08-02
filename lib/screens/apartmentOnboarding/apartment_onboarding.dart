import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/data/models/apartmentOnboarding/apartment_onboard_model.dart';
import 'package:nivaas/screens/apartmentOnboarding/bloc/apartment_onboarding_bloc.dart';
import 'package:nivaas/screens/apartmentOnboarding/search_city.dart';
import 'package:nivaas/screens/search-community/apartment_details/onboarding_request.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../core/constants/text_styles.dart';
import '../../widgets/elements/build_dropdownfield.dart';

class ApartmentOnboarding extends StatefulWidget {
  final String city;
  final int cityId;
  final String region;
  final List<String> postalCodes;
  ApartmentOnboarding({super.key, required this.city, required this.cityId, required this.region, required this.postalCodes});

  @override
  State<ApartmentOnboarding> createState() => _ApartmentOnboardingState();
}

class _ApartmentOnboardingState extends State<ApartmentOnboarding> {
  final TextEditingController apartmentName = TextEditingController();

  final TextEditingController numberOfFlats = TextEditingController();

  // final TextEditingController pinCode = TextEditingController();
  final TextEditingController address1 = TextEditingController();

  final TextEditingController address2 = TextEditingController();

  String? selectedPostalCode;

  bool _validateForm() {
    if (apartmentName.text.isEmpty || numberOfFlats.text.isEmpty || selectedPostalCode!.isEmpty || address1.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Enter Apartment Details'),
      body: BlocListener<ApartmentOnboardingBloc, ApartmentOnboardingState>(
        listener: (context, state) {
          if (state is ApartmentOnboardingError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
          } else if(state is ApartmentOnboardingLoading){
            Center(child: AppLoader());
          }else if(state is ApartmentOnboardingLoaded){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OnboardingRequest(source: 'apartment')));
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Textwithstar(label:'Apartment Details'),
                SizedBox(
                  height: 8,
                ),
                DetailsField(
                    controller: apartmentName,
                    hintText: 'Enter Apartment Name',
                    condition: true),
                SizedBox(
                  height: 8,
                ),
                Textwithstar(label: 'No of Flats'),
                SizedBox(
                  height: 8,
                ),
                DetailsField(
                    controller: numberOfFlats,
                    hintText: 'Enter Number of Flats',
                    condition: true),
                SizedBox(
                  height: 8,
                ),
                Textwithstar(label: 'Pin code'),
                SizedBox(
                  height: 8,
                ),
                // DetailsField(
                //     controller: pinCode, label: 'Enter PinCode', condition: true),
                BuildDropDownField(
                  label: 'Select Postal Code',
                  items: widget.postalCodes,
                  onChanged: (value) {
                    setState(() {
                      selectedPostalCode = value;
                    });
                  },
                  value: selectedPostalCode,
                ),
                SizedBox(
                  height: 8,
                ),
                Text('City', style: txt_14_600.copyWith(color: AppColor.black2)),
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.greyBorder)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.city),
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchCity()));
                        }, 
                        child: Text('Change', style: txt_13_600.copyWith(color: AppColor.primaryColor2),)
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text('State',
                    style: txt_14_600.copyWith(color: AppColor.black2)),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: getWidth(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.region,
                    style: txt_14_500.copyWith(color: AppColor.black2),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Textwithstar(label: 'Address 1'),
                SizedBox(
                  height: 8,
                ),
                DetailsField(
                    controller: address1,
                    hintText: 'Enter Address',
                    condition: true),
                SizedBox(
                  height: 8,
                ),
                Text('Address 2',
                    style: txt_14_600.copyWith(color: AppColor.black2)),
                SizedBox(
                  height: 8,
                ),
                DetailsField(
                    controller: address2,
                    hintText: 'Enter Address',
                    condition: true),
                // Spacer(),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: CustomizedButton(
                      label: 'Send Request',
                      onPressed: () {
                        if (_validateForm()) {
                          final apartment = ApartmentOnboard(
                            name: apartmentName.text, 
                            totalFlats: int.parse(numberOfFlats.text), 
                            line1: address1.text, 
                            line2: address2.text, 
                            postalCode: selectedPostalCode!,
                            cityId: widget.cityId
                          );
                          context.read<ApartmentOnboardingBloc>().add(PostApartmentDetailsEvent(apartment: apartment));
                        } else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
                            Text('Please fill all required fields!')));
                        }
                      },
                      style: txt_16_500.copyWith(color: AppColor.white1)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
