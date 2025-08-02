import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/manageApartment/flatmembers_details_model.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';

import '../../../core/constants/colors.dart';
import '../../../data/models/manageApartment/flats_model.dart';
import 'bloc/flatmember_details_bloc.dart';

class EditFlatMemberDetails extends StatefulWidget {
  final FlatsModel flat;
  final  int apartmentId;
  final bool canEdit;
  const EditFlatMemberDetails({super.key, required this.flat, required this.apartmentId, required this.canEdit});

  @override
  State<EditFlatMemberDetails> createState() => _EditFlatMembersDetailsState();
}

class _EditFlatMembersDetailsState extends State<EditFlatMemberDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController flatNo = TextEditingController();

  bool isEditable = false;

  @override
  void initState() {
    name = TextEditingController(
      text: widget.flat.name,
    );
    mobileNumber = TextEditingController(text: widget.flat.contactNumber);
    flatNo = TextEditingController(text: widget.flat.flatNo);
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    mobileNumber.dispose();
    flatNo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.flat.residentType;
    return BlocConsumer<FlatmemberDetailsBloc, FlatmemberDetailsState>(
      listener: (context, state) {
        print('----state is $state');
        if (state is FlatmemberDetailsLoading) {
          Center(child: AppLoader());
        } else if(state is UpdateFlatmemberDetailsSuccess){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Details updated successfully!'),
          ));
          setState(() {
            isEditable = false;
          });
          Navigator.pop(context, 'success');
        } else if(state is RemoveFlatmemberDetailsSuccess){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Removed member successfully!'),
          ));
          setState(() {
            isEditable = false;
          });
          Navigator.pop(context,'success');
        } else if(state is FlatmemberDetailsFailure){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));
          print('-------failure : ${state.errorMessage}');
        }
      },
      builder: (context, state) {
        return Container(
          height:isEditable? getHeight(context) * 0.65 : getHeight(context)*0.55,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
          child: ListView(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Member Details',
                          style: txt_15_600.copyWith(color: AppColor.black2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Textwithstar(label: 'Name'),
                            SizedBox(
                              height: 8,
                            ),
                            DetailsField(
                              controller: name,
                              hintText: widget.flat.name,
                              condition: isEditable,
                              hintStyle:
                                  txt_12_500.copyWith(color: AppColor.black2),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Textwithstar(label: 'Mobile Number'),
                            SizedBox(
                              height: 8,
                            ),
                            DetailsField(
                              controller: mobileNumber,
                              hintText: widget.flat.contactNumber,
                              condition: isEditable,
                              hintStyle:
                                  txt_12_500.copyWith(color: AppColor.black2),
                              isOnlyNumbers: true,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Textwithstar(label: 'Flat Number'),
                            SizedBox(
                              height: 8,
                            ),
                            DetailsField(
                              controller: flatNo,
                              hintText: widget.flat.flatNo,
                              condition: isEditable,
                              hintStyle:
                                  txt_12_500.copyWith(color: AppColor.black2),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Relationship',
                              style: txt_14_600.copyWith(color: AppColor.black2),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: getWidth(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.greyBorder),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                role == 'TENANT'
                                    ? 'Tenant'
                                    : role == 'FLAT_OWNER'
                                        ? 'Owner'
                                        : 'Family Member',
                                style:
                                    txt_13_400.copyWith(color: AppColor.greyText1),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            isEditable
                                ? CustomizedButton(
                                    label: 'Save',
                                    onPressed: () {
                                      final details = FlatmembersDetailsModel(
                                        flatNo: flatNo.text, 
                                        ownerPhoneNo: mobileNumber.text, 
                                        ownerName: name.text
                                      );
                                      if (flatNo.text.isEmpty || mobileNumber.text.isEmpty || name.text.isEmpty) {
                                        print("Please fill in all fields.");
                                        return; 
                                      }
                                      context.read<FlatmemberDetailsBloc>().add(
                                        UpdateFlatmemberDetailsEvent(
                                          details: details, 
                                          apartmentId: widget.apartmentId, flatId: widget.flat.flatId
                                        )
                                      );
                                    },
                                    style:
                                        txt_14_500.copyWith(color: AppColor.white1))
                                : SizedBox(),
                            (role == 'TENANT' && isEditable)
                                ? Center(
                                    child: TextButton(
                                        onPressed: () {
                                          context.read<FlatmemberDetailsBloc>().add(
                                            RemoveFlatmemberEvent(
                                              relatedUserId: widget.flat.userId, 
                                              onboardingRequestId: widget.flat.id
                                            )
                                          );
                                        },
                                        child: Text(
                                          'Remove Member',
                                          style: txt_14_600.copyWith(
                                              color: AppColor.red),
                                        )),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(widget.canEdit)
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
                          )))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
