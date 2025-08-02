import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/screens/managementMembers/addManagementMembers/add_management_members.dart';
import 'package:nivaas/screens/managementMembers/addManagementMembers/bloc/add_management_members_bloc.dart';
import 'package:nivaas/screens/managementMembers/bloc/management_members_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/DialerButton.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../data/provider/network/api/managementMembers/add_management_members_datasource.dart';
import '../../data/provider/network/service/api_client.dart';
import '../../data/repository-impl/managementMembers/add_management_members_repository_impl.dart';
import '../../domain/usecases/managementMembers/add_management_members_usecase.dart';

class ManagementMembers extends StatefulWidget {
  final int apartmentID;
  const ManagementMembers({super.key, required this.apartmentID});

  @override
  State<ManagementMembers> createState() => _ManagementMembersState();
}

class _ManagementMembersState extends State<ManagementMembers> {
  @override
  void initState() {
    fetchManagementMembers();
    super.initState();
  }
  Future<void> fetchManagementMembers() async {
    context
      .read<ManagementMembersBloc>()
      .add(FetchSecuritiesListEvent(apartmentId: widget.apartmentID));
  }

  String getInitials(String text) {
    List<String> words = text.split(' ');

    if (words.length > 1) {
      return words[0][0].toUpperCase() + words[1][0].toUpperCase();
    } else {
      return words[0][0].toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Management Members'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Management Members', style: txt_14_700.copyWith(color: AppColor.black2),),
            // SizedBox(height: 15,),
            BlocBuilder<ManagementMembersBloc, ManagementMembersState>(
              builder: (context, state) {
                if (state is ListManagementMembersLoading) {
                  return Center(child: AppLoader());
                }else  if (state is ListManagementMembersLoaded) {
                  if(state.details.apartmentHelpers.isEmpty){
                    return Center(child: Text('Security is not added'));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.details.apartmentHelpers.length,
                      itemBuilder: (context, index) {
                        final apartmentHelper = state.details.apartmentHelpers[index];
                        final helper = apartmentHelper.userDetails;
                        return Card(
                          color: AppColor.blueShade,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 29,
                                      backgroundColor: AppColor.greyBackground,
                                      child: Text(getInitials(helper.name)),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(helper.name, style: txt_14_600.copyWith(color: AppColor.black2),),
                                        SizedBox(height: 12,),
                                        Text(
                                          (apartmentHelper.role == 'ROLE_APARTMENT_HELPER') ? 'Security'
                                            : 'Admin', 
                                          style: txt_10_400.copyWith(color: AppColor.black2),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                DialerButton(phoneNumber: helper.mobileNumber)
                              ],
                            ),
                          )
                        );
                      }
                    ),
                  );
                }
                return SizedBox();
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: CustomizedButton(
                  label: 'Assign New Role',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => AddManagementMembersBloc(
                                AddManagementMembersUsecase(
                                    repository:
                                        AddManagementMembersRepositoryImpl(
                                            datasource:
                                                AddManagementMembersDatasource(
                                                    apiClient:
                                                        ApiClient())))),
                          child: AddManagementMembers(
                            apartmentId: widget.apartmentID,
                          ),
                        )
                      )
                    ).then((result) {
                      if (result == 'success') {
                        fetchManagementMembers();
                      }
                    });
                  },
                  style: txt_16_500.copyWith(color: AppColor.white1)),
            )
          ],
        ),
      ),
    );
  }
}
