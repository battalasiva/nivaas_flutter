import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/manageApartment/flats_model.dart';
import 'package:nivaas/widgets/elements/DialerButton.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/img_consts.dart';
import '../../../widgets/elements/short_button.dart';
import '../../../widgets/elements/top_bar.dart';
import 'bloc/onboard_requests_bloc.dart';

class PendingOnboardRequests extends StatefulWidget {
  final List<FlatsModel> flats;
  final String source;
  final int? flatId;
  final bool isAdmin;
  const PendingOnboardRequests({super.key, required this.flats, required this.source, this.flatId, required this.isAdmin});

  @override
  State<PendingOnboardRequests> createState() => _PendingOnboardRequestsState();
}

class _PendingOnboardRequestsState extends State<PendingOnboardRequests> {
  late List<FlatsModel> unapprovedFlats;

  @override
  void initState() {
    super.initState();
    if(widget.isAdmin == true){
      unapprovedFlats = widget.flats.where((flat) => !flat.approved).toList();
    } else if (widget.source == 'owner') {
      unapprovedFlats = widget.flats.where((flat) => (!flat.approved) && (flat.flatId == widget.flatId )).toList();
    }
  }

  Widget _buildBody(){
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pending Flats List',
                style: txt_14_600.copyWith(color: AppColor.black2),
              ),
              // IconButton(
              //   onPressed: (){},
              //   icon: Icon(Icons.filter_alt_outlined)
              // )
            ],
          ),
        ),
        unapprovedFlats.isEmpty
            ? Center(child: Text('No pending flat requests'))
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: unapprovedFlats.length,
                  itemBuilder: (context, index) {
                    final flat = unapprovedFlats[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      color: AppColor.blueShade,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: AppColor.white1,
                                    shape: BoxShape.circle,
                                    boxShadow: []
                                  ),
                                  child: Image.asset(building, color: null,),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.isAdmin ? flat.flatNo : flat.name,
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: txt_16_700.copyWith(
                                            color: AppColor.black2),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            widget.isAdmin ? flat.name : ''
                                          ),
                                          SizedBox(width: 4,),
                                          Text(
                                            flat.residentType.contains('FLAT_OWNER_FAMILY_MEMBER')
                                              ? 'Family Member'
                                              : flat.residentType.contains('TENANT')
                                              ? 'Tenant'
                                              : flat.residentType.contains('FLAT_OWNER')
                                              ? 'Owner'
                                              : flat.residentType.contains('APARTMENT_ADMIN')
                                              ? 'Admin'
                                              : 'User',
                                              softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: txt_12_400.copyWith(
                                                color: AppColor.black2
                                                    .withOpacity(0.5)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    // Text(
                                    //   'Oct 2nd 10:00 Am',
                                    //   style: txt_10_400.copyWith(color: AppColor.black2.withOpacity(0.5))
                                    // ),
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     icon: Image.asset(callAdd))
                                    DialerButton(phoneNumber: flat.contactNumber)
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: ShortButton(
                                    label: 'Approve',
                                    onPressed: () {
                                      context.read<OnboardRequestsBloc>().add(
                                        ApproveRequestEvent(
                                          id: flat.id, role: flat.residentType, 
                                          type: flat.residentType,
                                          relatedType: flat.residentType,
                                          relatedRequestId: flat.relatedUserId,
                                          flatId: flat.flatId,
                                          userId: flat.userId
                                         )
                                      );
                                    },
                                    style: txt_12_500.copyWith(
                                        color: AppColor.white1),
                                    color: AppColor.primaryColor1,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ShortButton(
                                    label: 'Reject',
                                    onPressed: () {
                                      context.read<OnboardRequestsBloc>().add(
                                        RejectOnboardRequestEvent(id: flat.id, userId: flat.userId, flatId: flat.flatId)
                                      );
                                    },
                                    style: txt_12_500.copyWith(
                                        color: AppColor.black2),
                                    color: AppColor.white1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardRequestsBloc, OnboardRequestsState>(
      listener: (context, state) {
        print('-------------$state ------');
        if (state is OnboardRequestsFailure) {
          Text('fail to onboard flats: ${state.errorMessage}');
          print('------------- ${state.errorMessage}');
        } else if(state is ApproveOnboardRequestsSuccess){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Request approved successfully!'),
          ));
          setState(() {
            unapprovedFlats.removeWhere((flat) => flat.userId == state.userId);
          });
        } else if(state is RejectOnboardRequestsSuccess){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Request rejected successfully!'),
          ));
          setState(() {
            unapprovedFlats.removeWhere((flat) => flat.userId == state.userId);
          });
        }
      },
      child: 
       (widget.source =='admin') ? 
      Scaffold(
        backgroundColor: AppColor.white,
        appBar: TopBar(title: 'Onboard Requests'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: _buildBody(),
        )
      ) : _buildBody(),
    );
  }
}
