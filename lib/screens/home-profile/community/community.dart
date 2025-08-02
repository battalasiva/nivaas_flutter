import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/provider/network/api/managementMembers/list_management_members_datasource.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/managementMembers/list_management_members_repositoryimpl.dart';
import 'package:nivaas/domain/usecases/managementMembers/list_management_members_usecase.dart';
import 'package:nivaas/screens/auth/splashScreen/bloc/splash_bloc.dart';
import 'package:nivaas/screens/coins-subscription/coins-wallet/coins_wallet.dart';
import 'package:nivaas/screens/coins-subscription/subscription/subscription.dart';
import 'package:nivaas/screens/complaints/my-complaints/my_complaints.dart';
import 'package:nivaas/screens/dues-meters/admin-dues/AdminDues.dart';
import 'package:nivaas/screens/dues-meters/generate-bill/MonthlyBillScheduler.dart';
import 'package:nivaas/screens/dues-meters/maintainance/Account.dart';
import 'package:nivaas/screens/dues-meters/user-dues/user_dues.dart';
import 'package:nivaas/screens/managementMembers/bloc/management_members_bloc.dart';
import 'package:nivaas/screens/managementMembers/management_members.dart';
import 'package:nivaas/screens/manageApartment/manage_apt.dart';
import 'package:nivaas/screens/gate-management/guestInvite/guestInvite.dart';
import 'package:nivaas/screens/prepaid-meters/Add-prepaid_meter/AddPrepaidMeter.dart';
import 'package:nivaas/screens/prepaid-meters/meter-consumption/MeterConsumption.dart';
import 'package:nivaas/screens/notices/notice-board/notice_board.dart';
import 'package:nivaas/screens/services/add-service-providers/AddServiceProviders.dart';
import 'package:nivaas/widgets/elements/toggleButton.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../data/provider/network/api/expenseSplitter/expense_splitters_list_datasource.dart';
import '../../../data/repository-impl/expenseSplitter/expense_splitters_list_repositoryimpl.dart';
import '../../../domain/usecases/expenseSplitter/expense_splitters_list_usecase.dart';
import '../../compliance/compliance.dart';
import '../../expenseSplitter/bloc/expense_splitter_bloc.dart';
import '../../expenseSplitter/expense_splitter.dart';
import '../../manage-flats/flatView/flat_view.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  int? apartmentId;
  int? userId;
  int? flatID;
  bool? isAdmin;
  String? currentApartment,mobileNumber,email;
  bool? isOwner;
  bool? isTenant;
  bool isLeftSelected = false;
  bool? isReadOnly;
  bool? isFamilyMember, isHelper;

  @override
  void initState() {
    super.initState();
    fetchCurrentCustomer();
  }

  Future<void> fetchCurrentCustomer() async {
    final splashState = context.read<SplashBloc>().state;
    if (splashState is SplashSuccess) {
      final currentUser = splashState.user;
      apartmentId = currentUser.currentApartment!.id;
      currentApartment = currentUser.currentApartment!.apartmentName;
      isAdmin = currentUser.currentApartment!.apartmentAdmin;
      userId = currentUser.user.id;
      mobileNumber = currentUser.user.mobileNumber;
      email = currentUser.user.email;
      flatID = currentUser.currentFlat?.id;
      isOwner = currentUser.user.roles.contains("ROLE_FLAT_OWNER");
      isTenant = currentUser.user.roles.contains("ROLE_FLAT_TENANT");
      isFamilyMember =
          currentUser.user.roles.contains("ROLE_FLAT_FAMILY_MEMBER");
      isHelper = currentUser.user.roles.contains("ROLE_APARTMENT_HELPER");
      isReadOnly = isOwner! && !isAdmin!;
      print('ISREADONLY_OWNER : $isReadOnly ');
    }
  }

  void _onToggleChanged(bool isLeft) {
    setState(() {
      isLeftSelected = isLeft;
      // isReadOnly = isLeftSelected ? true : false;
      // print('ISREADONLY : $isReadOnly');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Community'),
      body: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is SplashSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              child: Column(
                children: [
                  if ((isAdmin! && isOwner!) ||
                      (isAdmin! && isTenant!) ||
                      (isAdmin! && isFamilyMember!))
                    ToggleButtonWidget(
                        leftTitle: 'My Flat',
                        rightTitle: 'My Apartment',
                        isLeftSelected: isLeftSelected,
                        onChange: _onToggleChanged),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 13,
                          ),
                          Text(
                            'Bills & Dues',
                            style: txt_14_600.copyWith(color: AppColor.black2),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 8,
                            crossAxisCount: 2,
                            childAspectRatio: 1.2,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              if (!isAdmin! || isLeftSelected) ...[
                                _ItemCard(
                                    image: bills,
                                    title: 'Previous Bills/Dues',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => UserDues(
                                                  apartmentId: apartmentId,
                                                  flatID: flatID)));
                                    },
                                    description:
                                        'View Your Flat’s Previous Bills/Dues \n'),
                              ],
                              if ((isAdmin! || isOwner! || isLeftSelected)) ...[
                                _ItemCard(
                                    image: accountIcon1,
                                    title: 'Account',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Account(
                                                  apartmentId: apartmentId!,
                                                  isOwner: isOwner,
                                                  isAdmin: isAdmin,
                                                  isReadOnly: isReadOnly)));
                                    },
                                    description:
                                        'Track Credits, Debits, History & Balance \n'),
                                _ItemCard(
                                    image: split,
                                    title: 'Expense Splitter',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                            BlocProvider(
                                              create: (context) =>
                                                ExpenseSplitterBloc(ExpenseSplittersListUsecase(repository: 
                                                ExpenseSplittersListRepositoryimpl(datasource: 
                                                ExpenseSplittersListDatasource(apiClient: ApiClient())))),
                                            child: ExpenseSplitter(apartmentId: apartmentId!,isAdmin:isAdmin),
                                          )));
                                    },
                                    description:
                                        'Manage expenses between flats'),
                                _ItemCard(
                                    image: billSchedule,
                                    title: 'Monthly Bill Scheduler',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MonthlyBillScheduler(
                                                      apartmentId: apartmentId,
                                                      currentApartment:
                                                          currentApartment,
                                                      isAdmin: isAdmin,
                                                      isReadOnly: isReadOnly)));
                                    },
                                    description:
                                        'Schedule Your Bills Effortlessly Every Month'),
                                _ItemCard(
                                    image: meterIcon,
                                    title: 'Pre-Paid Meters',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddPrepaidMeter(
                                                      apartmentId: apartmentId,
                                                      isOwner: isOwner,
                                                      isAdmin: isAdmin,
                                                      isLeftSelected:
                                                          isLeftSelected,
                                                      isReadOnly: isReadOnly)));
                                    },
                                    description:
                                        'Manage Meters,Set Ranges & Unit Cost \n'),
                                _ItemCard(
                                    image: meterunitsIcon,
                                    title: 'Meter Consumption',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MeterConsumption(
                                                      apartmentId: apartmentId,
                                                      isAdmin: isAdmin,
                                                      isLeftSelected:
                                                          isLeftSelected,
                                                      isReadOnly: isReadOnly)));
                                    },
                                    description:
                                        'Manage Monthly Meter Readings For Each Flat \n'),
                                _ItemCard(
                                    image: updatePayment,
                                    title: 'Update Payment',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AdminDues(
                                                  apartmentId: apartmentId,
                                                  currentApartment:
                                                      currentApartment,
                                                  isAdmin: isAdmin,
                                                  isOwner: isOwner,
                                                  isReadOnly: isReadOnly)));
                                    },
                                    description:
                                        'Record Monthly Bill Payments \n'),
                              ],
                              if ((isAdmin! ||
                                  isOwner! ||
                                  isLeftSelected ||
                                  isTenant!)) ...[
                                _ItemCard(
                                    image: servicesIcon,
                                    title: 'Services',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddServiceProviders(
                                                      apartmentId: apartmentId,
                                                      isLeftSelected:
                                                          isLeftSelected,
                                                      isAdmin: isAdmin,
                                                      isReadOnly: isReadOnly)));
                                    },
                                    description: isReadOnly!
                                        ? 'Easily Veiw and manage services.'
                                        : 'Manage and coordinate service providers for apartments efficiently.'),
                              ]
                            ],
                          ),
                          if (isAdmin! && !isLeftSelected) ...[
                            const SizedBox(
                              height: 14,
                            ),
                            Text(
                              'Subscription & Coins',
                              style:
                                  txt_14_600.copyWith(color: AppColor.black2),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 8,
                              crossAxisCount: 2,
                              childAspectRatio: 1.2,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                _ItemCard(
                                    image: wallet,
                                    title: 'Coins Wallet',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CoinsWallet(
                                                  apartmentId: apartmentId)));
                                    },
                                    description:
                                        'View Wallet Balance & Transaction Details'),
                                _ItemCard(
                                    image: subscriptionIcon,
                                    title: 'Subscription',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Subscription(
                                                      apartmentId:
                                                          apartmentId,mobileNumber:mobileNumber,email:email,userId:userId,apartmentName:currentApartment)));
                                    },
                                    description: 'Manage & View Subscription'),
                              ],
                            ),
                          ],
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            'Manage Flats & Community Complaints',
                            style: txt_14_600.copyWith(color: AppColor.black2),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.2,
                            children: [
                              _ItemCard(
                                  image: complaintsIcon,
                                  title: 'My Complaints',
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyComplaints(
                                                apartmentId: apartmentId,
                                                flatId: flatID,
                                                isAdmin: isAdmin,
                                                userId: userId,
                                                isOwner: isOwner,
                                                currentApartment:
                                                    currentApartment,
                                                isLeftSelected:
                                                    isLeftSelected)));
                                  },
                                  description:
                                      'Raise Complaints & Service Requests'),
                              _ItemCard(
                                  image: notices,
                                  title: 'Notice Board',
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NoticeBoard(
                                                  apartmentId: apartmentId,
                                                  isAdmin: isAdmin,
                                                  isLeftSelected:
                                                      isLeftSelected,
                                                  isOwner: isOwner,
                                                )));
                                  },
                                  description: 'View Community Announcements'),
                              if(isLeftSelected)
                                _ItemCard(
                                  image: buildingIcon, 
                                  title: "Manage Flat", 
                                  onTap: (){
                                    Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FlatView()));
                                  }, 
                                  description: 'View and Manage your Flat'
                                ),
                              if (!isHelper!)
                                _ItemCard(
                                    image: gateIcon,
                                    title: 'Gate Management',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => GuestInvite(
                                                  apartmentId: apartmentId,
                                                  flatId: flatID)));
                                    },
                                    description:
                                        'Organize Guests & Daily Services \n'),
                              if (isAdmin! && !isLeftSelected) ...[
                                _ItemCard(
                                    image: manageApartments,
                                    title: 'Manage Apartment',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ManageApt(
                                                  apartmentId: apartmentId!,
                                                )),
                                      );
                                    },
                                    description:
                                        'Manage flats In Your Community'),
                                _ItemCard(
                                    image: managementIcon,
                                    title: "Management Members",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder:
                                                  (context) => BlocProvider(
                                                        create: (context) => ManagementMembersBloc(
                                                            ListManagementMembersUsecase(
                                                                repository: ListManagementMembersRepositoryimpl(
                                                                    datasource: ListManagementMembersDatasource(
                                                                        apiClient:
                                                                            ApiClient())))),
                                                        child: ManagementMembers(
                                                            apartmentID:
                                                                apartmentId!),
                                                      )));
                                    },
                                    description: "Manage Co-Admin and Security"
                                ),
                                _ItemCard(
                                  image: compliance, 
                                  title: 'Compliance', 
                                  onTap: (){
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                        Compliance(isAdmin: isAdmin!,apartmentId: apartmentId!,)));
                                  }, 
                                  description: "Manage Apartment Rules"
                                )
                              ]
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is SplashFailure) {
            return RefreshIndicator(
              onRefresh: fetchCurrentCustomer,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: getHeight(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text(state.message)),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text('Unable to fetch'),
            );
          }
        },
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ItemCard({
    required this.image,
    required this.title,
    required this.onTap,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.blueShade,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                image,
                color: AppColor.blue,
                height: 35,
                width: 35,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  style: txt_12_500.copyWith(color: AppColor.black2),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text(
                  description,
                  style: txt_10_400.copyWith(color: AppColor.black2),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
