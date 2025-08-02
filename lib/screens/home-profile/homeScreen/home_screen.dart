import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/gradients.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/gate-management/ApproveDeclineGuestModel.dart';
import 'package:nivaas/data/provider/network/api/security/checkin_request_datasource.dart';
import 'package:nivaas/data/provider/network/api/security/gate_activities_datasource.dart';
import 'package:nivaas/data/provider/network/api/security/guest_invite_entries_datasource.dart';
import 'package:nivaas/data/provider/network/api/switchApartment/switch_apartment_datasource.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/security/checkin_request_repositoryimpl.dart';
import 'package:nivaas/data/repository-impl/security/gate_activities_repositoryimpl.dart';
import 'package:nivaas/data/repository-impl/security/guest_invite_entries_repositoryimpl.dart';
import 'package:nivaas/data/repository-impl/switchApartment/switch_apartment_repositoryimpl.dart';
import 'package:nivaas/domain/usecases/security/checkin_request_usecase.dart';
import 'package:nivaas/domain/usecases/security/gate_activities_usecase.dart';
import 'package:nivaas/domain/usecases/security/guest_invite_entries_usecase.dart';
import 'package:nivaas/domain/usecases/switchApartment/switch_apartment_usecase.dart';
import 'package:nivaas/screens/complaints/my-complaints/my_complaints.dart';
import 'package:nivaas/screens/gate-management/Notification-popup/Notification_popup.dart';
import 'package:nivaas/screens/gate-management/preview/bloc/add_guests_bloc.dart';
import 'package:nivaas/screens/notices/notifications/notifications.dart';
import 'package:nivaas/screens/search-community/requests/requests.dart';
import 'package:nivaas/screens/security/checkInEntry/bloc/checkin_request_bloc.dart';
import 'package:nivaas/screens/security/checkInEntry/check_in_entry.dart';
import 'package:nivaas/screens/security/gateActivities/bloc/gate_activities_bloc.dart';
import 'package:nivaas/screens/security/gateActivities/gate_activities.dart';
import 'package:nivaas/screens/security/guest_invite_entries/bloc/guest_invite_entries_bloc.dart';
import 'package:nivaas/screens/security/guest_invite_entries/guest_invite_entries.dart';
import 'package:nivaas/screens/switchApartment/bloc/switch_apartment_bloc.dart';
import 'package:nivaas/screens/switchApartment/switch_apartment.dart';
import 'package:nivaas/screens/manage-flats/flatView/flat_view.dart';
import 'package:nivaas/screens/dues-meters/user-dues/user_dues.dart';
import 'package:nivaas/screens/auth/splashScreen/bloc/splash_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/imageSlider.dart';
import 'package:nivaas/widgets/others/AlertMessages.dart';
import '../../compliance/compliance.dart';
import '../../gate-management/configuredVisitors/configured_visitors.dart';
import '../../gate-management/guestInvite/guestInvite.dart';
import '../../manageApartment/manage_apt.dart';
import '../../notices/notice-board/notice_board.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'User';
  List<String>? roles;
  String flatNumber = 'NA';
  String apartmentName = 'NA';
  int id = 0;
  String? profilePictureUrl = '',email,mobileNumber;
  int? apartmentId;
  int? flatId;
  bool? isAdmin;
  bool? isOwner;
  String? nivaasId, planEndDate;
  bool? isHelper;
  bool showMore = false;
  DateTime? endDate;
  List<Content>? firstGuestData;
  final switchApartmentUsecase = SwitchApartmentUsecase(
      repository: SwitchApartmentRepositoryimpl(
          datasource: SwitchApartmentDatasource(apiClient: ApiClient())));
  final guestInviteEntriesUsecase = GuestInviteEntriesUsecase(
      repository: GuestInviteEntriesRepositoryimpl(
          datasource: GuestInviteEntriesDatasource(apiClient: ApiClient())));
  final checkinRequestUsecase = CheckinRequestUsecase(
      repository: CheckinRequestRepositoryimpl(
          datasource: CheckinRequestDatasource(apiClient: ApiClient())));
  final gateActivitiesUsecase = GateActivitiesUsecase(
      repository: GateActivitiesRepositoryimpl(
          datasource: GateActivitiesDatasource(apiClient: ApiClient())));

  Future<void> fetchCurrentCustomer() async {
    context.read<SplashBloc>().add(CheckTokenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashSuccess) {
          final currentUser = state.user;
        }
      },
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is SplashLoading) {
            return Center(child: AppLoader());
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
          } else if (state is SplashSuccess) {
            final currentUser = state.user;
            name = currentUser.user.name;
            id = currentUser.user.id;
            apartmentName = currentUser.currentApartment?.apartmentName ?? 'NA';
            flatNumber = currentUser.currentFlat?.flatNo ?? 'NA';
            apartmentId = currentUser.currentApartment?.id ?? 0;
            flatId = currentUser.currentFlat?.id ?? 0;
            email = currentUser.user.email;
            mobileNumber = currentUser.user.mobileNumber;
            profilePictureUrl = currentUser.user.profilePicture ?? '';
            roles = currentUser.user.roles;
            final int userId = currentUser.user.id;
            isAdmin = currentUser.currentApartment!.apartmentAdmin;
            isOwner = currentUser.user.roles.contains("ROLE_FLAT_OWNER");
            isHelper = currentUser.user.roles.contains("ROLE_APARTMENT_HELPER");
            nivaasId = currentUser.user.nivaasId;
            planEndDate = currentUser.currentApartment?.endDate;
            if (planEndDate != null) {
              try {
                endDate = DateTime.parse(planEndDate!);
              } catch (e) {
                endDate = null;
              }
            }
            context.read<AddGuestsBloc>().add(
                  FetchGuestStatus(
                    apartmentId: apartmentId!,
                    flatId: flatId!,
                    status: 'SECURITY_REQUESTED',
                  ),
                );
            return RefreshIndicator(
                onRefresh: fetchCurrentCustomer,
                child: Scaffold(
                  backgroundColor: AppColor.white,
                  appBar: AppBar(
                    flexibleSpace: Container(
                      decoration: BoxDecoration(color: AppColor.primaryColor1),
                    ),
                    automaticallyImplyLeading: false,
                    centerTitle: false,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            SwitchApartmentBloc(
                                                switchApartmentUsecase),
                                        child: SwitchApartment(
                                          apartmentName: apartmentName,
                                          flatNo: flatNumber,
                                          apartmentId: apartmentId!,
                                          flatId: flatId ?? 0,
                                          userId: userId,
                                        ),
                                      ))).then((_) {
                            context.read<SplashBloc>().add(CheckTokenEvent());
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColor.white1)),
                          child: Text(
                            'Switch Flat/Apartment',
                            style: txt_11_500.copyWith(color: AppColor.white1),
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                              Compliance(isAdmin: isAdmin!,apartmentId: apartmentId!,)));
                        }, 
                        icon: Image.asset(compliance, color: AppColor.white, height: 20,)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationScreen()));
                            },
                            icon: Icon(
                              Icons.notifications_none_rounded,
                              size: 24,
                              color: AppColor.white1,
                            )),
                      )
                    ],
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: AppGradients.gradient1,
                          // border: Border.all(color: AppColor.primaryColor1)
                        ),
                        margin: EdgeInsets.all(0),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 64,
                                      height: 64,
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: AppColor.blueShade,
                                        backgroundImage: profilePictureUrl != ''
                                            ? NetworkImage(profilePictureUrl ?? '')
                                            : const AssetImage(defaultUser)
                                                as ImageProvider,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 17,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name.length > 10
                                              ? '${name.substring(0, 10)}...'
                                              : name,
                                          style: txt_24_600.copyWith(
                                              color: AppColor.white),
                                        ),
                                        Text(
                                          (isAdmin! && isOwner!)
                                              ? 'Admin, Owner'
                                              : (isAdmin! &&
                                                      roles!.contains(
                                                          'ROLE_FLAT_TENANT'))
                                                  ? 'Admin, Tenant'
                                                  : (isAdmin! &&
                                                          roles!.contains(
                                                              'ROLE_FLAT_FAMILY_MEMBER'))
                                                      ? 'Admin, Family Member'
                                                      : roles!.contains(
                                                              'ROLE_FLAT_FAMILY_MEMBER')
                                                          ? 'Family Member'
                                                          : isOwner!
                                                              ? 'Owner'
                                                              : roles!.contains(
                                                                      'ROLE_FLAT_TENANT')
                                                                  ? 'Tenant'
                                                                  : isAdmin!
                                                                      ? 'Admin'
                                                                      : isHelper!
                                                                          ? 'Security Guard'
                                                                          : 'User',
                                          style: txt_14_400.copyWith(
                                              color: AppColor.white2),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          flatNumber.length > 10
                                              ? '${flatNumber.substring(0, 8)}...'
                                              : flatNumber,
                                          style: txt_22_700.copyWith(
                                              color: AppColor.white2),
                                        ),
                                        Text(
                                          'Flat No',
                                          style: txt_12_400.copyWith(
                                              color: AppColor.white2),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          (apartmentName.length > 10 &&
                                                  flatNumber.length > 10)
                                              ? '${apartmentName.substring(0, 8)}...'
                                              : (apartmentName.length > 12)
                                                  ? '${apartmentName.substring(0, 12)}...'
                                                  : apartmentName,
                                          style: txt_22_700.copyWith(
                                              color: AppColor.white2),
                                        ),
                                        Text(
                                          'Community Name',
                                          style: txt_12_400.copyWith(
                                              color: AppColor.white2),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          nivaasId!,
                                          style: txt_22_700.copyWith(
                                              color: AppColor.white2),
                                        ),
                                        Text(
                                          'Nivaas Id',
                                          style: txt_12_400.copyWith(
                                              color: AppColor.white2),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                if (!isHelper!)
                                  ConfiguredVisitors(
                                    apartmentId: apartmentId!,
                                    flatId: flatId!,
                                  )
                              ],
                            )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (endDate != null && isAdmin!) ...[
                                  if ((DateTime.now().isBefore(endDate!) &&
                                          endDate!
                                                  .difference(DateTime.now())
                                                  .inDays <
                                              7) ||
                                      DateTime.now().isAfter(endDate!))
                                    AlertMessages(
                                      currentDate: DateTime.now(),
                                      endDate: endDate!,
                                      apartmentId: apartmentId,
                                      apartmentName: apartmentName,
                                      userId: id,
                                      mobileNumber: mobileNumber,
                                      email: email,
                                    ),
                                ],
                                BlocConsumer<AddGuestsBloc, AddGuestsState>(
                                  listener: (context, state) {
                                    if (state is GuestStatusSuccess) {
                                      if (state.data.numberOfElements! >= 1) {
                                        firstGuestData = state.data.content;
                                        showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) =>
                                              NotificationPopup(
                                                  contentList:
                                                      firstGuestData ?? []),
                                        );
                                      }
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is GuestStatusFailure) {
                                      return Center(child: SizedBox(width: 1));
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                                Text(
                                  'Quick Access',
                                  style: txt_14_600.copyWith(
                                      color: AppColor.black2),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                GridView.count(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 10,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    childAspectRatio: 0.9,
                                    children: [
                                      if (!isHelper!) ...[
                                        _QuickAccessItems(
                                            image: buildingIcon,
                                            title: 'Manage Flat',
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FlatView()));
                                            }),
                                        _QuickAccessItems(
                                            image: complaintsIcon,
                                            title: 'My Complaints',
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyComplaints(
                                                            apartmentId:
                                                                apartmentId,
                                                            flatId: flatId,
                                                            isAdmin: isAdmin,
                                                            isOwner: isOwner,
                                                            userId: id,
                                                            currentApartment:
                                                                apartmentName,
                                                            isLeftSelected:
                                                                false,
                                                          )));
                                            }),
                                        _QuickAccessItems(
                                            image: bills,
                                            title: 'Society Dues',
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserDues(
                                                              apartmentId:
                                                                  apartmentId,
                                                              flatID: flatId)));
                                            }),
                                        _QuickAccessItems(
                                            image: newrequest,
                                            title: 'Requests',
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Requests(
                                                            flatId: flatId ?? 0,
                                                            apartmentId:
                                                                apartmentId ??
                                                                    0,
                                                            isOwner: isOwner!,
                                                            isAdmin: isAdmin!,
                                                          )));
                                            }),
                                        _QuickAccessItems(
                                            image: notices,
                                            title: 'Notice board',
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NoticeBoard(
                                                            apartmentId:
                                                                apartmentId!,
                                                            isAdmin: isAdmin,
                                                            isLeftSelected:
                                                                false,
                                                            isOwner: isOwner,
                                                          )));
                                            }),
                                        if (!isAdmin!)
                                          _QuickAccessItems(
                                              image: gateIcon,
                                              title: 'Gate Management',
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GuestInvite(
                                                                apartmentId:
                                                                    apartmentId,
                                                                flatId:
                                                                    flatId))).then(
                                                    (_) {
                                                  context
                                                      .read<SplashBloc>()
                                                      .add(CheckTokenEvent());
                                                });
                                              }),
                                        if (isAdmin! && !showMore)
                                          _QuickAccessItems(
                                              image: showmore,
                                              title: 'Explore More',
                                              onTap: () {
                                                setState(() {
                                                  showMore = true;
                                                });
                                              }),
                                        if (isAdmin! && showMore) ...[
                                          _QuickAccessItems(
                                              image: manageApartments,
                                              title: 'Manage Apartment',
                                              onTap: () {
                                                setState(() {
                                                  showMore = false;
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ManageApt(
                                                              apartmentId:
                                                                  apartmentId!)),
                                                );
                                              }),
                                          _QuickAccessItems(
                                              image: gateIcon,
                                              title: 'Gate Management',
                                              onTap: () {
                                                setState(() {
                                                  showMore = false;
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GuestInvite(
                                                                apartmentId:
                                                                    apartmentId,
                                                                flatId:
                                                                    flatId))).then(
                                                    (_) {
                                                  context
                                                      .read<SplashBloc>()
                                                      .add(CheckTokenEvent());
                                                });
                                              }),
                                          _QuickAccessItems(
                                              image: showmore,
                                              title: 'Show Less',
                                              onTap: () {
                                                setState(() {
                                                  showMore = false;
                                                });
                                              })
                                        ]
                                      ],
                                      // _QuickAccessItems(
                                      //     image: services,
                                      //     title: 'Services',
                                      //     onTap: () {
                                      //       Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   AddServiceProviders(
                                      //                       apartmentId:
                                      //                           apartmentId)));
                                      //     }),
                                      if (isHelper!) ...[
                                        _QuickAccessItems(
                                            image: gateIcon,
                                            title: 'Guest Invite Entries',
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                            create: (context) =>
                                                                GuestInviteEntriesBloc(
                                                                    guestInviteEntriesUsecase),
                                                            child:
                                                                GuestInviteEntries(
                                                              apartmentId:
                                                                  apartmentId!,
                                                            ),
                                                          )));
                                            }),
                                        _QuickAccessItems(
                                            image: checkinEntryIcon,
                                            title: 'Check-In Entry',
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                            create: (context) =>
                                                                CheckinRequestBloc(
                                                                    checkinRequestUsecase),
                                                            child: CheckInEntry(
                                                              apartmentId:
                                                                  apartmentId!,
                                                            ),
                                                          )));
                                            }),
                                        _QuickAccessItems(
                                            image: gateActivities,
                                            title: 'Gate Activities',
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                            create: (context) =>
                                                                GateActivitiesBloc(
                                                                    gateActivitiesUsecase),
                                                            child:
                                                                GateActivities(
                                                              apartmentId:
                                                                  apartmentId!,
                                                            ),
                                                          )));
                                            })
                                      ]
                                    ]),
                                SizedBox(
                                  height: isHelper! ? 60 : 30,
                                ),
                                ImageSlider(),
                                if (isHelper!)
                                  SizedBox(
                                    height: 200,
                                  )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}

class _QuickAccessItems extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const _QuickAccessItems(
      {required this.image, required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.blueShade,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              color: AppColor.blue,
              height: 40,
              width: 40,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                child: Text(
                  title,
                  style: txt_12_500.copyWith(color: AppColor.black2),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
