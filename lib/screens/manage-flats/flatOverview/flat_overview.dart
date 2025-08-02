import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/screens/manage-flats/flatOverview/members/members.dart';
import 'package:nivaas/widgets/elements/details_field.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/img_consts.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/text_styles.dart';
import '../../../widgets/elements/button.dart';
import '../../manageApartment/bloc/all_flats_bloc.dart';

class FlatOverview extends StatefulWidget {
  final int flatId;
  final int apartmentId;
  final bool isOwner;
  const FlatOverview(
      {super.key,
      required this.flatId,
      required this.apartmentId,
      required this.isOwner});

  @override
  State<FlatOverview> createState() => _FlatOverviewState();
}

class _FlatOverviewState extends State<FlatOverview> {
  final TextEditingController _nameController = TextEditingController();
  int flatmembersCount = 0;

  @override
  void initState() {
    _fetchFlats();
    super.initState();
  }

  void _fetchFlats() {
    context.read<AllFlatsBloc>().add(GetFlatmembersEvent(
        apartmentId: widget.apartmentId, flatId: widget.flatId));
  }

  _addNewmember(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: getHeight(context) * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    'Add New Member',
                    style: txt_14_600.copyWith(color: AppColor.black2),
                  )),
                  const SizedBox(
                    height: 17,
                  ),
                  Text('Name',
                      style: txt_14_600.copyWith(color: AppColor.black2)),
                  const SizedBox(
                    height: 6,
                  ),
                  DetailsField(
                    controller: _nameController,
                    hintText: 'Enter Full Name',
                    condition: false,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text('Mobile Number',
                      style: txt_14_600.copyWith(color: AppColor.black2)),
                  const SizedBox(
                    height: 6,
                  ),
                  DetailsField(
                    controller: _nameController,
                    hintText: 'Enter Mobile Number',
                    condition: false,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text('Flat No',
                      style: txt_14_600.copyWith(color: AppColor.black2)),
                  const SizedBox(
                    height: 6,
                  ),
                  DetailsField(
                    controller: _nameController,
                    hintText: 'Enter Flat No',
                    condition: false,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text('Relationship',
                      style: txt_14_600.copyWith(color: AppColor.black2)),
                  const SizedBox(
                    height: 6,
                  ),
                  DetailsField(
                    controller: _nameController,
                    hintText: 'Select Relation',
                    condition: false,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text('Gender',
                      style: txt_14_600.copyWith(color: AppColor.black2)),
                  const SizedBox(
                    height: 6,
                  ),
                  DetailsField(
                    controller: _nameController,
                    hintText: 'Select Gender',
                    condition: false,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 95),
                    child: CustomizedButton(
                        label: 'Add member',
                        onPressed: () {},
                        style: txt_14_500.copyWith(color: AppColor.white2)),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              width: getWidth(context) * 0.45,
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColor.blueShade,
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        person,
                        color: AppColor.primaryColor1,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Members',
                        style: txt_12_500.copyWith(color: AppColor.black2),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  BlocListener<AllFlatsBloc, AllFlatsState>(
                    listener: (context, state) {
                      print(state);
                      if (state is FlatMembersLoaded) {
                        setState(() {
                          flatmembersCount = state.flats.length;
                        });
                      }
                    },
                    child: Text(
                      '$flatmembersCount',
                      style: txt_16_500.copyWith(color: AppColor.black2),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () async {
              final bloc = BlocProvider.of<AllFlatsBloc>(context);
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                            value: bloc,
                            child: Members(
                              apartmentId: widget.apartmentId,
                              flatId: widget.flatId,
                              isOwner: widget.isOwner,
                            ),
                          )));
              _fetchFlats();
            },
          ),
          // const Spacer(),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 95),
          //   child: CustomizedButton(
          //       label: 'Add New Member',
          //       onPressed: () {
          //         _addNewmember(context);
          //       },
          //       style: txt_14_500.copyWith(color: AppColor.white)),
          // )
        ],
      ),
    );
  }
}
