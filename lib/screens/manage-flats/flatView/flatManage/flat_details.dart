import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/provider/network/api/manageFlats/flat_sale_rent_datasource.dart';
import 'package:nivaas/data/repository-impl/manageFlats/flat_sale_rent_repository_impl.dart';
import 'package:nivaas/domain/usecases/manageFlats/flat_sale_rent_usecase.dart';
import 'package:nivaas/screens/manage-flats/flatView/flatManage/editFlatDetails/bloc/flat_details_bloc.dart';
import 'package:nivaas/screens/manage-flats/flatView/flatManage/editFlatDetails/fetch_edit_flat_details.dart';
import 'package:nivaas/screens/manage-flats/flatView/flatManage/flatSaleOrRent/bloc/flat_sale_or_rent_bloc.dart';
import 'package:nivaas/screens/manage-flats/flatView/flatManage/flatSaleOrRent/post_flat_for_sale_rent.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/short_button.dart';

import '../../../../core/constants/colors.dart';
import '../../../../data/provider/network/api/manageFlats/flat_details_data_source.dart';
import '../../../../data/provider/network/service/api_client.dart';
import '../../../../data/repository-impl/manageFlats/flat_details_repository_impl.dart';
import '../../../../domain/usecases/manageFlats/flat_details_usecase.dart';

class FlatDetails extends StatefulWidget {
  final int flatId;
  final bool isOwner;
  final List<String> roles;
  const FlatDetails({required this.flatId, required this.isOwner, required this.roles, super.key});

  @override
  State<FlatDetails> createState() => _FlatDetailsState();
}

class _FlatDetailsState extends State<FlatDetails> {
  final flatDetailsUseCase = FlatDetailsUsecase(
      repository: FlatDetailsRepositoryImpl(
          dataSource: FlatDetailsDataSource(apiClient: ApiClient())));
  String selectedOption = 'For Sale';

  @override
  void initState() {
    super.initState();
    context.read<FlatDetailsBloc>().add(FetchFlatDetailsEvent(widget.flatId));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      child: Column(
        children: [
          Container(
            width: getWidth(context),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.blueShade),
            child: 
            (widget.roles.contains('ROLE_FLAT_OWNER') || widget.roles.contains('ROLE_FLAT_FAMILY_MEMBER')
              || widget.roles.contains('ROLE_FLAT_TENANT')
            ) 
            ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Flat Details',
                  style: txt_14_600.copyWith(color: AppColor.black2),
                ),
                ElevatedButton(
                    onPressed: () {
                      final bloc = context.read<FlatDetailsBloc>();
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return BlocProvider.value(
                                value: bloc,
                                child: SingleChildScrollView(
                                    child: FetchEditFlatDetails(
                                  flatId: widget.flatId,
                                  isOwner: widget.isOwner,
                                )),
                              );
                            });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                    child: Text(
                      'View Details',
                      style: txt_12_500.copyWith(color: AppColor.white1),
                    ))
              ],
            ) : Text('You don\'t have any flat'),
          ),
          SizedBox(
            height: 25,
          ),
          if (widget.roles.contains('ROLE_FLAT_OWNER'))
            BlocBuilder<FlatDetailsBloc, FlatDetailsState>(
              builder: (context, state) {
                if (state is FlatDetailsFailure) {
                  return Center(child: Text(state.message));
                } else if (state is FlatDetailsLoaded) {
                  final isAvailableForRent = state.flatDetails.availableForRent;
                  final isAvailableForSale = state.flatDetails.availableForSale;
                  if (isAvailableForSale == true ||
                      isAvailableForRent == true) {
                    return Container(
                      decoration: BoxDecoration(
                          color: AppColor.blueShade,
                          borderRadius: BorderRadius.circular(6)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      child: Column(
                        children: [
                          Text(
                            'Flat Has Been Opt For Sale/Rent',
                            style: txt_13_600.copyWith(color: AppColor.black2),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ShortButton(
                            label: '         Mark as vacated         ', 
                            onPressed: () {
                                isAvailableForSale == true
                                    ? context.read<FlatSaleOrRentBloc>().add(
                                        PostFlatForSaleEvent(
                                            flatId: widget.flatId,
                                            isSale: false))
                                    : context.read<FlatSaleOrRentBloc>().add(
                                        PostFlatForRentEvent(
                                            flatId: widget.flatId,
                                            isRent: false));
                                Future.delayed(Duration.zero, () {
                                  context.read<FlatDetailsBloc>().add(
                                      FetchFlatDetailsEvent(widget.flatId));
                                });
                              }, 
                            style: txt_14_500.copyWith(color: AppColor.white), 
                            color: AppColor.primaryColor1
                          ),
                          
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Text(
                          'wanted To Post Your Flat For Sale/Rent?',
                          style: txt_11_500.copyWith(color: AppColor.black2),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return BlocProvider(
                                    create: (context) => FlatSaleOrRentBloc(
                                        FlatSaleRentUsecase(
                                            repository:
                                                FlatSaleRentRepositoryImpl(
                                                    datasource:
                                                        FlatSaleRentDatasource(
                                                            apiClient:
                                                                ApiClient())))),
                                    child: PostFlatForSaleRent(
                                      flatId: widget.flatId,
                                    ),
                                  );
                                },
                              ).whenComplete(() {
                                context
                                    .read<FlatDetailsBloc>()
                                    .add(FetchFlatDetailsEvent(widget.flatId));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10)),
                            child: Text(
                              'Click Here',
                              style:
                                  txt_12_500.copyWith(color: AppColor.white1),
                            )),
                      ],
                    );
                  }
                }
                return Container();
              },
            )
        ],
      ),
    );
  }
}
