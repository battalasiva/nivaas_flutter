import 'package:flutter/material.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class CheckOutEntry extends StatefulWidget {
  const CheckOutEntry({super.key});

  @override
  State<CheckOutEntry> createState() => _CheckOutEntryState();
}

class _CheckOutEntryState extends State<CheckOutEntry> {
  TextEditingController flatNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Check Out Entry'),
      body: Column(
        children: [
          Text(
            'Flat Number',
            style: txt_14_600.copyWith(color: AppColor.black2),
          ),
          SizedBox(height: 8,),
          DetailsField(controller: flatNumber, hintText: 'Enter Flat Number', condition: true),
          SizedBox(height: 12,),
          Text(
            'Recent Entries',
            style: txt_14_600.copyWith(color: AppColor.black2),
          )

        ],
      ),
    );
  }
}