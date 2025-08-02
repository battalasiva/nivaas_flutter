import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/data/provider/network/api/gate-management/visitors_history_datasource.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/gate-management/visitors_history_repository_impl.dart';
import 'package:nivaas/domain/usecases/gate-management/visitors_history_usecase.dart';
import 'package:nivaas/screens/gate-management/AddManualTab.dart';
import 'package:nivaas/screens/gate-management/ContactsTab.dart';
import 'package:nivaas/screens/gate-management/recents-tab/bloc/visitors_history_bloc.dart';
import 'package:nivaas/screens/gate-management/recents-tab/RecentsTab.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class SelectGuestsTabBarScreen extends StatefulWidget {
  final int apartmentId, flatId;
  final Map<String, Object?>? payload;
  const SelectGuestsTabBarScreen({
    super.key, required this.apartmentId, required this.flatId,this.payload
  });

  @override
  _SelectGuestsTabBarScreenState createState() =>
      _SelectGuestsTabBarScreenState();
}

class _SelectGuestsTabBarScreenState extends State<SelectGuestsTabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Select guests'),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: AppColor.blue,
            unselectedLabelColor: AppColor.grey,
            indicatorColor: AppColor.blue,
            tabs: const [
              Tab(text: 'Contacts'),
              Tab(text: 'Recents'),
              Tab(text: 'Add Manually'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ContactsTab(payload : widget.payload),
                BlocProvider(
                  create: (context) => VisitorsHistoryBloc(VisitorsHistoryUsecase(repository: 
                    VisitorsHistoryRepositoryImpl(datasource: VisitorsHistoryDatasource(apiClient: ApiClient()))
                  )),
                  child: RecentsTab(apartmentId: widget.apartmentId, flatId: widget.flatId,payload:widget.payload),
                ),
                AddManuallyTab(payload : widget.payload),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
