import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/all_flats_datasource.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/manageApartment/all_flats_repository_impl.dart';
import 'package:nivaas/domain/usecases/manageApartment/all_flats_usecase.dart';
import 'package:nivaas/screens/manage-flats/flatOverview/flat_overview.dart';
import 'package:nivaas/screens/manage-flats/flatView/flatManage/editFlatDetails/bloc/flat_details_bloc.dart';
import 'package:nivaas/screens/manage-flats/flatView/flatManage/flatSaleOrRent/bloc/flat_sale_or_rent_bloc.dart';
import 'package:nivaas/screens/manage-flats/flatView/flatManage/flat_details.dart';
import 'package:nivaas/screens/manageApartment/bloc/all_flats_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../../data/provider/network/api/manageFlats/flat_details_data_source.dart';
import '../../../data/provider/network/api/manageFlats/flat_sale_rent_datasource.dart';
import '../../../data/repository-impl/manageFlats/flat_details_repository_impl.dart';
import '../../../data/repository-impl/manageFlats/flat_sale_rent_repository_impl.dart';
import '../../../domain/usecases/manageFlats/flat_details_usecase.dart';
import '../../../domain/usecases/manageFlats/flat_sale_rent_usecase.dart';
import '../../auth/splashScreen/bloc/splash_bloc.dart';

class FlatView extends StatefulWidget {
  const FlatView({
    super.key,
  });

  @override
  State<FlatView> createState() => _FlatViewState();
}

class _FlatViewState extends State<FlatView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final flatDetailsUseCase = FlatDetailsUsecase(
      repository: FlatDetailsRepositoryImpl(
          dataSource: FlatDetailsDataSource(apiClient: ApiClient())));

  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(CheckTokenEvent());
    _tabController = TabController(length: 2, vsync: this);
  }
   Future<void> fetchCurrentCustomer() async {
    context.read<SplashBloc>().add(CheckTokenEvent());
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
      appBar: const TopBar(title: 'Manage Flat'),
      body: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is SplashLoading) {
            return Center(child: AppLoader());
          }else if(state is SplashFailure){
            return RefreshIndicator(
              onRefresh: fetchCurrentCustomer,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: getHeight(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text(state.message)),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is SplashSuccess) {
            final int flatId = state.user.currentFlat?.id ?? 0;
            final int apartmentId = state.user.currentApartment?.id ?? 0;
            final bool isOwner = state.user.user.roles.contains("ROLE_FLAT_OWNER");
            final List<String> roles = state.user.user.roles;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apartment Details',
                    style: txt_14_600.copyWith(color: AppColor.black2),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(color: AppColor.blueShade),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 21, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Apartment Name:',
                                style:
                                    txt_12_500.copyWith(color: AppColor.black2),
                              ),
                              Text(
                                state.user.currentApartment?.apartmentName ??
                                    'NA',
                                style: txt_14_600.copyWith(
                                    color: AppColor.primaryColor1),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Flat Number:',
                                style:
                                    txt_12_500.copyWith(color: AppColor.black2),
                              ),
                              Text(
                                state.user.currentFlat?.flatNo ?? 'NA',
                                style: txt_14_600.copyWith(
                                    color: AppColor.primaryColor1),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(
                        text: 'Overview',
                      ),
                      Tab(
                        text: 'Manage',
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
                      BlocProvider(
                        create: (context) => AllFlatsBloc(AllFlatsUsecase(
                            repository: AllFlatsRepositoryImpl(
                                datasource: AllFlatsDatasource(
                                    apiClient: ApiClient())))),
                        child: FlatOverview(
                          flatId: flatId,
                          apartmentId: apartmentId,
                          isOwner: isOwner,
                        ),
                      ),
                      MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) =>
                                FlatDetailsBloc(flatDetailsUseCase),
                          ),
                          BlocProvider(
                            create: (context) => FlatSaleOrRentBloc(
                              FlatSaleRentUsecase(
                                repository:
                                  FlatSaleRentRepositoryImpl(
                                    datasource:
                                      FlatSaleRentDatasource(apiClient:ApiClient())
                            ))),
                          ),
                        ],
                        child: FlatDetails(
                          flatId: flatId,
                          isOwner: isOwner,
                          roles: roles,
                        ),
                      )
                    ]),
                  )
                ],
              ),
            );
          } else {
            return Center(child: Text('An error occured'));
          }
        },
      ),
    );
  }
}
