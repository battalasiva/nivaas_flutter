import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/screens/manageApartment/pendingOnboardRequests/bloc/onboard_requests_bloc.dart';
import 'package:nivaas/screens/manageApartment/pendingOnboardRequests/pending_onboard_requests.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';

import '../../../../core/constants/colors.dart';
import '../../../../data/models/manageApartment/flats_model.dart';
import '../../../../data/provider/network/api/manageApartment/onboard_requests_datasource.dart';
import '../../../../data/provider/network/service/api_client.dart';
import '../../../../data/repository-impl/manageApartment/onboard_requests_repository_impl.dart';
import '../../../../domain/usecases/manageApartment/onboard_requests_usecase.dart';
import '../../../manageApartment/bloc/all_flats_bloc.dart';

class MyRequests extends StatefulWidget {
  final int apartmentId, flatId;
  final bool isAdmin;
  const MyRequests(
      {super.key, required this.apartmentId, required this.flatId, required this.isAdmin});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  List<FlatsModel> pendingflats = [];
  bool isDataLoaded = false;

  @override
  void initState() {
    context
        .read<AllFlatsBloc>()
        .add(GetFlatDetailsEvent(apartmentId: widget.apartmentId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocListener<AllFlatsBloc, AllFlatsState>(
        listener: (context, state) {
          if (state is FlatDetailsLoaded) {
            setState(() {
              (widget.isAdmin) ? pendingflats = state.flats
              : pendingflats = state.flats
                  .where(
                      (flat) => flat.flatId == widget.flatId)
                  .toList();
              isDataLoaded = true;
            });
            print('flats in --------- $pendingflats');
          }
        },
        child: BlocProvider(
          create: (context) => OnboardRequestsBloc(
              OnboardRequestsUsecase(
                  repository:
                      OnboardRequestsRepositoryImpl(
                          datasource:
                              OnboardRequestsDatasource(
                                  apiClient:
                                      ApiClient())))),
          child: !isDataLoaded
              ? const Center(child: AppLoader()) // Show loader while waiting
              : PendingOnboardRequests(
                flats: pendingflats,
                source: 'owner',
                flatId: widget.flatId,
                isAdmin: widget.isAdmin,
              ),
        )
      ),
    );
  }
}
