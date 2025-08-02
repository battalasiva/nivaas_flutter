import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/gradients.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/screens/apartmentOnboarding/search_city.dart';
import 'package:nivaas/screens/auth/login/login.dart';
import 'package:nivaas/screens/home-profile/edit-profile/bloc/edit_profile_bloc.dart';
import 'package:nivaas/screens/search-community/requests/requests.dart';
import 'package:nivaas/screens/search-community/searchYourCommunity/search_community.dart';
import 'package:nivaas/widgets/elements/ConfirmationDialog.dart';
import 'package:nivaas/widgets/elements/bottom_tab.dart';
import '../../auth/splashScreen/bloc/splash_bloc.dart';

class CommunityAndRequest extends StatefulWidget {
  final String source;
  const CommunityAndRequest({super.key, required this.source});

  @override
  State<CommunityAndRequest> createState() => _CommunityAndRequestState();
}

class _CommunityAndRequestState extends State<CommunityAndRequest> {
  final ApiClient _apiClient = ApiClient();

  Widget _card(String image, String text1, String text2, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: getWidth(context) * 0.45,
        decoration: BoxDecoration(
          gradient: AppGradients.gradient1,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image),
            const SizedBox(height: 15),
            Text(text1, style: txt_12_600.copyWith(color: AppColor.white1)),
            const SizedBox(height: 3),
            Text(text2, style: txt_10_400.copyWith(color: AppColor.white1)),
          ],
        ),
      ),
    );
  }

  String? name;
  bool isCurrentFlat = false;
  bool isAdmin = false;
  int? flatId, apartmentId, id;
  bool? isOwner;
  @override
  void initState() {
    context.read<SplashBloc>().add(CheckTokenEvent());
    super.initState();
  }

  Future<void> fetchCurrentCustomer() async {
    context.read<SplashBloc>().add(CheckTokenEvent());
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: 'Are you sure you want to logout?',
        onConfirm: () async {
          context
              .read<EditProfileBloc>()
              .add(LogoutButtonPressed(userId: id.toString()));
          print('id------ $id');
          await _apiClient.logout();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login()),
            (route) => false,
          );
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        print('state------ $state');
        if (state is SplashApartmentNotFound) {
          setState(() {
            name = state.user.user.name;
            print(name);
          });
        } else if (state is SplashSuccess) {
          setState(() {
            name = state.user.user.name;
            id = state.user.user.id;
            isCurrentFlat = (state.user.currentFlat != null);
            isAdmin = (state.user.currentApartment?.apartmentAdmin == true);
            flatId = state.user.currentFlat?.id;
            apartmentId = state.user.currentApartment?.id;
            isOwner =
                (state.user.user.roles.contains('ROLE_FLAT_OWNER') == true);
            print('is Admin -------- $isAdmin');
          });
          if (widget.source == 'signup') {
            if (state.user.currentFlat != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomTab()),
              );
            }
          }
        }
      },
      child: RefreshIndicator(
        onRefresh: fetchCurrentCustomer,
        child: Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(
              backgroundColor: AppColor.white,
              actions: [
                IconButton(
                  icon: Icon(Icons.logout, color: AppColor.red),
                  onPressed: () => showLogoutDialog(context),
                ),
              ],
              leading: (isCurrentFlat || isAdmin)
                  ? Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: const Icon(Icons.home),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomTab()));
                          },
                        );
                      },
                    )
                  : null),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: getHeight(context) * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Container(
                        height: getHeight(context) * 0.15,
                        child: Center(child: Image.asset(nivaasLogo))),
                  ),
                  Container(
                    height: getHeight(context) * 0.15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('Hello, $name!',
                        style:
                            txt_17_800.copyWith(color: AppColor.primaryColor1)),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('What Do You Want?',
                        style:
                            txt_14_400.copyWith(color: AppColor.primaryColor1)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _card(
                        communityPeople,
                        'Search Your\nCommunity',
                        'Join Your Community\nAnd Manage Your Home',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchCommunity(
                                        source: widget.source,
                                      )));
                        },
                      ),
                      _card(
                        request,
                        ' \n Requests',
                        'Book Amenities In Your \nCommunity',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Requests(
                                        flatId: flatId ?? 0,
                                        apartmentId: apartmentId ?? 0,
                                        isOwner: isOwner ?? false,
                                        isAdmin: isAdmin,
                                      )));
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  _card(communityPeople, ' \nOnboard Apartment',
                      'Add Your Apartment And \nManage', () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchCity()));
                  }),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
