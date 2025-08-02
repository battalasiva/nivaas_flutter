import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/search-community/requests/flat_apartment_requests/bloc/my_requests_bloc.dart';
import 'package:nivaas/screens/search-community/status-timeline/StatusTimeline.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';

class RequestCard extends StatelessWidget {
  final String apartmentName;
  final String? flat;
  final String date;
  final bool? status;
  final VoidCallback? onRemind;
  final VoidCallback? onCheckStatus;
  final bool isFlatSelected;
  final String? mobileNumber;
  final String? adminName;
  final int? flatId;

  const RequestCard({
    super.key,
    required this.apartmentName,
    this.flat,
    required this.date,
    required this.status,
    this.onRemind,
    this.onCheckStatus,
    required this.isFlatSelected,
    this.mobileNumber,
    this.adminName,
    this.flatId,
  });

  String truncateText(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColor.blueShade,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(9.0),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      isFlatSelected ? Icons.home : Icons.apartment,
                      color: AppColor.blue,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(truncateText(apartmentName, 17),
                          style: txt_15_600.copyWith(color: AppColor.black1)),
                      const SizedBox(height: 4.0),
                      Text(
                        flat != null ? 'Flat No: $flat' : '_',
                        style: txt_13_600.copyWith(color: AppColor.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatDate(date),
                    style: txt_14_700.copyWith(color: AppColor.grey),
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 20.0,
                    ),
                    decoration: BoxDecoration(
                      color: status == true ? AppColor.green : AppColor.orange,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      status == true ? 'Approved' : 'Pending',
                      style: txt_14_700.copyWith(color: AppColor.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // if (status != true && isFlatSelected) ...[
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: BlocBuilder<MyRequestsBloc, MyRequestsState>(
                  builder: (context, state) {
                    final isLoading = state is RemaindRequestLoading &&
                        state.flatId == flatId.toString();
                    return OutlinedButton(
                      onPressed: (status != true && isFlatSelected)
                          ? onRemind
                          : () {
                              CustomSnackbarWidget(
                                context: context,
                                title:(status != true && !isFlatSelected) ? "This Feature is Under Development" : 'This Request Already Approved',
                                backgroundColor: AppColor.orange,
                              );
                            },
                      style: OutlinedButton.styleFrom(
                        side: (status != true && isFlatSelected)
                            ? BorderSide(color: AppColor.blue)
                            : BorderSide(color: AppColor.grey),
                        backgroundColor: AppColor.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                valueColor:
                                    AlwaysStoppedAnimation(AppColor.blue),
                              ),
                            )
                          : Text(
                              'Remind',
                              style: txt_14_700.copyWith(
                                  color: (status != true && isFlatSelected)
                                      ? AppColor.black
                                      : AppColor.grey),
                            ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Statustimeline(
                            statusType: isFlatSelected,
                            apartmentName: apartmentName,
                            flatNo: flat,
                            mobileNumber: mobileNumber,
                            adminName: adminName,
                            date: date,
                            status: status),
                      ),
                    )
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: SizedBox(
                    child: Text(
                      'Check Status',
                      style: txt_14_700.copyWith(color: AppColor.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // ]
        ],
      ),
    );
  }
}
