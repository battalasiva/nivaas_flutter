import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/gradients.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/search-community/communityAndRequest/community_and_request.dart';
import 'package:nivaas/screens/auth/splashScreen/bloc/splash_bloc.dart';
import 'package:nivaas/widgets/elements/TopSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/bottom_tab.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/textwithstar.dart';
import 'package:pinput/pinput.dart';
import 'bloc/otp_bloc.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String? name;
  final String otp;
  const OtpScreen({super.key, required this.mobileNumber, this.name, required this.otp,});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var otpValue = '';
  int _start = 59;
  late Timer _timer;
  bool _isResendVisible = false;
  String source ='';
  String buttonLabel = 'Proceed';

  void _onProceedPressed(BuildContext context) {
    // print('otp submitted');
    final otp = _otpController.text;
    context.read<OtpBloc>().add(VerifyOtpEvent(
        name: widget.name, mobileNumber: widget.mobileNumber, otp: otp));
    print('VerifyOtpEvent dispatched');
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendVisible = true;
        });
        _timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _sendOtpEvent() {
    context.read<OtpBloc>().add(SendOtpEvent(
          mobileNumber: widget.mobileNumber,
        ));
    setState(() {
      _start = 59;
      _isResendVisible = false;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpVerifiedSuccess) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Otp verified Success')),
          // );
          context.read<SplashBloc>().add(CheckTokenEvent());
          print('--------CheckTokenEvent dispatched');
        } else if (state is OtpErrorDialogState) {
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: Text(state.message)));
        } else if (state is OtpErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is VerifyOtpErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 26),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GradientText('Verify mobile number',
                            gradient: AppGradients.gradient1, style: txt_18_700),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'OTP has sent to ${widget.mobileNumber}',
                          style: txt_14_700.copyWith(color: AppColor.black),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(widget.otp),
                        Text(
                          'Enter OTP',
                          style: txt_12_700.copyWith(color: AppColor.black),
                        ),
                        const SizedBox(height: 8),
                        Form(
                          key: _formKey,
                          child: Pinput(
                            length: 6,
                            autofocus: true,
                            onChanged: (value) => otpValue,
                            controller: _otpController,
                            pinAnimationType: PinAnimationType.fade,
                            animationCurve: Curves.easeIn,
                            obscureText: false,
                            defaultPinTheme: PinTheme(
                              height: 60,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black),
                                color: Colors.grey[200],
                              ),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'OTP is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Text(
                              'Didn’t Receive The Otp? ',
                              style: txt_14_500.copyWith(color: AppColor.black),
                            ),
                            _isResendVisible
                                ? TextButton(
                                    onPressed: _sendOtpEvent,
                                    child: Text(
                                      'Resend Otp',
                                      style: txt_14_700.copyWith(
                                          color: AppColor.primaryColor1),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Text('Resend in '),
                                      Text(
                                        _start < 10 ? "00:0$_start" : "00:$_start",
                                        style: txt_14_700.copyWith(
                                            color: AppColor.primaryColor1),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: getHeight(context)*0.3),
                    // const Spacer(),
                    BlocListener<SplashBloc, SplashState>(
                      listener: (context, state) {
                        print('SplashBloc state: $state');
                        if (state is SplashSuccess) {
                          print('Navigating to BottomTab');
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomTab()),
                            (route) => false,
                          );
                        } else if (state is SplashApartmentNotFound) {
                          print('Navigating to CommunityAndRequest');
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CommunityAndRequest(source: 'signup')),
                            (route) => false,
                          );
                        } else if (state is SplashFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if(state is SplashLoading){
                          buttonLabel = 'Logging in...';
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 95),
                        child: CustomizedButton(
                            label: buttonLabel,
                            style: txt_16_500.copyWith(color: AppColor.white),
                            onPressed: () {
                              _onProceedPressed(context);
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void _showDialog(BuildContext context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          content: SizedBox(
            width: getWidth(context)*0.8,
            height: 180,
            child: Column(
              children: [
                Textwithstar(label: 'Name'),
                SizedBox(height: 8,),
                DetailsField(
                  controller: _nameController, 
                  hintText: 'Enter Full Name', 
                  condition: true
                ),
                SizedBox(height: 25,),
                CustomizedButton(
                  label: 'Continue', 
                  onPressed: (){
                    final otp = _otpController.text;
                    if(_nameController.text.isNotEmpty){
                      context.read<OtpBloc>().add(VerifyOtpEvent(
                        name: _nameController.text, mobileNumber: widget.mobileNumber, otp: otp));
                    } else {
                      TopSnackbarWidget.showTopSnackbar(
                        context: context,
                        message: "Please Enter Name"
                      );
                    }
                  }, 
                  style: txt_16_500.copyWith(color: AppColor.white)
                )
              ],
            ),
          ),
        );
      }
    );
  }
}