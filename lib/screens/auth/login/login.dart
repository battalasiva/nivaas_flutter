import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/gradients.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/auth/otp/bloc/otp_bloc.dart';
import 'package:nivaas/screens/auth/otp/otp_screen.dart';
import 'package:nivaas/screens/auth/signUp/signup.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/phone_numberfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _numberController = TextEditingController();
  String otp = '';

  void _onSendOtpPressed(BuildContext context) {
    final mobileNumber = _numberController.text;
    if (mobileNumber.length == 10) {
      context.read<OtpBloc>().add(SendOtpEvent(mobileNumber: mobileNumber));
    } else {
      CustomSnackbarWidget(
        context: context,
        title: 'Enter valid mobile number',
        backgroundColor: AppColor.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Column(
              children: [
                Container(
                  width: getWidth(context)*0.5,
                  height: getHeight(context) * 0.45,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const SizedBox(height: 27),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(
                      'Login',
                      gradient: AppGradients.gradient1,
                      style: txt_18_700,
                    ),
                    Text(
                      'Manage all your homes at one place',
                      style: txt_14_600.copyWith(color: AppColor.black),
                    ),
                    const SizedBox(height: 27),
                    Text(
                      'Phone Number',
                      style: txt_14_700.copyWith(color: AppColor.black),
                    ),
                    const SizedBox(height: 10),
                    PhoneNumberField(controller: _numberController),
                  ],
                ),
                const SizedBox(height: 20),
                BlocConsumer<OtpBloc, OtpState>(
                  listener: (context, state) {
                    if (state is OtpSentSuccess) {
                      otp = state.otp;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(
                            mobileNumber: _numberController.text,
                            otp: otp,
                          ),
                        ),
                      );
                    } else if (state is OtpErrorState) {
                      CustomSnackbarWidget(
                        context: context,
                        title: state.error,
                        backgroundColor: AppColor.red,
                      );
                    } else if (state is LoginOtpErrorState) {
                      CustomSnackbarWidget(
                        context: context,
                        title:
                            "You need to sign up before logging in. Please create an account first.",
                        backgroundColor: AppColor.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is OtpLoading;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          CustomizedButton(
                            label: isLoading ? 'Sending...' : 'Send OTP',
                            style: txt_16_500.copyWith(color: AppColor.white),
                            onPressed: isLoading
                                ? () {}
                                : () => _onSendOtpPressed(context),
                          ),
                          const SizedBox(height: 5),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Don’t have an account? ',
                                  style:
                                      txt_14_600.copyWith(color: AppColor.black),
                                ),
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
                                          builder: (context) => const Signup(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Signup Here',
                                      style: txt_14_700.copyWith(
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
