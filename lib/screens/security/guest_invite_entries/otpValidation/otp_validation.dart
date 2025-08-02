import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/bottom_tab.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../../core/constants/colors.dart';
import 'bloc/otp_validation_bloc.dart';

class OtpValidation extends StatelessWidget {
  final int requestId;
  OtpValidation({super.key, required this.requestId});
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Guest Invite Entries'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Guest OTP',
                  style: txt_14_600.copyWith(color: AppColor.black2),
                ),
                SizedBox(
                  height: 8,
                ),
                DetailsField(
                  controller: otpController,
                  hintText: 'Enter Invite Otp',
                  condition: true,
                  isOnlyNumbers: true,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: BlocListener<OtpValidationBloc, OtpValidationState>(
                listener: (context, state) {
                  if (state is OtpValidationLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                      content: Text('Otp validated successfully')));
                    Navigator.push(context,MaterialPageRoute(
                      builder:(context) => BottomTab()),
                    );
                  } else if(state is OtpValidationFailure){
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                      content: Text(state.message)));
                  }
                },
                child: CustomizedButton(
                  label: 'Validate OTP',
                  onPressed: () {
                    context.read<OtpValidationBloc>().add(OtpValidateEvent(requestId: requestId, otp: otpController.text));
                  },
                  style: txt_14_500.copyWith(color: AppColor.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
