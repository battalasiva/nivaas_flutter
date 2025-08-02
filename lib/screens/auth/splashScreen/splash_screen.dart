import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/utils/push-notifications/PushNotificationServices.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/screens/auth/login/login.dart';
import 'package:nivaas/screens/auth/splashScreen/SplashFailureWidget.dart';
import 'package:nivaas/screens/home-profile/edit-profile/bloc/edit_profile_bloc.dart';
import 'package:nivaas/screens/search-community/communityAndRequest/community_and_request.dart';
import 'package:nivaas/screens/auth/splashScreen/bloc/splash_bloc.dart';
import 'package:nivaas/widgets/elements/bottom_tab.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  NotificationServices notificationServices = NotificationServices();
  final ApiClient _apiClient = ApiClient();
  int? id;
  String? fcmToken, fullName, email, gender;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    Future.delayed(const Duration(seconds: 2), () {
      checkForUpdate();
    });
    permissions();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> checkForUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        showUpdateDialog(updateInfo);
      } else {
        proceedWithAppFlow();
      }
    } catch (e) {
      print("Error checking for update: $e");
      proceedWithAppFlow();
    }
  }

  void showUpdateDialog(AppUpdateInfo updateInfo) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Available'),
          content: Text(
              'A new version of the app is available. Please update to continue.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                proceedWithAppFlow();
              },
              child: Text('Remind Me Later'),
            ),
            TextButton(
              onPressed: () {
                InAppUpdate.performImmediateUpdate().then((_) {
                  proceedWithAppFlow();
                }).catchError((e) {
                  print("Error performing update: $e");
                  proceedWithAppFlow();
                });
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void proceedWithAppFlow() {
    fetchCurrentCustomerData();
  }

  fetchCurrentCustomerData() {
    context.read<SplashBloc>().add(CheckTokenEvent());
  }

  Future<void> permissions() async {
    await notificationServices.requestNotificationPermissions();
    await FlutterContacts.requestPermission();
  }

  Future<void> generateToken() async {
    await notificationServices.forgroundMessage();
    await notificationServices.firebaseInit(context);
    await notificationServices.setupInteractMessage(context);
    await notificationServices.isRefreshToken();
    String? token = await notificationServices.getDeviceToken();
    if (mounted && token != null) {
      print('FCM Token: $token');
      fcmToken = token;
      Future.microtask(() => sendFcmToken());
    }
  }

  void sendFcmToken() {
    if (!mounted) {
      print("Widget is unmounted, skipping sendFcmToken()");
      return;
    }
    if (id == null || fullName == null || fcmToken == null) {
      print("Cannot send FCM Token, data is missing");
      return;
    }
    if (mounted) {
      context.read<EditProfileBloc>().add(EditProfileSubmitted(
            id: id.toString(),
            fullName: fullName!,
            email: email ?? '',
            fcmToken: fcmToken!,
            gender: gender ?? '',
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async {
        if (state is SplashSuccess) {
          final currentUser = state.user;
          id = currentUser.user.id;
          fullName = currentUser.user.name;
          email = currentUser.user.email;
          gender = currentUser.user.gender;
          await generateToken();
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomTab()),
            );
          }
        } else if (state is SplashApartmentNotFound) {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const CommunityAndRequest(source: 'splash')),
            );
          }
        } else if (state is SplashFailureTokenNotFound) {
          print("❌ Navigating to Login");
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          }
        } else if (state is SplashFailure) {
          print("${state.message}");
        }
      },
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is SplashFailure) {
            return SplashFailureWidget(
              onRefresh: fetchCurrentCustomerData,
              onLogout: () async {
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
            );
          }
          return Scaffold(
            backgroundColor: AppColor.white,
            body: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/splashScreen.png',
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
