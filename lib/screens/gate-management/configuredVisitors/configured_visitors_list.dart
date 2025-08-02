import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/text_styles.dart';
import '../../../data/models/gateManagement/configured_visitor_invites_model.dart';

class ConfiguredVisitorsList extends StatelessWidget {
  final List<VisitorRequest> details;
  const ConfiguredVisitorsList({super.key, required this.details});

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
      appBar: TopBar(title: 'Visitors List'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: details.length,
          itemBuilder: (context, index) {
            final visitorRequest = details[index];
            final firstVisitor = visitorRequest.visitors.isNotEmpty ? visitorRequest.visitors[0] : null;
            return VisitorCard(
              type: visitorRequest.visitorType, 
              visitor: firstVisitor!.name, 
              mobileNumber: firstVisitor.contactNumber,
              otp: visitorRequest.otp,
            );
          }
        )
      )     
    );
  }
}

class VisitorCard extends StatefulWidget {
  final String type;
  final String visitor;
  final String mobileNumber;
  final String otp;

  const VisitorCard(
      {super.key,
      required this.type,
      required this.visitor,
      required this.mobileNumber,
      required this.otp
    });

  @override
  State<VisitorCard> createState() => _VisitorCardState();
}

class _VisitorCardState extends State<VisitorCard> {
  bool showOtp = false;
    void toggleOtp() {
    setState(() {
      showOtp = !showOtp;
    });

    if (showOtp) {
      Future.delayed(Duration(seconds: 15), () {
        setState(() {
          showOtp = false;
        });
      });
    }
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
              child: Text(getInitials(widget.visitor)),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.visitor,
                    style: txt_14_700.copyWith(color: AppColor.black2),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    widget.type,
                    style: txt_12_500.copyWith(color: AppColor.black2),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    widget.mobileNumber,
                    style: txt_12_500.copyWith(color: AppColor.black2),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: toggleOtp,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColor.blue),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  showOtp ? widget.otp : 'Show Otp', 
                  style: txt_13_400.copyWith(color: AppColor.white1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}