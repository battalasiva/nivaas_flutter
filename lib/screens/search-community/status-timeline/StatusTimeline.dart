import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/DialerButton.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/others/default_apartment_Details.dart';
import 'package:url_launcher/url_launcher.dart';

class Statustimeline extends StatelessWidget {
  final bool statusType;
  final String? apartmentName,flatNo,mobileNumber,adminName,date;
  final bool? status;
  const Statustimeline(
      {required this.statusType,
      this.apartmentName,
      this.flatNo,
      this.mobileNumber,
      this.adminName,
      this.date,
      this.status});

  @override
  Widget build(BuildContext context) {
    print('STATUS : $statusType');
    return Scaffold(
      appBar: const TopBar(title: 'Request Status'),
      backgroundColor: AppColor.white,
      body: statusType
          ? _buildFlatStatus(context)
          : _buildApartmentStatus(context),
    );
  }

  Widget _buildFlatStatus(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(getWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Apartment Details',
                style: txt_14_600.copyWith(color: AppColor.black)),
            const SizedBox(height: 8),
            _buildDetailContainer([
              DefaultApartmentDetails(
                  label: "Apartment Name:", value: apartmentName ?? ''),
              DefaultApartmentDetails(
                  label: 'Flat Number:', value: flatNo ?? ''),
            ]),
            const SizedBox(height: 16),
            Text(
              'Contact Apartment',
              style: txt_14_600.copyWith(color: AppColor.black),
            ),
            const SizedBox(height: 8),
            _buildContactContainer(
              _buildContactCard(adminName ?? '', 'Admin', mobileNumber ?? ''),
            ),
            const SizedBox(height: 16),
            Text(
              'Status',
              style: txt_14_600.copyWith(color: AppColor.black),
            ),
            const SizedBox(height: 8),
            _buildStatusContainer([
              _buildStatusRow(true,true, 'Request Has Been Sent For Approval'),
              _buildStatusRow(true,true, 'Request Has View By Apartment Management'),
              _buildStatusRow(status! ? true : false,false,status! ? 'Request Has Been Approved By Apartment Admin' :'Request Has To Be Approved By Apartment Admin'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildApartmentStatus(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apartment Details',
              style: txt_14_600.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 8),
            _buildDetailContainer([
              DefaultApartmentDetails(
                  label: "Apartment Name:", value: apartmentName ?? ''),
              DefaultApartmentDetails(
                  label: 'Request Raised On:', value: formatDate(date ?? '')),
            ]),
            SizedBox(height: 16),
            Text(
              'Status',
              style: txt_14_600.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 8),
            _buildStatusContainer([
              _buildStatusRow(true,true, 'Request Has Been Sent For Approval'),
              _buildStatusRow(true,true, 'Request Has View By Apartment Management'),
              _buildStatusRow(status! ? true : false,false, status! ? 'Request Has Been Approved By Nivaas Admin' : 'Request Has To Be Approved By Nivaas Admin'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(String name, String role, String phoneNumber) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: AppColor.grey,
      radius: 24,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '', 
        style: txt_24_600.copyWith(color: AppColor.white), 
      ),
    ),
    title: Text(
      name,
      style: txt_14_600.copyWith(color: AppColor.black1),
    ),
    subtitle: Text(
      role,
      style: txt_12_400.copyWith(color: AppColor.grey),
    ),
    trailing: DialerButton(phoneNumber: phoneNumber),
  );
}


  Widget _buildStatusRow(bool completed,bool showLine, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              completed ? Icons.check_circle : Icons.access_time,
              color: completed ? AppColor.green : AppColor.grey,
              size: 24,
            ),
            if (showLine)
              Container(
                height: 40,
                width: 2,
                color: AppColor.grey,
              ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(description,
              style: txt_14_500.copyWith(color: AppColor.black1)),
        ),
      ],
    );
  }

  Widget _buildDetailContainer(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.blueShade,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildContactContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.blueShade,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  Widget _buildStatusContainer(List<Widget> rows) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.blueShade,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: rows,
      ),
    );
  }
}
