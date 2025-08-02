import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/flatmembers_details_datasource.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/manageApartment/flatmembers_details_repository_impl.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/DialerButton.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../../core/constants/colors.dart';
import '../../../../domain/usecases/manageApartment/flatmembers_details_usecase.dart';
import '../../../manageApartment/bloc/all_flats_bloc.dart';
import '../../../manageApartment/flatMembers/bloc/flatmember_details_bloc.dart';
import '../../../manageApartment/flatMembers/edit_flat_member_details.dart';

class Members extends StatefulWidget {
  final int flatId;
  final int apartmentId;
  final bool isOwner;
  const Members({super.key, required this.apartmentId, required this.flatId, required this.isOwner});

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  TextEditingController flatNoController = TextEditingController();
  late AllFlatsBloc allFlatsBloc;

  @override
  void initState() {
    super.initState();
    try {
      final allFlatsBloc = BlocProvider.of<AllFlatsBloc>(context);
      allFlatsBloc.add(GetFlatmembersEvent(
          apartmentId: widget.apartmentId, flatId: widget.flatId));
    } catch (e) {
      print('-------error : $e');
    }
  }

  @override
  void dispose() {
    flatNoController.dispose();
    super.dispose();
  }
  String getInitials(String text) {
  List<String> words = text.split(' ');

  if (words.length > 1) {
    return words[0][0].toUpperCase() + words[1][0].toUpperCase();
  } else {
    return words[0][0].toUpperCase();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Flat Details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Members',
                style: txt_14_600.copyWith(color: AppColor.black2),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            BlocBuilder<AllFlatsBloc, AllFlatsState>(
              builder: (context, state) {
                print('----------$state');
                if (state is FlatMembersLoaded) {
                  final flats = state.flats;
                  print(flats);
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: flats.length,
                      itemBuilder: (context, index) {
                        final flat = flats[index];
                        return InkWell(
                          child: Card(
                            color: AppColor.blueShade,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 10.5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        child: Text(getInitials(flat.name)),
                                        radius: 29,
                                        backgroundColor: AppColor.greyBackground,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(flat.name,
                                              style: txt_14_600.copyWith(
                                                  color: AppColor.black2)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            flat.residentType
                                                    .contains('FLAT_OWNER_FAMILY_MEMBER')
                                                ? 'Family Member'
                                                : flat.residentType
                                                        .contains('TENANT')
                                                    ? 'Tenant'
                                                    : flat.residentType.contains(
                                                            'FLAT_OWNER')
                                                        ? 'Owner'
                                                        : flat.residentType.contains(
                                                                'APARTMENT_ADMIN')
                                                            ? 'Admin'
                                                            : 'User',
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  // IconButton(
                                  //     onPressed: () {},
                                  //     icon: Image.asset(callAdd))
                                  DialerButton(phoneNumber: flat.contactNumber)
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: BlocProvider(
                                      create: (context) => FlatmemberDetailsBloc(
                                          FlatmembersDetailsUsecase(
                                              repository:
                                                  FlatmembersDetailsRepositoryImpl(
                                                      datasource:
                                                          FlatmembersDetailsDatasource(
                                                              apiClient:
                                                                  ApiClient())))),
                                      child: EditFlatMemberDetails(
                                        flat: flat,
                                        apartmentId: widget.apartmentId,
                                        canEdit: widget.isOwner,
                                      ),
                                    ),
                                  );
                                });
                          },
                        );
                      });
                }else if(state is AllFlatsLoading){
                  return Center(child: AppLoader());
                }else if (state is AllFlatsError){
                  if (state.message == 'Onboard Request Not Found') {
                    return Center(child: Text('No members available'));
                  } else {
                    return Center(child: Text(state.message));
                  }
                }
                 return Text('No members available');
              },
            )
          ],
        ),
      ),
    );
  }
}
