import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/img_consts.dart';
import '../../../../core/constants/text_styles.dart';

class RejectedOnboardRequests extends StatefulWidget {
  const RejectedOnboardRequests({super.key});

  @override
  State<RejectedOnboardRequests> createState() =>
      _RejectedOnboardRequestsState();
}

class _RejectedOnboardRequestsState extends State<RejectedOnboardRequests> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pending Flats List',
                style: txt_14_600.copyWith(color: AppColor.black2),
              ),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.filter_alt_outlined))
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                color: AppColor.blueShade,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: AppColor.white1, shape: BoxShape.circle),
                        child: Image.asset(building),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'A102',
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  txt_16_700.copyWith(color: AppColor.black2),
                            ),
                            Text(
                              'Owner',
                              style: txt_12_400.copyWith(
                                  color: AppColor.black2.withOpacity(0.5)),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Oct 2nd 10:00 Am',
                            style: txt_10_400.copyWith(
                                color: AppColor.black2.withOpacity(0.5)),
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.red1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(23))),
                              child: Text(
                                'Rejected',
                                style:
                                    txt_11_600.copyWith(color: AppColor.white1),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
