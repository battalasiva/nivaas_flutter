import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/screens/auth/login/login.dart';
import 'package:nivaas/screens/auth/otp/bloc/otp_bloc.dart';
import 'package:nivaas/screens/auth/otp/otp_screen.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/phone_numberfield.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/constants/img_consts.dart';
import '../../../core/constants/text_styles.dart';
import '../../../widgets/elements/button.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  String otp ='';

  void _onSendOtpPressed(BuildContext context) {
    final mobileNumber = _numberController.text;
    final name = _nameController.text;
    if (mobileNumber.length == 10 && name.isNotEmpty) {
      context
          .read<OtpBloc>()
          .add(SendOtpEvent(mobileNumber: mobileNumber, name: name));
    } else if (mobileNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter valid mobile number')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter name')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.white,
        appBar: AppBar(
          backgroundColor: AppColor.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                backArrow,
                width: 24,
                height: 24,
              )),
        ),
        body: SafeArea(
            child: BlocListener<OtpBloc, OtpState>(
          listener: (context, state) {
            print('------------------$state');
            if (state is OtpSentSuccess) {
              otp = state.otp;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtpScreen(
                            mobileNumber: _numberController.text,
                            name: _nameController.text,
                            otp: otp,
                          )));
            } else if (state is OtpErrorDialogState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'This Mobile Number is already registered. Please log in instead.')));
            } else if (state is OtpErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 26),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GradientText('Create Profile',
                              gradient: AppGradients.gradient1, style: txt_18_700),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Let’s get to know each other',
                            style: txt_14_600.copyWith(color: AppColor.black),
                          ),
                          const SizedBox(height: 30),
                          Textwithstar(label: 'Your Name'),
                          const SizedBox(
                            height: 8,
                          ),
                          DetailsField(
                            controller: _nameController,
                            hintText: 'Full name',
                            image: Image.asset('assets/images/user.png'),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          Text(
                            'Email Address',
                            style: txt_12_700.copyWith(color: AppColor.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          DetailsField(
                            controller: _emailController,
                            hintText: 'Enter email address',
                            image: Image.asset('assets/images/mail.png'),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          Textwithstar(label: 'Phone Number'),
                          const SizedBox(
                            height: 8,
                          ),
                          PhoneNumberField(
                            controller: _numberController,
                          ),
                        ],
                      ),
                      SizedBox(height: getHeight(context)*0.2),
                      Padding(
                        // padding: const EdgeInsets.symmetric(vertical: 60),
                        padding: EdgeInsets.only(bottom: 40),
                        child: Column(
                          children: [
                            CustomizedButton(
                                label: 'Send OTP',
                                style: txt_16_500.copyWith(color: AppColor.white),
                                onPressed: () => _onSendOtpPressed(context)),
                            const SizedBox(
                              height: 6,
                            ),
                            Center(
                                child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Already have an account? ',
                                    style: txt_14_600.copyWith(
                                        color: AppColor.black)),
                                ShaderMask(
                                  shaderCallback: (bounds) {
                                    return AppGradients.gradient1
                                        .createShader(bounds);
                                  },
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    },
                                    child: Text(
                                      'Log in',
                                      style: txt_14_700.copyWith(
                                          color: AppColor.white),
                                    ),
                                  ),
                                )
                              ],
                            ))
                          ],
                        ),
                      ),
                    ]
                  ),
              )),
        )));
  }
}
