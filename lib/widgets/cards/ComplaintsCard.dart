import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/complaints/view-complaints/view_complaints.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';

class ComplaintsCard extends StatelessWidget {
  final String issue;
  final String date;
  final String user;
  final String status;
  final bool? isAdmin, isLeftSelected;
  final bool? isOwner;
  final String createdDate;
  final String title;
  final String description;
  final int id;
  final int? apartmentId;
  final VoidCallback? onRefresh;
  final String? currentApartment;

  const ComplaintsCard({super.key, 
    required this.issue,
    required this.date,
    required this.user,
    required this.status,
    required this.isAdmin,
    required this.isOwner,
    required this.createdDate,
    required this.title,
    required this.description,
    required this.id,
    required this.apartmentId,
    this.onRefresh,
    this.currentApartment,
    this.isLeftSelected,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return AppColor.orange;
      case 'in_progress':
        return AppColor.blue;
      case 'resolved':
        return AppColor.green;
      case 'closed':
        return AppColor.red2;
      default:
        return AppColor.red2;
    }
  }

  String _getDisplayStatus(String status) {
    return status.replaceAll('_', ' ').toLowerCase();
  }

  void _navigateToViewComplaints(BuildContext context) async {
    if (isAdmin! || isOwner!) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewComplaints(
            createdDate: createdDate,
            title: title,
            description: description,
            id: id,
            apartmentId: apartmentId ?? 0,
            status: status,
            isAdmin: isAdmin,
            isOwner: isOwner,
            currentApartment: currentApartment,
            isLeftSelected: isLeftSelected,
          ),
        ),
      ).then((result) {
        if (result == true) {
          onRefresh?.call();
        }
      });
    } else {
      showSnackbarForNonAdmins(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToViewComplaints(context),
      child: Card(
        color: AppColor.blueShade,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Issue: ',
                            style: txt_13_400.copyWith(color: AppColor.black2),
                          ),
                          TextSpan(
                            text: issue,
                            style: txt_13_400.copyWith(color: AppColor.primaryColor2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Raised On: ',
                            style: txt_13_400.copyWith(color: AppColor.black2),
                          ),
                          TextSpan(
                            text: formatDate(date),
                            style: txt_13_400.copyWith(color: AppColor.black2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 11,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: _getStatusColor(status),
                  ),
                  child: Text(
                    _getDisplayStatus(status),
                    style: txt_11_600.copyWith(color: AppColor.white1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
