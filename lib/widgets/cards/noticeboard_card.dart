import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nivaas/screens/notices/create-post/create_post.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/img_consts.dart';
import '../../core/constants/text_styles.dart';

class NoticeboardCard extends StatefulWidget {
  final String date;
  final String title;
  final String msg;
  final String role;
  final int id;
  final int apartmentId;
  final bool? isAdmin, isLeftSelected,isOwner;
  final VoidCallback? onNavigateCallback;

  const NoticeboardCard({
    super.key,
    required this.date,
    required this.title,
    required this.msg,
    required this.role,
    required this.id,
    required this.apartmentId,
    this.isAdmin,
    this.onNavigateCallback,
    this.isLeftSelected,
    this.isOwner,
  });

  @override
  State<NoticeboardCard> createState() => _NoticeboardCardState();
}

class _NoticeboardCardState extends State<NoticeboardCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool showReadMore = widget.msg.length > 50;
    final String displayText = isExpanded
        ? widget.msg
        : widget.msg
            .substring(0, widget.msg.length > 50 ? 50 : widget.msg.length);
    return InkWell(
      onTap: () {
        if (widget.isAdmin! || widget.isOwner!) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePost(
                noticeId: widget.id,
                title: widget.title,
                message: widget.msg,
                apartmentId: widget.apartmentId,
                type: 'EDIT_NOTICE',
                isAdmin: widget.isAdmin,
                isOwner:widget.isOwner,
                isLeftSelected: widget.isLeftSelected,
              ),
            ),
          ).then((result) {
            if (result == true) {
              widget.onNavigateCallback!();
            }
          });
        } else {
          showSnackbarForNonAdmins(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.blueShade,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 7, 18, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        noticeDate,
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.red,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        formatDate(widget.date),
                        style: txt_11_500.copyWith(color: AppColor.black2),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17.5, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColor.blue.withOpacity(0.22),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Notice',
                          style: txt_9_500.copyWith(color: AppColor.white1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    widget.title,
                    style: txt_13_600.copyWith(color: AppColor.black2),
                  ),
                  RichText(
                    text: TextSpan(
                      text: displayText,
                      style: txt_13_400.copyWith(color: AppColor.black2),
                      children: [
                        if (!isExpanded && showReadMore)
                          TextSpan(
                            text: '...',
                            style: txt_13_400.copyWith(color: AppColor.black2),
                          ),
                        if (showReadMore)
                          TextSpan(
                            text: isExpanded ? ' Read Less' : ' Read More',
                            style: txt_12_600.copyWith(
                                color: AppColor.primaryColor2),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
