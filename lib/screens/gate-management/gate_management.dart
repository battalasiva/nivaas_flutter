import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/data/provider/network/api/gate-management/configured_visitors_datasource.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/gate-management/configured_visitors_repositoryimpl.dart';
import 'package:nivaas/domain/usecases/gate-management/configured_visitors_usecase.dart';
import 'package:nivaas/screens/gate-management/configuredVisitors/bloc/configured_visitors_bloc.dart';
import 'package:nivaas/screens/gate-management/configuredVisitors/configured_visitors.dart';
import 'package:nivaas/screens/gate-management/guestInvite/guestInvite.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../core/constants/text_styles.dart';
import '../../data/models/auth/current_customer_model.dart';

class GateManagement extends StatefulWidget {
  final CurrentCustomerModel user;
  const GateManagement({super.key, required this.user});

  @override
  State<GateManagement> createState() => _GateManagementState();
}

class _GateManagementState extends State<GateManagement>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Configure Pre-approve'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Apartment Details',
            //   style: txt_14_600.copyWith(color: AppColor.black2),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   decoration: BoxDecoration(color: AppColor.blueShade),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //         horizontal: 21, vertical: 15),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               'Apartment Name:',
            //               style:
            //                   txt_12_500.copyWith(color: AppColor.black2),
            //             ),
            //             Text(
            //               widget.user.currentApartment!.apartmentName,
            //               style: txt_14_600.copyWith(
            //                   color: AppColor.primaryColor1),
            //             )
            //           ],
            //         ),
            //         SizedBox(
            //           height: 5,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               'Flat Number:',
            //               style:
            //                   txt_12_500.copyWith(color: AppColor.black2),
            //             ),
            //             Text(
            //               widget.user.currentFlat!.flatNo,
            //               style: txt_14_600.copyWith(
            //                   color: AppColor.primaryColor1),
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20,),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Create Pre-approve',
                ),
                Tab(
                  text: 'Raised Requests',
                )
              ],
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(color: AppColor.primaryColor1, width: 3),
                  insets: const EdgeInsets.symmetric(horizontal: 100)),
            ),
            Flexible(
              child: TabBarView(controller: _tabController, children: [
                GuestInvite(
                  apartmentId: widget.user.currentApartment!.id,
                  flatId: widget.user.currentFlat!.id,
                ),
                BlocProvider(
                  create: (context) => ConfiguredVisitorsBloc(ConfiguredVisitorsUsecase(repository: 
                  ConfiguredVisitorsRepositoryimpl(datasource: ConfiguredVisitorsDatasource(apiClient: 
                  ApiClient()
                )))),
                  child: ConfiguredVisitors(
                    apartmentId: widget.user.currentApartment!.id,
                  flatId: widget.user.currentFlat!.id,
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
