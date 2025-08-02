import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/services/GetServicesPartnersListmodal.dart';
import 'package:nivaas/screens/services/service-popup/bloc/add_service_provider_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/DialerButton.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class ServiceProvidersList extends StatefulWidget {
  final int? apartmentId, categoryId;
  const ServiceProvidersList({super.key, this.apartmentId, this.categoryId});

  @override
  State<ServiceProvidersList> createState() => _ServiceProvidersListState();
}

class _ServiceProvidersListState extends State<ServiceProvidersList> {
  List<GetServicePartnersListModel> serviceProviders = [];

  @override
  void initState() {
    super.initState();
    context.read<AddServiceProviderBloc>().add(
          FetchServiceProviders(
            apartmentId: widget.apartmentId ?? 0,
            categoryId: widget.categoryId ?? 0,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Service Providers List'),
      backgroundColor: AppColor.white,
      body: BlocConsumer<AddServiceProviderBloc, AddServiceProviderState>(
        listener: (context, state) {
          if (state is ServiceProvidersLoaded) {
            setState(() {
              serviceProviders = state.serviceProviders;
            });
          } else if (state is ServiceProvidersError) {
            CustomSnackbarWidget(
              context: context,
              title: state.message,
              backgroundColor: AppColor.red,
            );
          }
        },
        builder: (context, state) {
          if (state is ServiceProvidersLoading) {
            return const Center(child: AppLoader());
          }
          return serviceProviders.isEmpty
              ? Center(
                  child: Text(
                  "Service Providers Not Available",
                  style: txt_14_400.copyWith(color: AppColor.black1),
                ))
              : ListView.builder(
                  padding: EdgeInsets.all(getWidth(context) * 0.05),
                  itemCount: serviceProviders.length,
                  itemBuilder: (context, index) {
                    final provider = serviceProviders[index].partnerResponse;
                    return Card(
                      elevation: 0,
                      color: AppColor.blueShade,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      provider?.name ?? "NA",
                                      style: txt_15_500.copyWith(
                                          color: AppColor.black1),
                                    ),
                                    const SizedBox(width: 8),
                                    if (serviceProviders[index]
                                        .isDefaultPartner!)
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: AppColor.blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: AppColor.white,
                                          size: 20,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  provider?.primaryContact ?? "NA",
                                  style: txt_14_400.copyWith(
                                      color: AppColor.black1),
                                ),
                              ],
                            ),
                            DialerButton(
                                phoneNumber: provider?.primaryContact ?? ""),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
