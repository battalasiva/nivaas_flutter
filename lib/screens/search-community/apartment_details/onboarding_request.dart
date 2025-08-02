import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/search-community/communityAndRequest/community_and_request.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/colors.dart';
import '../../../data/models/auth/current_customer_model.dart';
import '../../auth/splashScreen/bloc/splash_bloc.dart';

class OnboardingRequest extends StatelessWidget {
  final String source;
  OnboardingRequest({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: '', isLeading: false,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                BlocBuilder<SplashBloc, SplashState>(
                  builder: (context, state) {
                    if (state is SplashApartmentNotFound) {
                      CurrentCustomerModel currentUser = state.user;
                      if (currentUser.user.name.isEmpty) {
                        return Center(child: Text("No name available"));
                      }
                      return Text(
                        'Hi ${currentUser.user.name}',
                        style:
                            txt_17_700.copyWith(color: AppColor.primaryColor2),
                      );
                    } else if(state is SplashFailure){
                      return Center(child: Text(state.message));
                    } else if (state is SplashSuccess) {
                      CurrentCustomerModel currentUser = state.user;
                      if (currentUser.user.name.isEmpty) {
                        return Center(child: Text("No name available"));
                      }
                      return Text(
                        'Hi ${currentUser.user.name}',
                        style:
                            txt_17_700.copyWith(color: AppColor.primaryColor2),
                      );
                    } 
                    else if (state is SplashFailure) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return Center(child: AppLoader());
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  (source == 'flat') ?
                  'Your Request To Join Has Been Submitted To The \nManagement/Owner For Approval.'
                  : 'Your Request To Onboard Apartment Has Been \nSubmitted To The Management For Approval.',
                  style: txt_12_400.copyWith(color: AppColor.black2),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            CustomizedButton(
                label: 'Done',
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommunityAndRequest(source: source,)));
                },
                style: txt_16_500.copyWith(color: AppColor.white)),
          ],
        ),
      ),
    );
  }
}
