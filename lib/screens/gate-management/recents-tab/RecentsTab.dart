import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/gate-management/preview/SelectedGuestsPreview.dart';
import 'package:nivaas/screens/gate-management/recents-tab/bloc/visitors_history_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import '../../../data/models/gateManagement/visitors_history_model.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';

class RecentsTab extends StatefulWidget {
  final int apartmentId, flatId;
  final Map<String, Object?>? payload;

  const RecentsTab(
      {super.key,
      required this.apartmentId,
      required this.flatId,
      this.payload});
  @override
  _RecentsTabState createState() => _RecentsTabState();
}

class _RecentsTabState extends State<RecentsTab> {
  Set<int> selectedContacts = {};
  List<Map<String, String>> guests = [];
  final pageSize = 20;
  int pageNo = 0;
  bool isLoading = false;
  bool hasMoreData = true;
  final ScrollController _scrollController = ScrollController();
  List<User> allVisitors = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadVisitors();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isLoading && hasMoreData) {
        setState(() {
          pageNo++;
        });
        _loadVisitors();
      }
    }
  }

  void _loadVisitors() {
    if (isLoading || !hasMoreData) return;

    setState(() {
      isLoading = true;
    });

    context.read<VisitorsHistoryBloc>().add(FetchVisitorsHistoryEvent(
          apartmentId: widget.apartmentId,
          flatId: widget.flatId,
          pageNo: pageNo,
          pageSize: pageSize,
        ));
  }

  void _toggleSelection(int index, User visitor) {
    setState(() {
      if (selectedContacts.contains(index)) {
        selectedContacts.remove(index);
        guests.removeWhere((guest) => guest["number"] == visitor.contactNumber);
      } else {
        selectedContacts.add(index);
        guests.add({"name": visitor.name, "number": visitor.contactNumber});
      }
    });
  }

  void _removeGuest(int index) {
    if (index >= 0 && index < guests.length) {
      String? contactNumber = guests[index]["number"];

      setState(() {
        guests.removeAt(index);

        // Find the corresponding index in the selectedContacts list
        int visitorIndex = selectedContacts.firstWhere(
          (i) => allVisitors[i].contactNumber == contactNumber,
          orElse: () => -1,
        );

        // If found, remove from selectedContacts
        if (visitorIndex != -1) {
          selectedContacts.remove(visitorIndex);
        }
      });
    }
  }

  void _onNext() {
    if (guests.isEmpty) {
      CustomSnackbarWidget(
        context: context,
        title: 'Please add at least one guest.',
        backgroundColor: AppColor.red,
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectedGuestsPreview(
          selectedContacts: guests,
          payload: widget.payload,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<VisitorsHistoryBloc, VisitorsHistoryState>(
        builder: (context, state) {
          if (state is VisitorsHistoryLoading) {
            return Center(child: AppLoader());
          } else if (state is VisitorsHistoryFailure) {
            return Center(
                child: Text(state.message,
                    style: txt_14_600.copyWith(color: AppColor.black2)));
          } else if (state is VisitorsHistoryLoaded) {
            allVisitors = state.details
                .expand((visitorsHistory) => visitorsHistory.content)
                .toList();

            if (allVisitors.isEmpty) {
              return Center(
                  child: Text("No recent history available.",
                      style: txt_14_600.copyWith(color: AppColor.black2)));
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: allVisitors.length,
              itemBuilder: (context, index) {
                User visitor = allVisitors[index];
                bool isSelected = selectedContacts.contains(index);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColor.greyBackground,
                    child: Icon(Icons.person, color: AppColor.white),
                  ),
                  title: Text(visitor.name,
                      style: txt_15_500.copyWith(color: AppColor.black2)),
                  subtitle: Text(visitor.contactNumber,
                      style: txt_13_500.copyWith(color: AppColor.black2)),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      _toggleSelection(index, visitor);
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
                child: Text("No recent history available.",
                    style: txt_14_600.copyWith(color: AppColor.black2)));
          }
        },
      ),
      bottomSheet: Container(
        color: AppColor.white,
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (guests.isNotEmpty) ...[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: guests.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> guest = entry.value;
                  return Chip(
                    label: Text(guest["name"]!),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () => _removeGuest(index),
                    backgroundColor: AppColor.blueShade,
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
            ],
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomizedButton(
                label: 'Next',
                style: txt_14_500.copyWith(color: AppColor.white),
                onPressed: _onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}