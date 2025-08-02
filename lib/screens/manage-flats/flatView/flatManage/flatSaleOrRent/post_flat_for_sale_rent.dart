import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/screens/manage-flats/flatView/flatManage/flatSaleOrRent/bloc/flat_sale_or_rent_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
// import 'package:nivaas/data/models/manageFlats/flat_details_model.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../widgets/elements/button.dart';
// import '../editFlatDetails/bloc/flat_details_bloc.dart';

class PostFlatForSaleRent extends StatefulWidget {
  final int flatId;
  const PostFlatForSaleRent({
    required this.flatId,
    super.key,
  });

  @override
  State<PostFlatForSaleRent> createState() => _PostFlatForSaleRentState();
}

class _PostFlatForSaleRentState extends State<PostFlatForSaleRent> {
  late String selectedOption;
  late bool isShareDetails;
  final bool isRent = false;
  final bool isSale = false;

  @override
  void initState() {
    super.initState();
    selectedOption = 'For Sale';
    isShareDetails = false;
    // final bloc = BlocProvider.of<FlatSaleOrRentBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      height: getHeight(context) * 0.35,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      child: Column(
        children: [
          Text('Post Your Flat',
              style: txt_14_600.copyWith(color: AppColor.black2)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedOption = 'For Sale';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedOption == 'For Sale'
                        ? AppColor.primaryColor1
                        : AppColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'For Sale',
                    style: txt_13_600.copyWith(
                        color: selectedOption == 'For Sale'
                            ? AppColor.white2
                            : AppColor.primaryColor1),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedOption = 'For Rent';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedOption == 'For Rent'
                        ? AppColor.primaryColor1
                        : AppColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'For Rent',
                    style: txt_13_600.copyWith(
                        color: selectedOption == 'For Rent'
                            ? AppColor.white2
                            : AppColor.primaryColor1),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          //   decoration: BoxDecoration(
          //     color: AppColor.blueShade,
          //     borderRadius: BorderRadius.circular(6),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('Share Your Details To Contact',
          //           style: txt_13_600.copyWith(color: AppColor.black2)),
          //       CupertinoSwitch(
          //         value: isShareDetails,
          //         onChanged: (bool value) {
          //           setState(() {
          //             isShareDetails = value;
          //           });
          //         },
          //         trackColor: AppColor.grey1,
          //         thumbColor: AppColor.primaryColor2,
          //         activeColor: AppColor.grey1,
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: 40),
          BlocListener<FlatSaleOrRentBloc, FlatSaleOrRentState>(
            listener: (context, state) {
              if (state is FlatForRentSuccess || state is FlatForSaleSuccess) {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 40),
                      width: getWidth(context),
                      height: getHeight(context) * 0.3,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                      ),
                      child: Column(
                        children: [
                          Text(
                            selectedOption == 'For Sale'
                                ? 'Your Flat Has Been Successfully \nPosted For Sale!'
                                : 'Your Flat Has Been Successfully \nPosted For Rent!',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          CustomizedButton(
                            label: 'Done',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: txt_14_500.copyWith(color: AppColor.white1)
                          )
                        ],
                      ),
                    );
                  }
                );
              } else if(state is FlatForRentLoading || state is FlatForSaleLoading){
                Center(child: AppLoader());
              } else if(state is FlatSaleOrRentFailure){
                Center(child: Text(state.errorMessage));
              }
            },
            child: CustomizedButton(
              label: selectedOption == 'For Sale'
                  ? 'Post For Sale'
                  : 'Post For Rent',
              onPressed: () {
                if (selectedOption == 'For Sale') {
                  context.read<FlatSaleOrRentBloc>().add(PostFlatForSaleEvent(
                      flatId: widget.flatId, isSale: true));
                } else {
                  context.read<FlatSaleOrRentBloc>().add(PostFlatForRentEvent(
                      flatId: widget.flatId, isRent: true));
                }
              },
              style: txt_14_500.copyWith(color: AppColor.white1),
            ),
          ),
        ],
      ),
    );
  }
}
