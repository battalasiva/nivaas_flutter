import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/gate-management/ApproveDeclineGuestModel.dart';
import 'package:nivaas/screens/gate-management/preview/bloc/add_guests_bloc.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';

class NotificationPopup extends StatefulWidget {
  final List<Content> contentList;
  const NotificationPopup({super.key, required this.contentList});

  @override
  State<NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup> {
  late List<Content> guests;
  bool isLoadingAccept = false;
  bool isLoadingDecline = false;

  @override
  void initState() {
    super.initState();
    guests = List.from(widget.contentList);
  }

  String getGuestType(String title) {
    switch (title) {
      case 'SERVICE':
        return 'Service';
      case 'GUEST':
        return 'Guest';
      case 'DELIVERY':
        return 'Delivery';
      case 'VEHICLE_BOOKING':
        return 'Vehicle Driver';
      default:
        return 'Daily Helper';
    }
  }

  void updateGuestStatus(String status, int id) {
    setState(() {
      if (status == "APPROVED") {
        isLoadingAccept = true;
      } else if (status == "DECLINED") {
        isLoadingDecline = true;
      }
    });

    context.read<AddGuestsBloc>().add(
          UpdateGuestStatusRequested(
            id: id,
            status: status,
          ),
        );
  }
  
  void removeGuest(int id) {
    setState(() {
      guests.removeWhere((guest) => guest.visitorRequestId == id);
      if (guests.isEmpty) {
        Navigator.pop(context);
      }
      isLoadingAccept = false;
      isLoadingDecline = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Center(
            child: SizedBox(
              height: 300,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: guests.length,
                itemBuilder: (context, index) {
                  final guest = guests[index];
                  final name = guest.visitors?.first.name ?? "NA";
                  final guestType = guest.visitorType ?? '';
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColor.blue,
                              child: Image.asset(
                                guestIcon,
                                color: AppColor.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Visitor is Waiting At The Gate",
                              textAlign: TextAlign.center,
                              style: txt_14_500.copyWith(color: AppColor.black),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: AppColor.grey,
                                  child: Text(
                                    name.length >= 2
                                        ? name.substring(0, 2).toUpperCase()
                                        : name.toUpperCase(),
                                    style: txt_14_500.copyWith(
                                        color: AppColor.white),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        name,
                                        style: txt_14_500.copyWith(
                                            color: AppColor.black2),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      getGuestType(guestType),
                                      style: txt_12_500.copyWith(
                                          color: AppColor.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            BlocListener<AddGuestsBloc, AddGuestsState>(
                              listener: (context, state) {
                                if (state is UpdateGuestStatusSuccess) {
                                  removeGuest(guest.visitorRequestId!);
                                  setState(() {
                                    isLoadingAccept = false;
                                    isLoadingDecline = false;
                                  });
                                  CustomSnackbarWidget(
                                    context: context,
                                    title: state.message,
                                    backgroundColor: AppColor.green,
                                  );
                                }
                                if (state is UpdateGuestStatusFailure) {
                                  setState(() {
                                    isLoadingAccept = false;
                                    isLoadingDecline = false;
                                  });
                                  CustomSnackbarWidget(
                                    context: context,
                                    title: state.error,
                                    backgroundColor: AppColor.red,
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      updateGuestStatus(
                                          "DECLINED", guest.visitorRequestId!);
                                    },
                                    child: isLoadingDecline
                                        ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      AppColor.white),
                                            ),
                                          )
                                        : Image.asset(
                                            crossIcon,
                                            color: AppColor.white,
                                            height: 25,
                                            width: 28,
                                          ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      updateGuestStatus(
                                          "APPROVED", guest.visitorRequestId!);
                                    },
                                    child: isLoadingAccept
                                        ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      AppColor.white),
                                            ),
                                          )
                                        : Image.asset(
                                            height: 30,
                                            width: 30,
                                            tickIcon,
                                            color: AppColor.white,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
