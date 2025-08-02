import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class Searchbox extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final Function(String) onSearch;
  final String hintText;

  const Searchbox(
      {super.key, required this.searchController,
      required this.searchFocusNode,
      required this.onSearch,
      required this.hintText
    });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextField(
        controller: searchController,
        focusNode: searchFocusNode,
        onChanged: onSearch,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: txt_13_400.copyWith(color: AppColor.greyText1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}