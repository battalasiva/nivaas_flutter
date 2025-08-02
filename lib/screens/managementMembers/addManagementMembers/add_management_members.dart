import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/managementMembers/coAdmin/add_coadmin_model.dart';
import 'package:nivaas/data/models/managementMembers/security/add_security_model.dart';
import 'package:nivaas/screens/managementMembers/addManagementMembers/bloc/add_management_members_bloc.dart';
import 'package:nivaas/widgets/elements/build_dropdownfield.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class AddManagementMembers extends StatefulWidget {
  final int apartmentId;
  const AddManagementMembers({super.key, required this.apartmentId});

  @override
  State<AddManagementMembers> createState() => _AddManagementMembersState();
}

class _AddManagementMembersState extends State<AddManagementMembers> {
  String? selectedRole;
  final TextEditingController name = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  String? selectedmember , selectedContact;
  int? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Add management Member'),
      body: BlocListener<AddManagementMembersBloc, AddManagementMembersState>(
        listener: (context, state) {
          print('-------$state');
          if (state is CoAdminFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
            );
          } else if(state is AddCoAdminLoading || state is AddSecurityLoading){
            Center(child: CircularProgressIndicator());
          }else if(state is AddCoAdminSuccess || state is AddSecuritySuccess){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(
                  selectedRole == 'Co-Admin' ? "Co-Admin is added successfully" 
                    : "Security is added successfully"
                )),
            );
            Navigator.pop(context, 'success');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Role',
                style: txt_14_600.copyWith(color: AppColor.black2),
              ),
              SizedBox(
                height: 8,
              ),
              BuildDropDownField(
                label: 'Select Role', 
                items: ['Co-Admin', 'Security'], 
                onChanged: (value){
                  setState(() {
                    selectedRole = value;
                    if (selectedRole == 'Co-Admin') {
                      context.read<AddManagementMembersBloc>().add(FetchOwnersListEvent(
                        apartmentID: widget.apartmentId
                      ));
                    }
                  });
                }, 
                value: selectedRole
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Member Name',
                style: txt_14_600.copyWith(color: AppColor.black2),
              ),
              SizedBox(
                height: 8,
              ),
              selectedRole == 'Co-Admin' ?
               BlocBuilder<AddManagementMembersBloc, AddManagementMembersState>(
                  builder: (context, state) {
                    if (state is OwnersListLoading) {
                      return CircularProgressIndicator();
                    } else if(state is CoAdminFailure){
                      print(state.message);
                      return Center(child: Text(state.message));
                    } else if (state is OwnersListLoaded) {
                      if (state.details.content.isEmpty) {
                        return Text(
                            'Owners are not added yet');
                      }
                      List<String> ownerDetails = state.details.content
                        .where((flat) => flat.owner.roles.contains("ROLE_FLAT_OWNER"))
                        .map((flat) => '${flat.owner.name}, ${flat.flatNumber}').toSet().toList();
                      return BuildDropDownField(
                        label: 'Choose Flat member',
                        items: ownerDetails,
                        value: selectedmember ?? '',
                        onChanged: (value) {
                          setState(() {
                            selectedmember = value;
                            final selectedUser = state.details.content.firstWhere(
                              (flat) => '${flat.owner.name}, ${flat.flatNumber}' == selectedmember,).owner;
                            selectedContact = selectedUser.mobileNumber;
                            userId = selectedUser.id;
                          });
                        },
                      );
                    }  else {
                      return SizedBox();
                    }
                  },
                )
                : DetailsField(
                  controller: name, hintText: 'Enter name', condition: true
                ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Mobile Number',
                style: txt_14_600.copyWith(color: AppColor.black2),
              ),
              SizedBox(
                height: 8,
              ),
              selectedRole == 'Co-Admin' ? Container(
                width: getWidth(context),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColor.greyBorder
                  )
                ),
                child: Text(selectedContact ?? 'Enter Phone Number')
              ):
              DetailsField(
                controller: mobileNumber, 
                hintText: 'Enter Phone Number', 
                condition: true,
                maxLengthCondition: true,
                isOnlyNumbers: true,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 85),
                child: CustomizedButton(
                    label: 'Save',
                    onPressed: () {
                      if (selectedRole == 'Co-Admin') {
                        final details =
                            AddCoAdminModel(apartmentId: widget.apartmentId, userId: userId!, userRole: 'ROLE_APARTMENT_ADMIN');
                        print('details in ui: $details');
                        context
                            .read<AddManagementMembersBloc>()
                            .add(AddCoAdminEvent(details: details));
                      } else if (selectedRole == 'Security') {
                        final details =
                            AddSecurityModel(
                              apartmentId: widget.apartmentId, 
                              helpers: [Helper(number: mobileNumber.text, name: name.text)]
                            );
                        print('details in ui: $details');
                        context
                            .read<AddManagementMembersBloc>()
                            .add(AddSecurityEvent(details: details));
                      }
                    },
                    style: txt_16_500.copyWith(color: AppColor.white1)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
