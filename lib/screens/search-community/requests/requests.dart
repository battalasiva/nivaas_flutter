import 'package:flutter/material.dart';
import 'package:nivaas/screens/search-community/requests/flat_apartment_requests/flat_apartment_requests.dart';
import 'package:nivaas/screens/search-community/requests/my_requests/my_requests.dart';

import '../../../core/constants/colors.dart';
import '../../../widgets/elements/top_bar.dart';

class Requests extends StatefulWidget {
  final int flatId;
  final int apartmentId;
  final bool isOwner, isAdmin;
  const Requests({
    super.key,
    required this.flatId,
    required this.apartmentId,
    required this.isOwner,
    required this.isAdmin
  });

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    print('is Owner --- ${widget.isOwner}, isAdmin-------${widget.isAdmin}');
    _tabController = TabController(length: (widget.isOwner || widget.isAdmin) ? 2 : 1, vsync: this);
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
      appBar: const TopBar(title: 'Requests'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: (widget.isOwner || widget.isAdmin) ? const [
                Tab(text: 'Pending Requests',),
                Tab(text: 'My Requests',)
              ] : const [
                Tab(text: 'My Requests',),
              ],
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(color: AppColor.primaryColor1, width: 3),
                  insets: const EdgeInsets.symmetric(horizontal: 100)),
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController, 
                children: (widget.isOwner || widget.isAdmin) ? [
                  MyRequests(apartmentId: widget.apartmentId, flatId: widget.flatId, isAdmin: widget.isAdmin,),
                  FlatApartmentRequests()
                ] : [
                  FlatApartmentRequests(),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}