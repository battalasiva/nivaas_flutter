import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/auth/splashScreen/bloc/splash_bloc.dart';
import 'package:nivaas/screens/gate-management/preview/bloc/add_guests_bloc.dart';
import 'package:nivaas/screens/home-profile/homeScreen/home_screen.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:share_plus/share_plus.dart';

class SelectedGuestsPreview extends StatefulWidget {
  final List<Map<String, String>>? selectedContacts;
  final Map<String, Object?>? payload;
  const SelectedGuestsPreview({super.key, this.selectedContacts, this.payload});

  @override
  State<SelectedGuestsPreview> createState() => _SelectedGuestsPreviewState();
}

class _SelectedGuestsPreviewState extends State<SelectedGuestsPreview> {
  String? currentApartment, name, mobileNumber;

  @override
  void initState() {
    super.initState();
    fetchCurrentCustomer();
  }

  Future<void> fetchCurrentCustomer() async {
    final splashState = context.read<SplashBloc>().state;
    if (splashState is SplashSuccess) {
      final currentUser = splashState.user;
      setState(() {
        currentApartment = currentUser.currentApartment!.apartmentName;
        name = currentUser.user.name;
        mobileNumber = currentUser.user.mobileNumber;
      });
    }
  }

  void removeGuest(int index) {
    setState(() {
      widget.selectedContacts?.removeAt(index);
    });
  }

  void createInvite() {
    bool isOnce = widget.payload?["accessType"] == "ONCE";
    var payload = {
      "apartmentId": widget.payload?["apartmentId"],
      "flatId": widget.payload?["flatId"],
      // "status": widget.payload?["status"] ?? "APPROVED",
      "type": widget.payload?["type"] ?? "GUEST",
      "accessType": widget.payload?["accessType"] ?? "ONCE",
      "startDate": widget.payload?["startDate"],
      "visitors": widget.selectedContacts,
      if (isOnce) ...{
        "startTime": widget.payload?["startTime"],
        "hours": widget.payload?["hours"],
      } else ...{
        "endDate": widget.payload?["enddate"],
      }
    };
    if (widget.selectedContacts!.isEmpty) {
      CustomSnackbarWidget(
        context: context,
        title: 'Please Select Contacts',
        backgroundColor: AppColor.red,
      );
    } else {
      context
          .read<AddGuestsBloc>()
          .add(AddGuestsRequestEvent(payload as Map<String, dynamic>));
    }
  }

  void showInvitePopup(String code) {
    String invitedGuests =
        widget.selectedContacts!.map((guest) => guest["name"]).join(", ");

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        bool isOnce = widget.payload?["accessType"] == "ONCE";
        String? startDate = widget.payload?["startDate"] as String?;
        String? startTime = widget.payload?["startTime"] as String?;
        String? endDate = widget.payload?["enddate"] as String?;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Invitation To Your Flat !",
                  style: txt_17_800.copyWith(color: AppColor.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  invitedGuests,
                  style: txt_12_600.copyWith(color: AppColor.black1),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    color: AppColor.blueShade,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.blue, width: 1),
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: code.split('').map((char) {
                        return WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              char,
                              style: txt_15_700.copyWith(color: AppColor.blue),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "$startDate | ${isOnce ? startTime ?? '--:--' : endDate ?? '--/--/----'}",
                    style: txt_14_500.copyWith(color: AppColor.primaryColor2),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),

                // Share Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomizedButton(
                        label: 'Share Invite',
                        style: txt_15_500.copyWith(color: AppColor.white),
                        onPressed: () => shareFunction(code),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomizedButton(
                        label: 'Close',
                        style: txt_15_500.copyWith(color: AppColor.white),
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void shareFunction(String code) {
    String message = """
You have been invited to visit $currentApartment by $name. 
Please use the following 6-digit entry code at the security gate for smooth access:

🔑 Your Entry Code: $code
📍 Apartment Name: $currentApartment
""";
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    bool isOnce = widget.payload?["accessType"] == "ONCE";
    String? startDate = widget.payload?["startDate"] as String?;
    String? startTime = widget.payload?["startTime"] as String?;
    String? endDate = widget.payload?["enddate"] as String?;
    print('$startTime $startDate ${widget.payload}');

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Preview'),
      body: Padding(
        padding: EdgeInsets.all(getWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Allow Entry On",
                style: txt_14_600.copyWith(color: AppColor.black1)),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.blueShade,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$startDate | ${isOnce ? startTime ?? '--:--' : endDate ?? '--/--/----'}",
                style: txt_14_500.copyWith(color: AppColor.black1),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Manage Guest List",
                    style: txt_14_600.copyWith(color: AppColor.black1)),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add_circle_outline, color: AppColor.blue),
                      const SizedBox(width: 8),
                      Text(
                        "Add Guests",
                        style: txt_14_500.copyWith(color: AppColor.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedContacts?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.selectedContacts![index]["name"]!,
                        style: txt_14_500.copyWith(color: AppColor.black1)),
                    subtitle: Text(widget.selectedContacts![index]["number"]!),
                    trailing: GestureDetector(
                      onTap: () => removeGuest(index),
                      child: Image.asset(deleteIcon, width: 24, height: 24),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BlocConsumer<AddGuestsBloc, AddGuestsState>(
        listener: (context, state) {
          if (state is AddGuestsSuccess) {
            showInvitePopup(state.inviteData.message ?? 'Guest Invited');
          } else if (state is AddGuestsFailure) {
            CustomSnackbarWidget(
              context: context,
              title: state.errorMessage,
              backgroundColor: AppColor.red,
            );
          }
        },
        builder: (context, state) {
          return Container(
            color: AppColor.white,
            padding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
            child: CustomizedButton(
              label:
                  state is AddGuestsLoading ? 'Creating...' : 'Create Invite',
              style: txt_15_500.copyWith(color: AppColor.white),
              onPressed: state is AddGuestsLoading ? () {} : createInvite,
            ),
          );
        },
      ),
    );
  }
}
