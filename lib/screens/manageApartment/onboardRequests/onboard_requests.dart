import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/screens/manageApartment/pendingOnboardRequests/pending_onboard_requests.dart';
import 'package:nivaas/screens/manageApartment/onboardRequests/rejectedOnboardRequests/rejected_onboard_requests.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/text_styles.dart';
import '../../../widgets/elements/short_button.dart';

class OnboardRequests extends StatefulWidget {
  final int apartmentId;
  const OnboardRequests({super.key, required this.apartmentId});

  @override
  State<OnboardRequests> createState() => _OnboardRequestsState();
}

class _OnboardRequestsState extends State<OnboardRequests> {
  String selectedTab = 'Pending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Onboard Flats'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.blueShade,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: AppColor.greyBorder),
              ),
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: ShortButton(
                        label: 'Pending',
                        onPressed: () {
                          setState(() {
                            selectedTab = 'Pending';
                          });
                        },
                        style: txt_14_600.copyWith(
                            color: (selectedTab == 'Pending')
                                ? AppColor.white1
                                : AppColor.black2),
                        color: (selectedTab == 'Pending')
                            ? AppColor.primaryColor1
                            : AppColor.blueShade),
                  ),
                  Expanded(
                    child: ShortButton(
                        label: 'Rejected',
                        onPressed: () {
                          setState(() {
                            selectedTab = 'Rejected';
                          });
                        },
                        style: txt_14_600.copyWith(
                            color: (selectedTab == 'Pending')
                                ? AppColor.black2
                                : AppColor.white1),
                        color: (selectedTab == 'Pending')
                            ? AppColor.blueShade
                            : AppColor.primaryColor1),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: selectedTab == 'Pending'
            //       ? PendingOnboardRequests()
            //       : RejectedOnboardRequests()
            // ),
          ],
        ),
      ),
    );
  }
}
