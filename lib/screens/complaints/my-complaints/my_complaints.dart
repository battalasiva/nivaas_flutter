import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/complaints/my-complaints/bloc/my_complaints_bloc.dart';
import 'package:nivaas/screens/complaints/raise-complaint/raise_complaint.dart';
import 'package:nivaas/widgets/cards/ComplaintsCard.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class MyComplaints extends StatefulWidget {
  final int? apartmentId;
  final int? flatId;
  final bool? isAdmin,isLeftSelected;
  final bool? isOwner;
  final int? userId;
  final String? currentApartment;

  const MyComplaints({
    super.key,
    this.apartmentId,
    this.flatId,
    this.isAdmin,
    this.userId,
    this.isOwner,
    this.currentApartment,
    this.isLeftSelected,
  });

  @override
  State<MyComplaints> createState() => _MyComplaintsState();
}

class _MyComplaintsState extends State<MyComplaints> {
  int pageNo = 0;
  final int pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasMore = true;
  List<dynamic> complaintsList = [];

  @override
  void initState() {
    super.initState();
    _fetchComplaints();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !isLoadingMore &&
          hasMore) {
        _fetchComplaints();
      }
    });
  }

  void _fetchComplaints() {
    setState(() {
      isLoadingMore = true;
    });

    context.read<MyComplaintsBloc>().add(
          FetchMyComplaintsEvent(
            apartmentId: widget.apartmentId ?? 0,
            pageNo: pageNo,
            pageSize: pageSize,
          ),
        );
  }

  Future<void> refreshComplaints() async {
    setState(() {
      pageNo = 0;
      hasMore = true;
      complaintsList.clear();
    });
    _fetchComplaints();
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
      appBar: const TopBar(title: 'My Complaints'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: RefreshIndicator(
          onRefresh: refreshComplaints,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: BlocListener<MyComplaintsBloc, MyComplaintsState>(
                  listener: (context, state) {
                    if (state is MyComplaintsLoaded) {
                      setState(() {
                        complaintsList.addAll(state.complaints.content ?? []);
                        hasMore = state.complaints.content?.length == pageSize;
                        if (hasMore) {
                          pageNo++;
                        }
                        isLoadingMore = false;
                      });
                    } else if (state is MyComplaintsError) {
                      setState(() {
                        isLoadingMore = false;
                        hasMore = false;
                      });
                    }
                  },
                  child: complaintsList.isEmpty
                      ? isLoadingMore
                          ? const Center(child: AppLoader())
                          : const Center(
                              child: Text('Complaints Not Available'))
                      : ListView.builder(
                          controller: _scrollController,
                          padding:
                              EdgeInsets.only(bottom: getHeight(context) * 0.02),
                          itemCount:
                              complaintsList.length + (isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < complaintsList.length) {
                              final complaint = complaintsList[index];
                              return ComplaintsCard(
                                issue: complaint.title ?? 'NA',
                                date: complaint.createdDt ?? 'NA',
                                user: (complaint.assignedTo != null)
                                    ? complaint.assignedTo.toString()
                                    : 'Unassigned',
                                status: complaint.status ?? 'Unassigned',
                                isAdmin: widget.isAdmin,
                                isOwner: widget.isOwner,
                                isLeftSelected:widget.isLeftSelected,
                                createdDate: complaint.createdDt ?? '',
                                title: complaint.title ?? '',
                                description: complaint.description ?? '',
                                id: complaint.id as int? ?? 0,
                                apartmentId: widget.apartmentId,
                                currentApartment:widget.currentApartment,
                                onRefresh: refreshComplaints,
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: AppLoader(),
                                ),
                              );
                            }
                          },
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: CustomizedButton(
                  label: 'Raise A Complaint',
                  style: txt_14_500.copyWith(color: AppColor.white),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RaiseComplaint(
                          apartmentId: widget.apartmentId!,
                          userId: widget.userId!,
                        ),
                      ),
                    ).then((result) {
                      if (result == true) {
                        refreshComplaints();
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
