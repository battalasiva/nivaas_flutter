import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/gradients.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/text_styles.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;
  final bool? isLeading;
  final List<Widget>? actions;
  const TopBar({super.key, required this.title, this.bottom, this.isLeading = true, this.actions});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(22), bottomRight: Radius.circular(22)),
      child: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: AppGradients.gradient1),
        ),
        leading:isLeading! ? IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            backArrow,
            width: 24,
            height: 24,
            color: AppColor.white,
          )
        ) : null,
        title: Text(
          title,
          style: txt_17_800.copyWith(color: AppColor.white),
        ),
        centerTitle: true,
        actions: actions ?? [],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
