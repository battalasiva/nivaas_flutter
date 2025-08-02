import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/screens/complaints/raise-complaint/bloc/raise_complaint_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/build_dropdownfield.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/text_styles.dart';
import '../../../widgets/elements/button.dart';

class RaiseComplaint extends StatefulWidget {
  final int apartmentId;
  final int userId;
  const RaiseComplaint(
      {super.key, required this.apartmentId, required this.userId});

  @override
  State<RaiseComplaint> createState() => _RaiseComplaintState();
}

class _RaiseComplaintState extends State<RaiseComplaint> {
  final TextEditingController _msgController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  List<Map<String, dynamic>> users = [];
  String? selectedUser;
  int? selectedUserId;
  String? _attachedFileName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    context
        .read<RaiseComplaintBloc>()
        .add(FetchAdminsEvent(apartmentId: widget.apartmentId));
  }

  @override
  void dispose() {
    _msgController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _attachedFileName = result.files.single.name;
      });
    }
  }

  void _submitComplaint(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final payload = {
        "apartmentId": widget.apartmentId,
        "description": _msgController.text,
        "createdBy": widget.userId,
        "Type": "GENERAL",
        "assignTo": selectedUserId,
        "title": _titleController.text,
      };
      context
          .read<RaiseComplaintBloc>()
          .add(SubmitRaiseComplaintEvent(payload));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Raise A Complaint'),
      body: BlocConsumer<RaiseComplaintBloc, RaiseComplaintState>(
        listener: (context, state) {
          if (state is AdminsListLoaded) {
            setState(() {
              users = state.admins.map((admin) {
                return {'id': admin.id, 'fullName': admin.fullName};
              }).toList();
              if (users.isNotEmpty) {
                selectedUser = users[0]['fullName'];
                selectedUserId = users[0]['id'];
              }
              isLoading = false;
            });
          } else if (state is RaiseComplaintError) {
            setState(() {
              isLoading = false;
            });
            CustomSnackbarWidget(
                context: context,
                title: state.message,
                backgroundColor: AppColor.green);
          } else if (state is RaiseComplaintSuccess) {
            CustomSnackbarWidget(
                context: context,
                title: "Complaint Submitted Successfully",
                backgroundColor: AppColor.green);
            Navigator.of(context).pop(true);
          }
        },
        builder: (context, state) {
          return isLoading
              ? Center(
                  child: AppLoader(),
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context) * 0.07, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Assign To',
                              style:
                                  txt_14_600.copyWith(color: AppColor.black2),
                            ),
                            const SizedBox(height: 8),
                            if (users.isNotEmpty)
                              BuildDropDownField(
                                label: '',
                                items: users
                                    .map((user) =>
                                        user['fullName'] as String? ??
                                        "Unknown")
                                    .toList(),
                                onChanged: (String? userSelected) {
                                  setState(() {
                                    selectedUser = userSelected;
                                    selectedUserId = users.firstWhere((user) =>
                                        user['fullName'] == userSelected)['id'];
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
                            const SizedBox(height: 8),
                            Text(
                              'Title',
                              style:
                                  txt_14_600.copyWith(color: AppColor.black2),
                            ),
                            TextFormField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColor.greyBorder,
                                  ),
                                ),
                                hintText: 'Enter Title',
                                hintStyle:
                                    txt_14_500.copyWith(color: AppColor.grey),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Title is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Complaint',
                              style:
                                  txt_14_600.copyWith(color: AppColor.black2),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context) * 0.07),
                        child: Container(
                          height: getHeight(context) * 0.22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(
                                width: 0.8, color: AppColor.greyBorder),
                          ),
                          child: Stack(
                            children: [
                              TextFormField(
                                controller: _msgController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Describe Here..........',
                                  labelStyle: txt_14_500.copyWith(
                                      color: AppColor.greyText2),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                ),
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Complaint description is required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_attachedFileName != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          'Attached File: $_attachedFileName',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
        },
      ),
      bottomSheet: Container(
        color: AppColor.white,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: BlocConsumer<RaiseComplaintBloc, RaiseComplaintState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            return Padding(
              padding:  EdgeInsets.only(bottom:50),
              child: CustomizedButton(
                label: state is RaiseComplaintLoading ? 'Loading...' : 'Submit',
                style: txt_15_500.copyWith(color: AppColor.white),
                onPressed: state is RaiseComplaintLoading
                    ? () {}
                    : () => _submitComplaint(context),
              ),
            );
          },
        ),
      ),
    );
  }
}
