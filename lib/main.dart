import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nivaas/core/utils/injection_files/injection.dart';
import 'package:nivaas/data/provider/network/api/profile/profile_upload_data_source.dart';
import 'package:nivaas/data/repository-impl/profile/upload_profile_repository_impl.dart';
import 'package:nivaas/domain/usecases/auth/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nivaas/firebase_options.dart';
import 'package:nivaas/screens/apartmentOnboarding/bloc/apartment_onboarding_bloc.dart';
import 'package:nivaas/screens/coins-subscription/subscription/bloc/subscription_bloc.dart';
import 'package:nivaas/screens/compliance/bloc/compliance_bloc.dart';
import 'package:nivaas/screens/dues-meters/admin-dues/bloc/admin_dues_bloc.dart';
import 'package:nivaas/screens/dues-meters/generate-bill/bloc/generate_bill_bloc.dart';
import 'package:nivaas/screens/dues-meters/maintainance/bloc/maintainance_bloc.dart';
import 'package:nivaas/screens/dues-meters/transaction-history/bloc/transaction_history_bloc.dart';
import 'package:nivaas/screens/dues-meters/user-dues/bloc/user_dues_bloc.dart';
import 'package:nivaas/screens/expenseSplitter/expenseSplitterDetails/bloc/expense_splitter_details_bloc.dart';
import 'package:nivaas/screens/gate-management/configuredVisitors/bloc/configured_visitors_bloc.dart';
import 'package:nivaas/screens/gate-management/preview/bloc/add_guests_bloc.dart';
import 'package:nivaas/screens/manageApartment/bloc/all_flats_bloc.dart';
import 'package:nivaas/screens/notices/create-post/bloc/create_post_bloc.dart';
import 'package:nivaas/screens/notices/notifications/bloc/notifications_bloc.dart';
import 'package:nivaas/screens/prepaid-meters/Add-Consumption/bloc/add_consumption_bloc.dart';
import 'package:nivaas/screens/prepaid-meters/Add-prepaid_meter/bloc/add_prepaid_meter_bloc.dart';
import 'package:nivaas/screens/prepaid-meters/add-MeterReadings/bloc/add_meter_readings_bloc.dart';
import 'package:nivaas/screens/prepaid-meters/meter-consumption/bloc/meter_consumption_bloc.dart';
import 'package:nivaas/screens/search-community/apartment_details/bloc/flat_bloc.dart';
import 'package:nivaas/screens/auth/otp/bloc/otp_bloc.dart';
import 'package:nivaas/screens/coins-subscription/coins-wallet/bloc/coins_wallet_bloc.dart';
import 'package:nivaas/screens/complaints/my-complaints/bloc/my_complaints_bloc.dart';
import 'package:nivaas/screens/home-profile/edit-profile/bloc/edit_profile_bloc.dart';
import 'package:nivaas/screens/notices/notice-board/bloc/notice_board_bloc.dart';
import 'package:nivaas/screens/coins-subscription/purchase-plan/bloc/purchase_plan_bloc.dart';
import 'package:nivaas/screens/complaints/raise-complaint/bloc/raise_complaint_bloc.dart';
import 'package:nivaas/screens/auth/splashScreen/splash_screen.dart';
import 'package:nivaas/screens/complaints/view-complaints/bloc/view_complaints_bloc.dart';
import 'package:nivaas/screens/search-community/requests/flat_apartment_requests/bloc/my_requests_bloc.dart';
import 'package:nivaas/screens/services/service-popup/bloc/add_service_provider_bloc.dart';
import 'package:nivaas/widgets/others/Transaction-popup/bloc/transaction_popup_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'data/provider/network/service/api_client.dart';
import 'domain/usecases/auth/login_send_otp_usecase.dart';
import 'domain/usecases/auth/login_verify_otp_usecase.dart';
import 'domain/usecases/auth/signup_send_otp_usecase.dart';
import 'domain/usecases/auth/signup_verify_otp_usecase.dart';
import 'screens/search-community/searchYourCommunity/bloc/search_your_community_bloc.dart';
import 'screens/auth/splashScreen/bloc/splash_bloc.dart';

@pragma('vm:entry-point')
// Firebase Background Message Handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully");
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } catch (e) {
    print("Firebase initialization error: $e");
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final injection = Injection();
  await injection.init();
  final apiClient = ApiClient();

  runApp(
    MultiBlocProvider(
      providers: [
        Provider<ApiClient>(create: (_) => ApiClient()),
        BlocProvider<SplashBloc>(
          create: (_) => SplashBloc(
              userUsecase: UserUsecase(repository: injection.userRepository),
              apiClient: apiClient),
        ),
        BlocProvider<OtpBloc>(
          create: (_) => OtpBloc(
            loginSendOtpUseCase:
                LoginSendOtpUseCase(repository: injection.loginRepository),
            loginVerifyOtpUseCase:
                LoginVerifyOtpUseCase(repository: injection.loginRepository),
            signupSendOtpUsecase:
                SignupSendOtpUsecase(repository: injection.signupRepository),
            signupVerifyOtpUseCase:
                SignupVerifyOtpUseCase(repository: injection.signupRepository),
            apiClient: apiClient,
          ),
        ),
        BlocProvider<SearchYourCommunityBloc>(
            create: (_) => SearchYourCommunityBloc(
                injection.searchYourCommunityUsecase)),
        BlocProvider<AllFlatsBloc>(create: (_)=> AllFlatsBloc(injection.allFlatsUsecase)),
        BlocProvider<FlatBloc>(
            create: (_) => FlatBloc(
                injection.flatUseCase, injection.flatSendRequestUseCase)),
        BlocProvider<EditProfileBloc>(
          create: (_) => EditProfileBloc(
            editProfileRepository: injection.editProfileRepository,
            profilePicRepository: ProfilePicRepositoryImpl(
              dataSource: ProfilePicDataSource(apiClient: apiClient),
            ),
            logoutUserUseCase : injection.logoutUserUseCase,
          ),
        ),
        BlocProvider<NoticeBoardBloc>(
            create: (_) => NoticeBoardBloc(
                repository: injection.noticeBoardRepository)),
        BlocProvider<MyComplaintsBloc>(
            create: (_) => MyComplaintsBloc(
                repository: injection.myComplaintsRepository)),
        BlocProvider<UserDuesBloc>(
            create: (_) => UserDuesBloc(
                repository: injection.useDuesRepository)),
        BlocProvider<RaiseComplaintBloc>(
            create: (_) => RaiseComplaintBloc(
                repository: injection.raiseComplaintRepository,
                adminsRepository: injection.adminsRepository)),
        BlocProvider<CreatePostBloc>(
            create: (_) => CreatePostBloc(
                repository: injection.createPostRepositoryImpl,
                editNoticeUseCase: injection.editNoticeBoardUseCase)),
        BlocProvider<CoinsWalletBloc>(
            create: (_) => CoinsWalletBloc(
                repository: injection.coinsWalletRepository,
                balanceRepository: injection.coinsBalanceRepository)),
        BlocProvider<SubscriptionBloc>(
            create: (_) => SubscriptionBloc(
                repository: injection.subscriptionRepository)),
        BlocProvider<PurchasePlanBloc>(
            create: (_) => PurchasePlanBloc(
                repository: injection.purchasePlanRepository,useCase: injection.createPaymentOrderUseCase,verifyPaymentOrderUseCase:injection.verifyPaymentOrderUseCase)),
        BlocProvider<ViewComplaintsBloc>(
            create: (_) => ViewComplaintsBloc(
                complaintsRepository: injection.reassignComplaintRepository,
                ownersRepository: injection.ownersRepository)),
        BlocProvider<ApartmentOnboardingBloc>(
            create: (_) => ApartmentOnboardingBloc(
                injection.apartmentOnboardingUsecase)),
        BlocProvider<AdminDuesBloc>(
            create: (_) => AdminDuesBloc(
                repository: injection.adminDuesRepository,
                updateDueRepository: injection.updateDueRepository)),
        BlocProvider<MaintainanceBloc>(
          create: (_) => MaintainanceBloc(
              repository: injection.currentBalanceRepository,
              transactionRepository: injection.transactioHistoryRepository,
              refreshBalanceUsecase: injection.refreshBalanceUsecase),
        ),
        BlocProvider<GetNotificationsBloc>(
            create: (_) => GetNotificationsBloc(
                injection.getNotificationUsecase,
                injection.deleteNotificationUsecase)),
        BlocProvider<FilterTransactionHistoryBloc>(
            create: (_) => FilterTransactionHistoryBloc(
                useCase: injection.filterTransactionHistoryUsecase,
                apiClient: ApiClient(),
                getPdfUseCase: injection.getPdfDataUsecase)),
        BlocProvider<PrepaidMeterBloc>(
            create: (_) => PrepaidMeterBloc(
                injection.fetchPrepaidMetersUseCase)),
        BlocProvider<AddConsumptionBloc>(
            create: (_) => AddConsumptionBloc(
                injection.addConsumptionUseCase,
                injection.lastAddedConsumptionUseCase,
                injection.getSingleFlatConsumptionUsecase)),
        BlocProvider<GenerateBillBloc>(
            create: (_) => GenerateBillBloc(
                injection.lastAddedGenerateBillUseCase,
                injection.postGenerateBillUseCase)),
        BlocProvider<MyRequestsBloc>(
            create: (_) => MyRequestsBloc(
                injection.myRequestsUseCase,
                injection.remaindRequestUseCase)),
        BlocProvider<AddPrepaidMeterBloc>(
            create: (_) => AddPrepaidMeterBloc(
                injection.addPrepaidMeterConsumptionUseCase,
                injection.editPrepaidMeterUseCase)),
        BlocProvider<AddMeterReadingsBloc>(
            create: (_) => AddMeterReadingsBloc(
                injection.getMeterReadingsUseCase,
                injection.postMeterReadingUseCase,
                injection.getsingleMeterReadingsUseCase)),
        BlocProvider<TransactionPopupBloc>(
            create: (_) => TransactionPopupBloc(
                injection.addDebitMaintainenceUseCase,
                injection.addCreditMaintainanceRepository,
                injection.editDebitMaintainanceUseCase,
                injection.editCreditMaintainanceUseCase,
                injection.deleteDebitHistoryUseCase,
                injection.deleteCreditHistoryUseCase)),
        BlocProvider<AddServiceProviderBloc>(
            create: (_) => AddServiceProviderBloc(injection.addServiceProviderUsecase,injection.getServiceProviderUsecase)),
        BlocProvider<AddGuestsBloc>(
            create: (_) => AddGuestsBloc(injection.addGuestsUseCase,injection.handleGuestStatusUsecase,injection.updateGuestStatusUseCase)),
        BlocProvider<ConfiguredVisitorsBloc>(create: (_) => ConfiguredVisitorsBloc(injection.configuredVisitorsUsecase),),
        BlocProvider<ComplianceBloc>(create: (_)=> ComplianceBloc(injection.complianceUsecase)),
        BlocProvider<ExpenseSplitterDetailsBloc>(create: (_)=> ExpenseSplitterDetailsBloc(injection.editSplitterDetailsUseCase)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final NetworkCheckService networkCheckService = NetworkCheckService();
    return MaterialApp(
      title: 'Nivaas',
      // routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent, elevation: 0),
        useMaterial3: true,
      ),
      home:SplashScreen(),);
  }
}
