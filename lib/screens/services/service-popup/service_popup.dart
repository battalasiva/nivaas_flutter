import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/services/service-popup/bloc/add_service_provider_bloc.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/TextInput.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';

class ServicePopup extends StatefulWidget {
  final String? serviceName;
  final int? apartmentId, categoryId;

  const ServicePopup(
      {super.key, this.serviceName, this.categoryId, this.apartmentId});

  @override
  State<ServicePopup> createState() => _ServicePopupState();
}

class _ServicePopupState extends State<ServicePopup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _addServiceProvider() {
    if (_formKey.currentState!.validate()) {
      final payload = {
        "apartmentId": widget.apartmentId,
        "categoryId": widget.categoryId,
        "primaryContact": _mobileController.text.trim(),
        "name": _nameController.text.trim(),
      };
      print('payload:$payload');
      context
          .read<AddServiceProviderBloc>()
          .add(AddServiceProviderRequested(payload));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '     ${widget.serviceName}',
                        style: txt_16_700.copyWith(color: AppColor.black2),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColor.black1),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Textwithstar(label: 'Name '),
              TextInputWidget(
                controller: _nameController,
                readOnly: false,
                keyboardType: TextInputType.text,
                hint: 'Enter Name...',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please Enter Name' : null,
              ),
              const SizedBox(height: 12),
              Textwithstar(label: 'Mobile Number '),
              TextInputWidget(
                controller: _mobileController,
                readOnly: false,
                keyboardType: TextInputType.phone,
                hint: 'Enter Mobile Number...',
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Mobile Number';
                  } else if (value.length < 10) {
                    return 'Mobile number must be 10 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              BlocConsumer<AddServiceProviderBloc, AddServiceProviderState>(
                listener: (context, state) {
                  if (state is AddServiceProviderSuccess) {
                    CustomSnackbarWidget(
                      context: context,
                      title: state.message,
                      backgroundColor: AppColor.green,
                    );
                    Navigator.pop(context);
                  } else if (state is AddServiceProviderFailure) {
                    CustomSnackbarWidget(
                      context: context,
                      title: state.error,
                      backgroundColor: AppColor.red,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomizedButton(
                    label: state is AddServiceProviderLoading
                        ? "Adding..."
                        : "ADD",
                    onPressed: state is AddServiceProviderLoading
                        ? () {}
                        : _addServiceProvider,
                    style: txt_14_500.copyWith(color: AppColor.white1),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
