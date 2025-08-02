import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/core/utils/push-notifications/PushNotificationServices.dart';
import 'package:nivaas/data/provider/network/api/profile/editProfile_data_source.dart';
import 'package:nivaas/data/provider/network/api/profile/profile_upload_data_source.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/profile/editProfile_repository_impl.dart';
import 'package:nivaas/data/repository-impl/profile/upload_profile_repository_impl.dart';
import 'package:nivaas/screens/home-profile/edit-profile/bloc/edit_profile_bloc.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/TextInput.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class EditProfileScreen extends StatefulWidget {
  String? name, mobileNumber, email,gender;
  final int? id;
  final String? profilePic;
  EditProfileScreen({
    super.key,
    required this.name,
    required this.mobileNumber,
    required this.email,
    this.id,
    this.profilePic,
    this.gender,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  NotificationServices notificationServices = NotificationServices();
  File? _image;
  late TextEditingController _nameController,
      _mobileController,
      _emailController;
  String? _gender, fcmToken;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _mobileController = TextEditingController(text: widget.mobileNumber);
    _emailController = TextEditingController(text: widget.email);
    _image = null;
    _gender = widget.gender ?? '';
    // getDeviceFcmToken();
  }

  Future<void> getDeviceFcmToken() async {
    final token = await notificationServices.getDeviceToken();
    if (mounted) {
      setState(() {
        fcmToken = token ?? "";
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
      context
          .read<EditProfileBloc>()
          .add(UploadProfilePicture(File(pickedFile.path)));
      CustomSnackbarWidget(
        context: context,
        title: 'Profile Uploaded Successfully',
        backgroundColor: AppColor.blue,
      );
      Navigator.of(context).pop(true);
    }
  }

  void _onSaveChanges(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<EditProfileBloc>().add(EditProfileSubmitted(
            id: widget.id!.toString(),
            fullName: _nameController.text,
            email: _emailController.text,
            fcmToken: fcmToken.toString(),
            gender:_gender.toString(),
          ));
      setState(() {
        widget.name = _nameController.text;
        widget.email = _emailController.text;
        widget.mobileNumber = _mobileController.text;
      });
    }
  }

  Widget _buildDropdown() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Gender (Optional)',
          style: txt_14_600.copyWith(color: AppColor.black)),
      const SizedBox(height: 8),
      DropdownButtonFormField<String>(
        dropdownColor: AppColor.white,
        value: _gender!.isNotEmpty ? _gender : null,
        decoration: InputDecoration(
          hintText: 'Select Your Gender..',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
        items: ['Male', 'Female']
            .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender,
                      style: txt_14_400.copyWith(color: AppColor.black)),
                ))
            .toList(),
        onChanged: (value) => setState(() => _gender = value ?? ''),
      ),
    ],
  );
}


  Widget _buildProfileImage(BuildContext context) {
    return InkWell(
      onTap: () => _pickImage(context),
      child: Center(
        child: CircleAvatar(
          radius: 40,
          backgroundImage: _image != null
              ? FileImage(_image!)
              : (widget.profilePic != null
                  ? NetworkImage(widget.profilePic!)
                  : const AssetImage(defaultUser)) as ImageProvider,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => EditProfileBloc(
            editProfileRepository: EditProfileRepositoryImpl(
              dataSource: EditProfileDataSource(apiClient: ApiClient()),
            ),
            profilePicRepository: ProfilePicRepositoryImpl(
              dataSource: ProfilePicDataSource(apiClient: ApiClient()),
            ),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: const TopBar(title: 'Edit Profile'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileImage(context),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Textwithstar(label: 'Name'),
                    TextInputWidget(
                      controller: _nameController,
                      hint: 'Enter Your Name..',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Name is required'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Textwithstar(label: 'Mobile Number'),
                    TextInputWidget(
                      controller: _mobileController,
                      readOnly: true,
                      keyboardType: TextInputType.phone,
                      hint: 'Enter Your Mobile Number...',
                    ),
                    const SizedBox(height: 16),
                    Textwithstar(label: 'Email'),
                    TextInputWidget(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hint: 'Enter Your Email...',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(value.trim())) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomSheet: BlocConsumer<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileSuccess) {
              CustomSnackbarWidget(
                context: context,
                title: 'Updated Successfully',
                backgroundColor: AppColor.green,
              );
              Navigator.of(context).pop(true);
            } else if (state is EditProfileFailure) {
              CustomSnackbarWidget(
                context: context,
                title: state.error,
                backgroundColor: AppColor.red,
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is EditProfileLoading;
            return Container(
              color: AppColor.white,
              padding: const EdgeInsets.only(bottom: 50, right: 20, left: 20),
              child: CustomizedButton(
                label: isLoading ? 'Saving...' : 'SAVE',
                style: txt_15_500.copyWith(color: AppColor.white),
                onPressed: isLoading ? () {} : () => _onSaveChanges(context),
              ),
            );
          },
        ),
      ),
    );
  }
}
