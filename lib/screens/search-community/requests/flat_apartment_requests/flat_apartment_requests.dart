import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/search-community/requests/flat_apartment_requests/bloc/my_requests_bloc.dart';
import 'package:nivaas/widgets/cards/MyRequest_card.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';

import '../../../../widgets/elements/build_dropdownfield.dart';

class FlatApartmentRequests extends StatefulWidget {
  final String? apartmentName, flatNumber;

  const FlatApartmentRequests({super.key, this.apartmentName, this.flatNumber,});

  @override 
  State<FlatApartmentRequests> createState() => _FlatApartmentRequestsState();
}

class _FlatApartmentRequestsState extends State<FlatApartmentRequests> {
  bool? isFlatSelected = true;
  List<dynamic> myRequests = [];
  String requestType = 'FLAT';

  @override
  void initState() {
    // isFlatSelected = requestType == 'FLAT' ? true : false;
    super.initState();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    context.read<MyRequestsBloc>().add(FetchMyRequestsEvent(requestType));
  }

  Widget buildRequestList() {
    if (myRequests.isEmpty) {
      return Center(
        child: Text('No Requests Found', style: txt_12_700),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10.0),
      itemCount: myRequests.length,
      itemBuilder: (context, index) {
        final request = myRequests[index];
        return RequestCard(
          key: Key(request.id.toString()),
          apartmentName: request.apartmentName ?? '',
          flat: request.flatNo,
          date: request.appliedOn ?? '',
          status: request.approved,
          mobileNumber: request.adminContact ?? '',
          adminName: request.adminName ?? '',
          flatId: request.id,
          onRemind: () {
            isFlatSelected!
                ? context.read<MyRequestsBloc>().add(
                      RemaindRequestCallEvent(
                        apartmentId: request.apartmentId.toString(),
                        flatId: request.id.toString(),
                        onboardingId: request.onboardingId.toString(),
                      ),
                    )
                : CustomSnackbarWidget(
                    context: context,
                    title: 'Under Development',
                    backgroundColor: AppColor.orange,
                  );
          },
          onCheckStatus: () {
            debugPrint('Check Status button clicked for index $index');
          },
          isFlatSelected: isFlatSelected!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: fetchRequests,
        child: Padding(
          padding: EdgeInsets.all(getWidth(context) * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildDropDownField(
                label: 'Select Type',
                items: ['FLAT', 'APARTMENT'], 
                value: requestType, 
                onChanged: (value) {
                  setState(() {
                    requestType = value!;
                    isFlatSelected = requestType == 'FLAT' ? true : false;
                  });
                  fetchRequests();
                },
              ),
              SizedBox(height: 15,),
              Expanded(
                child: BlocConsumer<MyRequestsBloc, MyRequestsState>(
                  listener: (context, state) {
                    if (state is MyRequestsLoaded) {
                      setState(() {
                        myRequests = state.myRequests;
                      });
                    } else if (state is RemaindRequestSuccess) {
                      CustomSnackbarWidget(
                          context: context,
                          title: state.message,
                          backgroundColor: AppColor.green);
                    } else if (state is RemaindRequestFailure) {
                      CustomSnackbarWidget(
                          context: context,
                          title: state.error,
                          backgroundColor: AppColor.red);
                    }
                  },
                  builder: (context, state) {
                    if (state is MyRequestsLoading) {
                      return const Center(child: AppLoader());
                    } else if (state is MyRequestsLoaded) {
                      return buildRequestList();
                    } else if (state is RemaindRequestFailure) {
                      // return const Center(
                      //   child: Text('Failed to load requests', style: txt_14_700),
                      // );
                      return RefreshIndicator(
                        onRefresh: fetchRequests,
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: getHeight(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Text(state.error)),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return buildRequestList();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}
