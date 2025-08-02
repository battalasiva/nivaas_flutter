import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/security/guest_invite_entries_model.dart';
import 'package:nivaas/data/provider/network/api/security/otp_validation_datasource.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/security/otp_validation_repositoryimpl.dart';
import 'package:nivaas/domain/usecases/security/otp_validation_usecase.dart';
import 'package:nivaas/screens/security/guest_invite_entries/otpValidation/bloc/otp_validation_bloc.dart';
import 'package:nivaas/screens/security/guest_invite_entries/otpValidation/otp_validation.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/colors.dart';
import 'bloc/guest_invite_entries_bloc.dart';

class GuestInviteEntries extends StatefulWidget {
  final int apartmentId;
  const GuestInviteEntries({super.key, required this.apartmentId});

  @override
  State<GuestInviteEntries> createState() => _GuestInviteEntriesState();
}

class _GuestInviteEntriesState extends State<GuestInviteEntries> {
  int pageNo =0;
  final int pageSize = 20;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasMore = true;
  List<VisitorRequest> allData = [];
  
  @override
  void initState() {
    super.initState();
    pageNo = 0;
    context
        .read<GuestInviteEntriesBloc>()
        .add(FetchGuestInviteEntriesEvent(apartmentId: widget.apartmentId, pageNo: pageNo, pageSize: pageSize));
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent
        && !isLoadingMore &&
        hasMore) {
          _loadMoreData();
        }
      }
    });
  }

  void _loadMoreData() {
    setState(() {
      isLoadingMore = true;
    });
    pageNo++;
    context.read<GuestInviteEntriesBloc>().add(
      FetchGuestInviteEntriesEvent(
        apartmentId: widget.apartmentId,
        pageNo: pageNo,
        pageSize: pageSize
      )
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Guest Invite Entries'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<GuestInviteEntriesBloc, GuestInviteEntriesState>(
          builder: (context, state) {
            print(state);
            if (state is GuestInviteEntriesLoading) {
              return AppLoader();
            } else if (state is GuestInviteEntriesFailure) {
              print(state.message);
              return Center(child: Text(state.message));
            } else if (state is GuestInviteEntriesLoaded) {
              GuestInviteEntriesModel details = state.details;
              if(state.details.content.isEmpty){
                return Center(child: Text('Visitor requests not available', style: txt_14_700.copyWith(color: AppColor.black2),));
              }
              allData.addAll(details.content);
              if (details.content.length < pageSize) {
                hasMore = false;
              }
              isLoadingMore = false;
              return ListView.builder(
                controller: _scrollController,
                itemCount: allData.length,
                itemBuilder: (context, index) {
                  final visitorRequest = allData[index];
                  List<Visitor> visitors = visitorRequest.visitors;
                  String visitorNames = visitors.isNotEmpty
                      ? visitors.map((v) => v.name).join(", ")
                      : "No Visitors";
                  String visitorContacts = visitors.isNotEmpty 
                    ? visitors.map((v) => v.contactNumber).join(", ") 
                    : "No Contact Info";
                  return VisitorCard(
                    flatNo: visitorRequest.flatNo,
                    type: visitorRequest.visitorType,
                    visitor: visitorNames,
                    mobileNumber: visitorContacts,
                    requestId: visitorRequest.visitorRequestId,
                  );
                },
              );
            }
            return Text('No data available');
          },
        ),
      ),
    );
  }
}

class VisitorCard extends StatelessWidget {
  final String flatNo;
  final String type;
  final String visitor;
  final String mobileNumber;
  final int requestId;

  const VisitorCard(
      {super.key,
      required this.flatNo,
      required this.type,
      required this.visitor,
      required this.mobileNumber,
      required this.requestId});

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColor.blueShade,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColor.white,
                  child: Text(getInitials(visitor)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flatNo,
                        style: txt_14_700.copyWith(color: AppColor.black2),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        visitor,
                        style: txt_12_500.copyWith(color: AppColor.black2),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        mobileNumber,
                        style: txt_12_500.copyWith(color: AppColor.black2),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColor.blue),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text('Enter Otp', style: txt_12_500.copyWith(color: AppColor.white1),),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => OtpValidationBloc(OtpValidationUsecase(repository: 
                                        OtpValidationRepositoryimpl(datasource: OtpValidationDatasource(apiClient: ApiClient()
                                      )))),
                                      child: OtpValidation(
                                        requestId: requestId,
                                      ),
                                    )));
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
