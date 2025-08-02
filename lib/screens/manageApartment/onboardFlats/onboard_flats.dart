import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/onboardflats_datasource.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/manageApartment/onboard_flats_repository_impl.dart';
import 'package:nivaas/domain/usecases/manageApartment/onboard_flats_usecase.dart';
import 'package:nivaas/screens/manageApartment/onboardFlats/bloc/onboard_flats_bloc.dart';
import 'package:nivaas/screens/manageApartment/onboardFlats/onboardFlatsWithDetails/onboard_flats_with_details.dart';
import 'package:nivaas/screens/manageApartment/onboardFlats/onboardFlatsWithoutDetails/onboard_flats_without_details.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/text_styles.dart';
import '../../../widgets/elements/short_button.dart';

class OnboardFlats extends StatefulWidget {
  final int apartmentId;
  const OnboardFlats({super.key, required this.apartmentId});

  @override
  State<OnboardFlats> createState() => _OnboardFlatsState();
}

class _OnboardFlatsState extends State<OnboardFlats>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedTab = 'Flat';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Onboard Flats'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: AppColor.greyBorder),
              ),
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: ShortButton(
                        label: 'Flat',
                        onPressed: () {
                          setState(() {
                            selectedTab = 'Flat';
                          });
                        },
                        style: txt_14_600.copyWith(
                            color: (selectedTab == 'Flat')
                                ? AppColor.white1
                                : AppColor.black2),
                        color: (selectedTab == 'Flat')
                            ? AppColor.primaryColor1
                            : AppColor.white),
                  ),
                  Expanded(
                    child: ShortButton(
                        label: 'Owner & Flat',
                        onPressed: () {
                          setState(() {
                            selectedTab = 'Owner & Flat';
                          });
                        },
                        style: txt_14_600.copyWith(
                            color: (selectedTab == 'Flat')
                                ? AppColor.black2
                                : AppColor.white1),
                        color: (selectedTab == 'Flat')
                            ? AppColor.white
                            : AppColor.primaryColor1),
                  ),
                ],
              ),
            ),
            Expanded(
              child: selectedTab == 'Flat'
                  ? BlocProvider.value(
                      value: BlocProvider.of<OnboardFlatsBloc>(context),
                      child: OnboardFlatsWithoutDetails(apartmentId: widget.apartmentId,),
                    )
                  : BlocProvider.value(
                      value: BlocProvider.of<OnboardFlatsBloc>(context),
                      child: OnboardFlatsWithDetails(apartmentId: widget.apartmentId,),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
