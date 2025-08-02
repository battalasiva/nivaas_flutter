import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/enums.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/complaints/raise-complaint/bloc/raise_complaint_bloc.dart';
import 'package:nivaas/screens/complaints/view-complaints/bloc/view_complaints_bloc.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/TextInput.dart';
import 'package:nivaas/widgets/elements/build_dropdownfield.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/toggleButton.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';

class ViewComplaints extends StatefulWidget {
  final String createdDate;
  final String title;
  final String description;
  final int id;
  final int apartmentId;
  final String? status, currentApartment;
  final bool? isAdmin, isOwner,isLeftSelected;
  const ViewComplaints({
    super.key,
    required this.createdDate,
    required this.title,
    required this.description,
    required this.id,
    required this.apartmentId,
    this.status,
    this.isAdmin,
    this.isOwner,
    this.currentApartment,
    this.isLeftSelected,
  });

  @override
  State<ViewComplaints> createState() => _ViewComplaintsState();
}

class _ViewComplaintsState extends State<ViewComplaints> {
  List<Map<String, dynamic>> admins = [];
  List<Map<String, dynamic>> owners = [];

  String? selectedUser;
  int? selectedUserId;
  String? selectedStatus;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController, _descriptionController;
  bool showPaid = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    context.read<RaiseComplaintBloc>().add(FetchAdminsEvent(apartmentId: widget.apartmentId));
    context.read<ViewComplaintsBloc>().add(FetchOwnersListEvent(widget.apartmentId, 0, 50));
    selectedStatus = widget.status;
  }

  void submitComplaint() {
      if (_formKey.currentState!.validate()) {
        context.read<ViewComplaintsBloc>().add(
              ReassignComplaintEvent(
                id: widget.id,
                status: selectedStatus ?? widget.status ?? '',
                assignedTo: selectedUserId.toString(),
                isAdmin: widget.isAdmin,
              ),
            );
      }
    // } else {
    //   CustomSnackbarWidget(
    //     context: context,
    //     title: "You don't have access to edit",
    //     backgroundColor: AppColor.orange,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'View Complaints'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth(context) * 0.05,
          vertical: 5,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Apartment Details',
                style: txt_14_600.copyWith(color: AppColor.black2),
              ),
              const SizedBox(height: 5),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.blueShade,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Created On :",
                            style: txt_10_500.copyWith(color: AppColor.black2),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Apartment Name : ",
                            style: txt_12_500.copyWith(color: AppColor.black2),
                          ),
                          // const SizedBox(height: 4),
                          // Text(
                          //   "Raised By : ",
                          //   style: txt_12_500.copyWith(color: AppColor.black2),
                          // ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formatDate(widget.createdDate),
                            style: txt_14_600.copyWith(color: AppColor.blue),
                          ),
                          Text(
                            widget.currentApartment ?? '',
                            style: txt_14_600.copyWith(color: AppColor.blue),
                          ),
                          // Text(
                          //   "Owner",
                          //   style: txt_14_600.copyWith(color: AppColor.blue),
                          // ),
                          // const SizedBox(height: 4),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Complaint Details',
                style: txt_14_600.copyWith(color: AppColor.black),
              ),
              const SizedBox(height: 10),
              TextInputWidget(
                label: 'Title',
                controller: _titleController,
                keyboardType: TextInputType.phone,
                readOnly: true,
                hint: 'Enter Your Mobile Number...',
              ),
              const SizedBox(height: 10),
              TextInputWidget(
                label: 'Description',
                controller: _descriptionController,
                keyboardType: TextInputType.phone,
                readOnly: true,
                hint: 'Enter Your Description...',
              ),
              const SizedBox(height: 10),
              if (widget.isAdmin ?? false) ...[
                Text(
                  'Re-Assign To',
                  style: txt_14_600.copyWith(color: AppColor.black2),
                ),
                const SizedBox(height: 10),
                ToggleButtonWidget(
                  leftTitle: "Admin's",
                  rightTitle: "Owner's",
                  isLeftSelected: !showPaid,
                  onChange: (isLeft) => setState(() {
                    showPaid = !isLeft;
                    selectedUser = null;
                    selectedUserId = null;
                  }),
                ),
                const SizedBox(height: 15),
                BlocListener<RaiseComplaintBloc, RaiseComplaintState>(
                  listener: (context, state) {
                    if (state is AdminsListLoaded) {
                      setState(() {
                        admins = state.admins.map((admin) {
                          return {'id': admin.id, 'fullName': admin.fullName};
                        }).toList();
                      });
                    }
                  },
                  child: BlocListener<ViewComplaintsBloc, ViewComplaintsState>(
                    listener: (context, state) {
                      if (state is OwnersListLoaded) {
                        setState(() {
                          owners = state.owners.map((owner) {
                            return {'id': owner.id, 'fullName': owner.fullName};
                          }).toList();
                        });
                      }
                    },
                    child: BuildDropDownField(
                      label: showPaid
                          ? 'Select Owner To Re-Assign'
                          : 'Select Admin To Re-Assign',
                      items: (showPaid ? owners : admins)
                          .map((user) => user['fullName'] as String? ?? "")
                          .toList(),
                      onChanged: (String? userSelected) {
                        setState(() {
                          selectedUser = userSelected;
                          selectedUserId =
                              (showPaid ? owners : admins).firstWhere(
                            (user) => user['fullName'] == userSelected,
                          )['id'];
                        });
                      },
                      value: selectedUser,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a user';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 15),
              Text(
                'Update Status',
                style: txt_14_600.copyWith(color: AppColor.black2),
              ),
              const SizedBox(height: 5),
              BuildDropDownField(
                label: 'Select',
                items: complaintStatusTypes
                    .map((status) => status['name'] ?? "")
                    .toList(),
                onChanged: (String? statusSelected) {
                  setState(() {
                    selectedStatus = statusSelected;
                  });
                },
                value: selectedStatus,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a status';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColor.white,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: BlocConsumer<ViewComplaintsBloc, ViewComplaintsState>(
          listener: (context, state) {
            if (state is ReassignComplaintSuccess) {
              CustomSnackbarWidget(
                context: context,
                title: 'Complaint Submitted successfully!',
                backgroundColor: AppColor.green,
              );
              Navigator.of(context).pop(true);
            } else if (state is ReassignComplaintFailure) {
              CustomSnackbarWidget(
                context: context,
                title: 'Failed to Submit complaint.',
                backgroundColor: AppColor.red,
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: CustomizedButton(
                label: (state is ReassignComplaintLoading)
                    ? 'Submitting...'
                    : 'Submit',
                style: txt_14_500.copyWith(color: AppColor.white),
                onPressed: 
                     submitComplaint
                    // : () {
                    //     CustomSnackbarWidget(
                    //       context: context,
                    //       title: "You don't have access to edit",
                    //       backgroundColor: AppColor.,
                    //     );
                    //   },
              ),
            );
          },
        ),
      ),
    );
  }
}
