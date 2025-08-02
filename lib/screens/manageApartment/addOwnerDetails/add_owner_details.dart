import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/data/models/manageApartment/add_ownerdetails_model.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import 'bloc/add_owner_details_bloc.dart';

class AddOwnerDetails extends StatefulWidget {
  final String flatNo;
  final int flatId;
  final int apartmentId;
  const AddOwnerDetails(
      {super.key, required this.flatNo,required this.flatId, required this.apartmentId});

  @override
  State<AddOwnerDetails> createState() => _AddOwnerDetailsState();
}

class _AddOwnerDetailsState extends State<AddOwnerDetails> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Flat Details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flat Number',
              style: txt_14_600.copyWith(color: AppColor.black2),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.greyBorder),
                borderRadius: BorderRadius.circular(10),
              ),
              width: getWidth(context),
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 11),
              child: Text(
                widget.flatNo,
                style: txt_14_400.copyWith(color: AppColor.black2),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Owner Details',
              style: txt_14_600.copyWith(color: AppColor.black2),
            ),
            SizedBox(
              height: 8,
            ),
            BlocListener<AddOwnerDetailsBloc, AddOwnerDetailsState>(
              listener: (context, state) {
                if (state is AddOwnerDetailsSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Owner details added successfully')));
                } else if (state is AddOwnerDetailsFailure){
                  print(state.message);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)));
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.greyBorder),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.blueShade),
                  width: getWidth(context),
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textwithstar(label: 'Owner Name'),
                      SizedBox(
                        height: 8,
                      ),
                      DetailsField(
                        controller: _nameController,
                        hintText: 'Enter Full Name',
                        condition: true
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Textwithstar(label: 'Owner Number'),
                      SizedBox(
                        height: 8,
                      ),
                      DetailsField(
                        controller: _mobileNumberController,
                        hintText: 'Enter Mobile Number',
                        condition: true,
                        maxLengthCondition: true,
                      ),
                    ],
                  )),
            ),
            Spacer(),
            CustomizedButton(
                label: 'Save',
                onPressed: () {
                  final int numberLength = _mobileNumberController.text.length;
                  if (numberLength < 11 && _nameController.text.isNotEmpty) {
                    final details = AddOwnerdetailsModel(
                      flatId: widget.flatId, 
                      ownerPhoneNo: _mobileNumberController.text, 
                      ownerName: _nameController.text
                    );
                    context.read<AddOwnerDetailsBloc>().add(
                      AddDetailsEvent(flatDetails: details, apartmentId: widget.apartmentId)
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all required fields')));
                  }
                },
                style: txt_14_500.copyWith(color: AppColor.white1)),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
