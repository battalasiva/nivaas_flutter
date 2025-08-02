import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/screens/security/gateActivities/bloc/gate_activities_bloc.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../data/models/security/guest_invite_entries_model.dart';
import '../../../widgets/elements/option_button.dart';

class GateActivities extends StatefulWidget {
  final int apartmentId;
  const GateActivities({super.key, required this.apartmentId});

  @override
  State<GateActivities> createState() => _GateActivitiesState();
}

class _GateActivitiesState extends State<GateActivities> {
  late String selectedOption, status;
  int pageNo =0;
  final int pageSize = 20;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasMore = true;
  List<VisitorRequest> allData = [];

  @override
  void initState() {
    super.initState();
    selectedOption = 'Pending';
    status = selectedOption;
    _fetchHistory();
    pageNo =0;
    allData=[];
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
    _fetchHistory();
  }

  void _fetchHistory(){
    context.read<GateActivitiesBloc>().add(FetchCheckinHistoryEvent(
      apartmentId: widget.apartmentId, status: status, pageNo: pageNo, pageSize: pageSize
    ));
  }

  void updateSelectedOption(String option) {
    setState(() {
      selectedOption = option;
      status = selectedOption;
      pageNo =0;
      isLoadingMore = false;
  hasMore = true;
  allData=[];
    });
    _fetchHistory();
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
      appBar: TopBar(title: 'Gate Activities'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                OptionButton(
                  label: 'Pending',
                  selectedOption: selectedOption,
                  onPressed: updateSelectedOption,
                ),
                OptionButton(
                  label: 'Approved',
                  selectedOption: selectedOption,
                  onPressed: updateSelectedOption,
                ),
                OptionButton(
                  label: 'Declined',
                  selectedOption: selectedOption,
                  onPressed: updateSelectedOption,
                ),
              ],
            ),
            SizedBox(height: 12,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: BlocBuilder<GateActivitiesBloc, GateActivitiesState>(
                  builder: (context, state) {
                    print(state);
                    if (state is GateActivitiesLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is GateActivitiesFailure) {
                      print(state.message);
                      return Center(child: Text(state.message));
                    } else if (state is GateActivitiesLoaded) {
                      GuestInviteEntriesModel details = state.details;
                      if(state.details.content.isEmpty){
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(child: Text('Requests not available', style: txt_14_700.copyWith(color: AppColor.black2),)),
                        );
                      }
                      allData.addAll(details.content);
              if (details.content.length < pageSize) {
                hasMore = false;
              }
              isLoadingMore = false;
                      return ListView.builder(
                        shrinkWrap: true,
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
                            status: selectedOption,
                            allowedBy: visitorRequest.approvedBy.name,
                          );
                        },
                      );
                    }
                    return Text('No data available');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VisitorCard extends StatelessWidget {
  final String flatNo;
  final String type;
  final String visitor;
  final String? mobileNumber;
  final String? allowedBy;
  final String status;

  const VisitorCard(
      {super.key,
      required this.flatNo,
      required this.type,
      required this.visitor,
      this.mobileNumber,
      this.allowedBy,
      required this.status
    });

  String getInitials(String text) {
  List<String> words = text.split(' ');

  if (text == '') {
    return '';
  }

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
        child: Row(
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
                    type,
                    style: txt_12_500.copyWith(color: AppColor.black2),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    visitor,
                    style: txt_12_500.copyWith(color: AppColor.black2),
                  ),
                  SizedBox(height: 10,),
                  if(status == 'Approved')
                  Row(
                    children: [
                      Text(
                        'Approved By ',
                        style: txt_12_500.copyWith(color: AppColor.black2),
                      ),
                      Text(
                        allowedBy ?? 'N/A',
                        style: txt_12_500.copyWith(color: AppColor.black2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}