import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/flatmembers_details_datasource.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/manageApartment/flatmembers_details_repository_impl.dart';
import 'package:nivaas/domain/usecases/manageApartment/flatmembers_details_usecase.dart';
import 'package:nivaas/screens/manageApartment/flatMembers/edit_flat_member_details.dart';
import 'package:nivaas/widgets/elements/DialerButton.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/colors.dart';
import '../bloc/all_flats_bloc.dart';
import 'bloc/flatmember_details_bloc.dart';

class FlatMembers extends StatefulWidget {
  final int apartmentId;
  // final int flatId;
  // final List<FlatsModel> flats;
  final String flatNo;
  const FlatMembers(
      {super.key,
      required this.apartmentId,
      // required this.flats,
      required this.flatNo});

  @override
  State<FlatMembers> createState() => _FlatMembersState();
}

class _FlatMembersState extends State<FlatMembers> {
  TextEditingController flatNoController = TextEditingController();
  late AllFlatsBloc allFlatsBloc;

  @override
  void initState() {
    super.initState();
    _fetchFlats();
  }
  void _fetchFlats() {
    context
        .read<AllFlatsBloc>()
        .add(GetFlatDetailsEvent(apartmentId: widget.apartmentId));
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
  void dispose() {
    flatNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<FlatsModel> relatedFlats =
    //     widget.flats.where((flat) => flat.flatNo == widget.flatNo).toList();
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Flat Details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flat Number',
                style: txt_14_600.copyWith(color: AppColor.black2)),
            SizedBox(
              height: 8,
            ),
            Container(
              width: getWidth(context),
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.greyBorder),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(widget.flatNo),
            ),
            SizedBox(
              height: 8,
            ),
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
                if(state is AllFlatsError){
                  return Center(child: Text(state.message));
                }else if (state is FlatDetailsLoaded) {
                  final flats = state.flats.where((flat) => (flat.flatNo == widget.flatNo) && (flat.approved == true)).toList();
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
                        radius: 29,
                        backgroundColor: AppColor.greyBackground,
                        child: Text(getInitials(flat.name)),
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
                            style: txt_12_400.copyWith(color: AppColor.black2)
                          )
                        ],
                      ),
                    ],
                  ),
                  DialerButton(phoneNumber: flat.contactNumber)
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Image.asset(callAdd))
                ],
              ),
            ),
          ),
          onTap: () async{
            await showModalBottomSheet(
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
                        canEdit: true,
                      ),
                    ),
                  );
                });
                _fetchFlats();
          },
        );
      });
} return Container();
              }, 
            )
          ],
        ),
      ),
    );
  }
}
