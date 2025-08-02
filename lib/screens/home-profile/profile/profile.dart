import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/gradients.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/auth/current_customer_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/screens/auth/login/login.dart';
import 'package:nivaas/screens/home-profile/edit-profile/EditProfileScreen.dart';
import 'package:nivaas/screens/auth/splashScreen/bloc/splash_bloc.dart';
import 'package:nivaas/screens/home-profile/edit-profile/bloc/edit_profile_bloc.dart';
import 'package:nivaas/screens/home-profile/terms-and-conditions/TermsAndConditions.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/ConfirmationDialog.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/others/ContactUsModel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiClient _apiClient = ApiClient();
  CurrentCustomerModel? _currentUser;
  final String message =
      '''Hi! We've been using the Nivaas App in our apartment, and it's been really helpful. Highly recommend it for your apartment!
Android: https://play.google.com/store/apps/details?id=com.nivaas&hl=en

iOS: https://apps.apple.com/in/app/nivaas/id6639611241''';
  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  void fetchUserDetails() {
    final splashState = context.read<SplashBloc>().state;
    if (splashState is SplashSuccess) {
      _currentUser = splashState.user;
    }
  }

  void showContactUsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ContactUsModal(),
    );
  }

  Future<void> fetchCurrentCustomer() async {
    context.read<SplashBloc>().add(CheckTokenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Profile'),
      body: Padding(
        padding: EdgeInsets.all(getWidth(context) * 0.05),
        child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashSuccess) {
              setState(() {
                _currentUser = state.user;
              });
            }
          },
          builder: (context, state) {
            if (state is SplashLoading) {
              return Center(
                child: AppLoader(),
              );
            } else if (_currentUser != null) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: AppGradients.gradient1,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 29, vertical: 14),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColor.grey,
                              backgroundImage:
                                  _currentUser!.user.profilePicture != null
                                      ? NetworkImage(
                                          _currentUser!.user.profilePicture!)
                                      : const AssetImage(defaultUser)
                                          as ImageProvider,
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      _currentUser!.user.name,
                                      style: txt_22_700.copyWith(
                                          color: AppColor.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _currentUser!.user.mobileNumber,
                                    style: txt_14_700.copyWith(
                                        color: AppColor.white),
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      _currentUser!.user.email ?? '',
                                      style: txt_14_700.copyWith(
                                          color: AppColor.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: getWidth(context) / 1.8,
                                  child: Text(
                                    _currentUser!
                                            .currentApartment?.apartmentName ??
                                        '',
                                    style: txt_16_700.copyWith(
                                        color: AppColor.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Flat Number: ',
                                      style: txt_11_500.copyWith(
                                          color: AppColor.white),
                                    ),
                                    Text(
                                      _currentUser!.currentFlat?.flatNo ?? 'NA',
                                      style: txt_16_500.copyWith(
                                          color: AppColor.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfileScreen(
                                            name: _currentUser!.user.name,
                                            mobileNumber:
                                                _currentUser!.user.mobileNumber,
                                            email:
                                                _currentUser!.user.email ?? '',
                                            id: _currentUser!.user.id,
                                            profilePic: _currentUser!
                                                .user.profilePicture,
                                            gender: _currentUser!.user.gender),
                                      ),
                                    ).then((result) {
                                      if (result == true) {
                                        print('Called');
                                        fetchCurrentCustomer();
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Edit Info',
                                        style: txt_12_600.copyWith(
                                            color: AppColor.white),
                                      ),
                                      Icon(
                                        Icons.edit,
                                        color: AppColor.white,
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.article),
                          title: Text(
                            'Terms and conditions',
                            style: txt_16_500.copyWith(color: AppColor.black),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermsAndConditions()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.help),
                          title: Text(
                            'Help & support',
                            style: txt_16_500.copyWith(color: AppColor.black),
                          ),
                          onTap: () {
                            showContactUsModal(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.share),
                          title: Text(
                            'Help your friend with Nivaas',
                            style: txt_16_500.copyWith(color: AppColor.black),
                          ),
                          onTap: () => shareFunction(message),
                        ),
                        ListTile(
                          leading: Icon(Icons.logout, color: AppColor.red),
                          title: Text(
                            'Logout',
                            style: txt_16_500.copyWith(color: AppColor.red2),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ConfirmationDialog(
                                title: 'Are you sure you want to logout?',
                                onConfirm: () async {
                                  context.read<EditProfileBloc>().add(
                                      LogoutButtonPressed(
                                          userId: _currentUser!.user.id
                                              .toString()));
                                  await _apiClient.logout();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                    (route) => false,
                                  );
                                },
                                onCancel: () => Navigator.of(context).pop(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "App Version : 2.0.5",
                        style: txt_15_500.copyWith(color: AppColor.black1),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Text(
                  'An error occurred.',
                  style: txt_16_500.copyWith(color: AppColor.black),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
