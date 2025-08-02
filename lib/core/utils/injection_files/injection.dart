import 'package:flutter/material.dart';
import 'package:nivaas/data/provider/network/api/apartmentOnboarding/apartment_onboarding_datasource.dart';
import 'package:nivaas/data/provider/network/api/apartmentOnboarding/my_requests_datasource.dart';
import 'package:nivaas/data/provider/network/api/apartmentOnboarding/remaind_request_datasource.dart';
import 'package:nivaas/data/provider/network/api/auth/login_data_source.dart';
import 'package:nivaas/data/provider/network/api/auth/signup_data_source.dart';
import 'package:nivaas/data/provider/network/api/auth/user_data_source.dart';
import 'package:nivaas/data/provider/network/api/coins-subscription/CoinsBalance_DataSource.dart';
import 'package:nivaas/data/provider/network/api/coins-subscription/CoinsWallet_DataSource.dart';
import 'package:nivaas/data/provider/network/api/coins-subscription/create_payment_order_datasource.dart';
import 'package:nivaas/data/provider/network/api/coins-subscription/purchase_plan_datasource.dart';
import 'package:nivaas/data/provider/network/api/coins-subscription/subscription_data_source.dart';
import 'package:nivaas/data/provider/network/api/coins-subscription/verify_payment_order_datasource.dart';
import 'package:nivaas/data/provider/network/api/complaints/admins_list_dataSource.dart';
import 'package:nivaas/data/provider/network/api/complaints/my_complaint_data_source.dart';
import 'package:nivaas/data/provider/network/api/complaints/owners_list_datasource.dart';
import 'package:nivaas/data/provider/network/api/complaints/raise_complaint_data_source.dart';
import 'package:nivaas/data/provider/network/api/complaints/reassign_complaint_dataSource.dart';
import 'package:nivaas/data/provider/network/api/compliance/compliance_datasource.dart';
import 'package:nivaas/data/provider/network/api/dues/admin_due_data_source.dart';
import 'package:nivaas/data/provider/network/api/dues/last_added_generate_bill_datasource.dart';
import 'package:nivaas/data/provider/network/api/dues/post_generate_bill_datasource.dart';
import 'package:nivaas/data/provider/network/api/dues/updateDueStatus_data_source.dart';
import 'package:nivaas/data/provider/network/api/dues/userDue_data_source.dart';
import 'package:nivaas/data/provider/network/api/expenseSplitter/edit_splitter_details_datasource.dart';
import 'package:nivaas/data/provider/network/api/gate-management/add_guests_datasource.dart';
import 'package:nivaas/data/provider/network/api/gate-management/handle_guest_status_datasource.dart';
import 'package:nivaas/data/provider/network/api/gate-management/update_guest_status_datasource.dart';
import 'package:nivaas/data/provider/network/api/maintainance/add_credit_history_dataSource.dart';
import 'package:nivaas/data/provider/network/api/maintainance/add_debit_history_datasource.dart';
import 'package:nivaas/data/provider/network/api/maintainance/current_balance_dataSource.dart';
import 'package:nivaas/data/provider/network/api/maintainance/delete_credit_history_datasource.dart';
import 'package:nivaas/data/provider/network/api/maintainance/delete_debit_history_dataSource.dart';
import 'package:nivaas/data/provider/network/api/maintainance/edit_credit_maintainance_datasource.dart';
import 'package:nivaas/data/provider/network/api/maintainance/edit_debit_maintainance_dataSource.dart';
import 'package:nivaas/data/provider/network/api/maintainance/filter_transaction_history_datasource.dart';
import 'package:nivaas/data/provider/network/api/maintainance/get_pdf_datasource.dart';
import 'package:nivaas/data/provider/network/api/maintainance/refresh_balance_datasource.dart';
import 'package:nivaas/data/provider/network/api/maintainance/transaction_history_datasource.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/all_flats_datasource.dart';
import 'package:nivaas/data/provider/network/api/notice-board/create_post_data_source.dart';
import 'package:nivaas/data/provider/network/api/notice-board/delete_notification_data_source.dart';
import 'package:nivaas/data/provider/network/api/notice-board/edit_notice_data_source.dart';
import 'package:nivaas/data/provider/network/api/notice-board/notice_board_data_source.dart';
import 'package:nivaas/data/provider/network/api/notice-board/notification_data_source.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/add_consumption_datasource.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/add_prepaid_meter_consumption_datasource.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/edit_prepaid_meter_dataSource.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/get_meter_readings_datasource.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/get_singleFlat_consumption_datasource.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/get_single_meter_readings_datasource.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/last_added_consumption_datasource.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/post_meter_readings_datasource.dart';
import 'package:nivaas/data/provider/network/api/prepaid-meters/prepaidMeter_list_data_source.dart';
import 'package:nivaas/data/provider/network/api/profile/editProfile_data_source.dart';
import 'package:nivaas/data/provider/network/api/profile/logout_user_datasource.dart';
import 'package:nivaas/data/provider/network/api/search-community/flat_data_source.dart';
import 'package:nivaas/data/provider/network/api/search-community/search_your_community_data_source.dart';
import 'package:nivaas/data/provider/network/api/services/add_service_provider_datasource.dart';
import 'package:nivaas/data/provider/network/api/services/get_service_providers_list_datasource.dart';

import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/apartmentOnboarding/apartment_onboarding_repositoryimpl.dart';
import 'package:nivaas/data/repository-impl/apartmentOnboarding/my_requests_repository_impl.dart';
import 'package:nivaas/data/repository-impl/apartmentOnboarding/remaind_request_repository_impl.dart';
import 'package:nivaas/data/repository-impl/auth/login_repository_impl.dart';
import 'package:nivaas/data/repository-impl/auth/signup_repository_impl.dart';
import 'package:nivaas/data/repository-impl/auth/user_repository_impl.dart';
import 'package:nivaas/data/repository-impl/coins-subscription/CoinsBalance_Repository_Impl.dart';
import 'package:nivaas/data/repository-impl/coins-subscription/CoinsWallet_RepositoryImpl.dart';
import 'package:nivaas/data/repository-impl/coins-subscription/create_payment_order_repository_impl.dart';
import 'package:nivaas/data/repository-impl/coins-subscription/purchase_plan_repository_impl.dart';
import 'package:nivaas/data/repository-impl/coins-subscription/subscription_repository_impl.dart';
import 'package:nivaas/data/repository-impl/coins-subscription/verify_payment_order_repository_impl.dart';
import 'package:nivaas/data/repository-impl/complaints/admin_list_repository_impl.dart';
import 'package:nivaas/data/repository-impl/complaints/my_complaints_repository_impl.dart';
import 'package:nivaas/data/repository-impl/complaints/ownrs_list_repository_impl.dart';
import 'package:nivaas/data/repository-impl/complaints/raise_complaint_repository_impl.dart';
import 'package:nivaas/data/repository-impl/complaints/reassign_complaints_repository_impl.dart';
import 'package:nivaas/data/repository-impl/compliance/compliance_repositoryimpl.dart';
import 'package:nivaas/data/repository-impl/dues/admin_due_repository_impl.dart';
import 'package:nivaas/data/repository-impl/dues/last_added_generate_bill_repository_impl.dart';
import 'package:nivaas/data/repository-impl/dues/post_generate_bill_repository_impl.dart';
import 'package:nivaas/data/repository-impl/dues/updateDueStatus_repository_impl.dart';
import 'package:nivaas/data/repository-impl/dues/userDue_repository_impl.dart';
import 'package:nivaas/data/repository-impl/expenseSplitter/edit_Splitter_Details_Repository_impl.dart';
import 'package:nivaas/data/repository-impl/gate-management/add_guests_repository_impl.dart';
import 'package:nivaas/data/repository-impl/gate-management/handle_guest_status_repository_impl.dart';
import 'package:nivaas/data/repository-impl/gate-management/update_guest_status_repository_impl.dart';
import 'package:nivaas/data/repository-impl/maintainance/add_credit_history_repository_impl.dart';
import 'package:nivaas/data/repository-impl/maintainance/add_debit_history_repository_impl.dart';
import 'package:nivaas/data/repository-impl/maintainance/current_balance_repository_impl.dart';
import 'package:nivaas/data/repository-impl/maintainance/delete_credit_history_repository_impl.dart';
import 'package:nivaas/data/repository-impl/maintainance/delete_debit_history_repository_impl.dart';
import 'package:nivaas/data/repository-impl/maintainance/edit_credit_maintainance_repository_impl.dart';
import 'package:nivaas/data/repository-impl/maintainance/edit_debit_maintainance_repository_impl.dart';
import 'package:nivaas/data/repository-impl/maintainance/filter_transaction_history_repository_impl.dart';
import 'package:nivaas/data/repository-impl/maintainance/get_pdf_repository_impl.dart';
import 'package:nivaas/data/repository-impl/maintainance/refresh_balance_repository_impl.dart';
import 'package:nivaas/data/repository-impl/maintainance/transaction_history_repository_impl.dart';
import 'package:nivaas/data/repository-impl/manageApartment/all_flats_repository_impl.dart';
import 'package:nivaas/data/repository-impl/notice-board/create_post_repository_impl.dart';
import 'package:nivaas/data/repository-impl/notice-board/delete_notification_repository_impl.dart';
import 'package:nivaas/data/repository-impl/notice-board/edit_post_repository_impl.dart';
import 'package:nivaas/data/repository-impl/notice-board/get_notifications_repository_impl.dart';
import 'package:nivaas/data/repository-impl/notice-board/notice_board_repository_impl.dart';
import 'package:nivaas/data/repository-impl/prepaid-meters/PostMeterReadingsRepositoryImpl.dart';
import 'package:nivaas/data/repository-impl/prepaid-meters/add_consumption_repository_impl.dart';
import 'package:nivaas/data/repository-impl/prepaid-meters/add_prepaid_meter_consumption_repository_impl.dart';
import 'package:nivaas/data/repository-impl/prepaid-meters/edit_prepaid_meter_repository_impl.dart';
import 'package:nivaas/data/repository-impl/prepaid-meters/get_meter_readings_repository_impl.dart';
import 'package:nivaas/data/repository-impl/prepaid-meters/get_singleFlat_consumption_repository_impl.dart';
import 'package:nivaas/data/repository-impl/prepaid-meters/get_single_meter_readings_repository_impl.dart';
import 'package:nivaas/data/repository-impl/prepaid-meters/last_added_consumption_repository_impl.dart';
import 'package:nivaas/data/repository-impl/prepaid-meters/prepaidMeterList_repository_impl.dart';
import 'package:nivaas/data/repository-impl/profile/editProfile_repository_impl.dart';
import 'package:nivaas/data/repository-impl/profile/logout_user_repository_impl.dart';
import 'package:nivaas/data/repository-impl/search-community/flat_repository_impl.dart';
import 'package:nivaas/data/repository-impl/search-community/search_your_community_repository_impl.dart';
import 'package:nivaas/data/repository-impl/services/add_service_provider_repository_impl.dart';
import 'package:nivaas/data/repository-impl/services/get_service_providers_list_repository_impl.dart';
import 'package:nivaas/domain/usecases/apartmentOnboarding/apartment_onboarding_usecase.dart';
import 'package:nivaas/domain/usecases/apartmentOnboarding/my_requests_usecase.dart';
import 'package:nivaas/domain/usecases/coins-subscription/create_payment_order_usecase.dart';
import 'package:nivaas/domain/usecases/coins-subscription/verify_payment_order_usecase.dart';
import 'package:nivaas/domain/usecases/compliance/compliance_usecase.dart';
import 'package:nivaas/domain/usecases/dues/last_added_generate_bill_usecase.dart';
import 'package:nivaas/domain/usecases/dues/post_generate_bill_usecase.dart';
import 'package:nivaas/domain/usecases/expenseSplitter/edit_splitter_details_usecase.dart';
import 'package:nivaas/domain/usecases/gate-management/add_guests_usecase.dart';
import 'package:nivaas/domain/usecases/gate-management/handle_guest_status_usecase.dart';
import 'package:nivaas/domain/usecases/gate-management/update_guest_status_usecase.dart';
import 'package:nivaas/domain/usecases/gate-management/configured_visitors_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/add_debit_history_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/delete_credit_history_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/delete_debit_history_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/edit_credit_maintainance_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/edit_debit_maintainance_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/filter_transaction_history_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/get_pdf_usecase.dart';
import 'package:nivaas/domain/usecases/maintainance/refresh_balance_usecase.dart';
import 'package:nivaas/domain/usecases/manageApartment/all_flats_usecase.dart';
import 'package:nivaas/domain/usecases/notice-board/delete_notofication_usecase.dart';
import 'package:nivaas/domain/usecases/notice-board/edit_Notice_usecase.dart';
import 'package:nivaas/domain/usecases/notice-board/get_notifications_usecase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/PostMeterReadingsUseCase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/add_consumption_usecase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/add_prepaid_meter_consumption_usecase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/edit_prepaid_meter_usecase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/get_singleFlat_consumption_usecase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/get_single_meter_readings_usecase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/last_addedConsumption_usecase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/prepaidmeters_list_usecase.dart';
import 'package:nivaas/domain/usecases/profile/logout_user_usecase.dart';
import 'package:nivaas/domain/usecases/search-community/flat_usecase.dart';
import 'package:nivaas/domain/usecases/search-community/search_your_community_usecase.dart';
import 'package:nivaas/domain/usecases/services/add_service_provider_usecase.dart';
import 'package:nivaas/domain/usecases/services/get_service_providers_list_usecase.dart';

import '../../../data/provider/network/api/gate-management/configured_visitors_datasource.dart';
import '../../../data/repository-impl/gate-management/configured_visitors_repositoryimpl.dart';
import '../../../domain/usecases/apartmentOnboarding/remaind_request_usecase.dart';
import '../../../domain/usecases/prepaid-meters/get_meter_readings_usecase.dart';

class Injection {
  static final Injection _instance = Injection.internal();
  factory Injection() => _instance;
  Injection.internal();

  late final ApiClient apiClient;
  late final LoginRepositoryImpl loginRepository;
  late final SignupRepositoryImpl signupRepository;
  late final UserRepositoryImpl userRepository;
  late final FetchPrepaidMetersListUseCase fetchPrepaidMetersUseCase;
  late final MyComplaintsRepositoryImpl myComplaintsRepository;
  late final NoticeBoardRepositoryImpl noticeBoardRepository;
  late final UserDuesRepositoryImpl useDuesRepository;
  late final AdminsRepositoryImpl adminsRepository;
  late final RaiseComplaintRepositoryImpl raiseComplaintRepository;
  late final ReassignComplaintRepositoryImpl reassignComplaintRepository;
  late final OwnersRepositoryImpl ownersRepository;
  late final CreatePostRepositoryImpl createPostRepositoryImpl;
  late final EditNoticeUseCase editNoticeBoardUseCase;
  late final CoinsWalletRepositoryImpl coinsWalletRepository;
  late final CoinsBalanceRepositoryImpl coinsBalanceRepository;
  late final SubscriptionRepositoryImpl subscriptionRepository;
  late final PurchasePlanRepositoryImpl purchasePlanRepository;
  late final ApartmentOnboardingUsecase apartmentOnboardingUsecase;
  late final AdminDuesRepositoryImpl adminDuesRepository;
  late final UpdateDueRepositoryImpl updateDueRepository;
  late final CurrentBalanceRepositoryImpl currentBalanceRepository;
  late final PostDebitHistoryUseCase addDebitMaintainenceUseCase;
  late final AddCreditMaintainanceRepositoryImpl
      addCreditMaintainanceRepository;
  late final TransactionRepositoryImpl transactioHistoryRepository;
  late final EditCreditMaintainanceUseCase editCreditMaintainanceUseCase;
  late final EditDebitMaintainanceUseCase editDebitMaintainanceUseCase;
  late final DeleteCreditHistoryUseCase deleteCreditHistoryUseCase;
  late final DeleteDebitHistoryUseCase deleteDebitHistoryUseCase;
  late final GetNotificationsUseCase getNotificationUsecase;
  late final DeleteNotificationUseCase deleteNotificationUsecase;
  late final FilterTransactionHistoryUseCase filterTransactionHistoryUsecase;
  late final GetPdfUseCase getPdfDataUsecase;
  late final AddConsumptionUseCase addConsumptionUseCase;
  late final LastAddedConsumptionUseCase lastAddedConsumptionUseCase;
  late final LastAddedGenerateBillUseCase lastAddedGenerateBillUseCase;
  late final PostGenerateBillUseCase postGenerateBillUseCase;
  late final MyRequestsUseCase myRequestsUseCase;
  late final RemaindRequestUseCase remaindRequestUseCase;
  late final AddPrepaidMeterConsumptionUseCase
      addPrepaidMeterConsumptionUseCase;
  late final EditPrepaidMeterUsecase editPrepaidMeterUseCase;
  late final PostMeterReadingsUseCase postMeterReadingUseCase;
  late final GetSingleMeterReadingsUseCase getsingleMeterReadingsUseCase;
  late final GetMeterReadingsUseCase getMeterReadingsUseCase;
  late final EditProfileRepositoryImpl editProfileRepository;
  late final SearchYourCommunityUsecase searchYourCommunityUsecase;
  late final FlatsUseCase flatUseCase;
  late final FlatSendRequestUseCase flatSendRequestUseCase;
  late final RefreshBalanceUseCase refreshBalanceUsecase;
  late final GetSingleFlatLastAddedConsumptionUseCase
      getSingleFlatConsumptionUsecase;
  late final AllFlatsUsecase allFlatsUsecase;
  late final AddServiceProviderUseCase addServiceProviderUsecase;
  late final GetServiceProvidersListUseCase getServiceProviderUsecase;
  late final AddGuestsUseCase addGuestsUseCase;
  late final HandleGuestStatusUsecase handleGuestStatusUsecase;
  late final UpdateGuestStatusUseCase updateGuestStatusUseCase;
  late final EditSplitterDetailsUseCase editSplitterDetailsUseCase;
  late final ConfiguredVisitorsUsecase configuredVisitorsUsecase;
  late final LogoutUserUseCase logoutUserUseCase;
  late final ComplianceUsecase complianceUsecase;
  late final CreatePaymentOrderUseCase createPaymentOrderUseCase;
  late final VerifyPaymentOrderUseCase verifyPaymentOrderUseCase;

  Future<void> init() async {
    apiClient = ApiClient();
    final loginDataSource = LoginDataSource(apiClient: apiClient);
    loginRepository = LoginRepositoryImpl(dataSource: loginDataSource);
    final signupDataSource = SignupDataSource(apiClient: apiClient);
    signupRepository = SignupRepositoryImpl(dataSource: signupDataSource);
    final userDataSource = UserDataSource(apiClient: apiClient);
    userRepository = UserRepositoryImpl(userDataSource: userDataSource);
    final prepaidmeterslistDatasource =
        PrepaidMeterListDataSource(apiClient: apiClient);
    final prepaidMeterListRepositoryImpl =
        PrepaidMeterListRepositoryImpl(datasource: prepaidmeterslistDatasource);
    fetchPrepaidMetersUseCase = FetchPrepaidMetersListUseCase(
        repository: prepaidMeterListRepositoryImpl);
    final myComplaintsDataSource = MyComplaintsDataSource(apiClient: apiClient);
    myComplaintsRepository =
        MyComplaintsRepositoryImpl(dataSource: myComplaintsDataSource);
    final noticeboardDataSource = NoticeBoardDataSource(apiClient: apiClient);
    noticeBoardRepository =
        NoticeBoardRepositoryImpl(dataSource: noticeboardDataSource);
    final userduesDataSource = UserDuesDataSource(apiClient: apiClient);
    useDuesRepository = UserDuesRepositoryImpl(dataSource: userduesDataSource);
    final adminsDataSource = AdminsDataSource(apiClient: apiClient);
    adminsRepository = AdminsRepositoryImpl(adminsDataSource: adminsDataSource);
    final raiseComplaintDataSource =
        RaiseComplaintDataSource(apiClient: apiClient);
    raiseComplaintRepository =
        RaiseComplaintRepositoryImpl(dataSource: raiseComplaintDataSource);
    final reassignComplaintDataSource =
        ReassignComplaintDataSource(apiClient: apiClient);
    reassignComplaintRepository = ReassignComplaintRepositoryImpl(
        dataSource: reassignComplaintDataSource);
    final ownersDataSource = OwnersDataSource(apiClient: apiClient);
    ownersRepository = OwnersRepositoryImpl(remoteDataSource: ownersDataSource);
    final createPostDataSource = CreatePostDataSource(apiClient: apiClient);
    createPostRepositoryImpl =
        CreatePostRepositoryImpl(dataSource: createPostDataSource);
    final editNoticeDataSource = EditNoticeDataSource(apiClient: apiClient);
    final editNoticeRepositoryImpl =
        EditNoticeRepositoryImpl(dataSource: editNoticeDataSource);
    editNoticeBoardUseCase =
        EditNoticeUseCase(repository: editNoticeRepositoryImpl);
    final coinsWalletDataSource = CoinsWalletDataSource(apiClient: apiClient);
    coinsWalletRepository =
        CoinsWalletRepositoryImpl(dataSource: coinsWalletDataSource);
    final coinsBalanceDataSource = CoinsBalanceDataSource(apiClient: apiClient);
    coinsBalanceRepository =
        CoinsBalanceRepositoryImpl(dataSource: coinsBalanceDataSource);
    final subscriptionDataSource = SubscriptionDataSource(apiClient: apiClient);
    subscriptionRepository =
        SubscriptionRepositoryImpl(dataSource: subscriptionDataSource);
    final purchasePlanDataSource = PurchasePlanDataSource(apiClient: apiClient);
    purchasePlanRepository =
        PurchasePlanRepositoryImpl(dataSource: purchasePlanDataSource);
    final apartmentOnboardingDatasource =
        ApartmentOnboardingDatasource(apiClient: apiClient);
    final apartmentOnboardingRepository = ApartmentOnboardingRepositoryimpl(
        datasource: apartmentOnboardingDatasource);
    apartmentOnboardingUsecase =
        ApartmentOnboardingUsecase(repository: apartmentOnboardingRepository);
    final adminDuesDataSource = AdminDuesDataSource(apiClient: apiClient);
    adminDuesRepository =
        AdminDuesRepositoryImpl(dataSource: adminDuesDataSource);
    final updateDueDataSource = UpdateDueDataSource(apiClient: apiClient);
    updateDueRepository =
        UpdateDueRepositoryImpl(dataSource: updateDueDataSource);
    final currentBalanceDataSource =
        CurrentBalanceDataSource(apiClient: apiClient);
    currentBalanceRepository =
        CurrentBalanceRepositoryImpl(dataSource: currentBalanceDataSource);
    final addDebitMaintainenceDataSource =
        AddDebitMaintainanceDataSource(apiClient: apiClient);
    final addDebitMaintainenceRepositoryImpl =
        AddDebitMaintainanceRepositoryImpl(
            dataSource: addDebitMaintainenceDataSource);
    addDebitMaintainenceUseCase =
        PostDebitHistoryUseCase(repository: addDebitMaintainenceRepositoryImpl);
    final addCreditMaintainanceDataSource =
        AddCreditMaintainanceDataSource(apiClient: apiClient);
    addCreditMaintainanceRepository = AddCreditMaintainanceRepositoryImpl(
        dataSource: addCreditMaintainanceDataSource);
    final transactiohistoryDataSource =
        TransactionDataSource(apiClient: apiClient);
    transactioHistoryRepository =
        TransactionRepositoryImpl(dataSource: transactiohistoryDataSource);
    final editCreditMaintainanceDataSource =
        EditCreditMaintainanceDataSource(apiClient: apiClient);
    final editCreditMaintainanceRepositoryImpl =
        EditCreditMaintainanceRepositoryImpl(
            dataSource: editCreditMaintainanceDataSource);
    editCreditMaintainanceUseCase = EditCreditMaintainanceUseCase(
        repository: editCreditMaintainanceRepositoryImpl);
    final editDebitMaintainanceDataSource =
        EditDebitMaintainanceDataSource(apiClient: apiClient);
    final editDebitMaintainanceRepositoryImpl =
        EditDebitMaintainanceRepositoryImpl(
            dataSource: editDebitMaintainanceDataSource);
    editDebitMaintainanceUseCase = EditDebitMaintainanceUseCase(
        repository: editDebitMaintainanceRepositoryImpl);
    final deleteCreditHistoryDataSource =
        DeleteCreditHistoryDataSource(apiClient: apiClient);
    final deleteCreditHistoryRepositoryImpl = DeleteCreditHistoryRepositoryImpl(
        dataSource: deleteCreditHistoryDataSource);
    deleteCreditHistoryUseCase = DeleteCreditHistoryUseCase(
        repository: deleteCreditHistoryRepositoryImpl);
    final deleteDebitHistoryDataSource =
        DeleteDebitHistoryDataSource(apiClient: apiClient);
    final deleteDebitHistoryRepositoryImpl = DeleteDebitHistoryRepositoryImpl(
        dataSource: deleteDebitHistoryDataSource);
    deleteDebitHistoryUseCase =
        DeleteDebitHistoryUseCase(repository: deleteDebitHistoryRepositoryImpl);
    final getNotificationDataSource =
        GetNotificationsDataSource(apiClient: apiClient);
    final getNotificationRepository =
        GetNotificationsRepositoryImpl(dataSource: getNotificationDataSource);
    getNotificationUsecase =
        GetNotificationsUseCase(repository: getNotificationRepository);
    final deleteNotificationDatasource =
        DeleteNotificationDatasource(apiClient: apiClient);
    final deleteNotificationRepository = DeleteNotificationRepositoryImpl(
        datasource: deleteNotificationDatasource);
    deleteNotificationUsecase =
        DeleteNotificationUseCase(repository: deleteNotificationRepository);
    final filtertransactionDatasource =
        FilterTransactionHistoryDatasource(apiClient: apiClient);
    final filterTransactionHistoryRepositoryImpl =
        FilterTransactionHistoryRepositoryImpl(
            dataSource: filtertransactionDatasource);
    filterTransactionHistoryUsecase = FilterTransactionHistoryUseCase(
        repository: filterTransactionHistoryRepositoryImpl);
    final getPdfDatasource = GetPdfDataSource(apiClient: apiClient);
    final getPdfDataRepositoryImpl =
        GetPdfRepositoryImpl(dataSource: getPdfDatasource);
    getPdfDataUsecase = GetPdfUseCase(repository: getPdfDataRepositoryImpl);
    final addConsumptionDataSource = AddConsumptionDataSource(apiClient);
    final addConsumptionRepositoryImpl =
        AddConsumptionRepositoryImpl(dataSource: addConsumptionDataSource);
    addConsumptionUseCase =
        AddConsumptionUseCase(repository: addConsumptionRepositoryImpl);
    final lastAddedConsumptionDatasource =
        LastAddedConsumptionDatasource(apiClient: apiClient);
    final lastAddedConsumptionRepositoryImpl =
        LastAddedConsumptionRepositoryImpl(
            dataSource: lastAddedConsumptionDatasource);
    lastAddedConsumptionUseCase = LastAddedConsumptionUseCase(
        repository: lastAddedConsumptionRepositoryImpl);
    final lastAddedGenerateBillDataSource =
        LastAddedGenerateBillDataSource(apiClient);
    final lastAddedGenerateBillRepositoryImpl =
        LastAddedGenerateBillRepositoryImpl(
            dataSource: lastAddedGenerateBillDataSource);
    lastAddedGenerateBillUseCase = LastAddedGenerateBillUseCase(
        repository: lastAddedGenerateBillRepositoryImpl);
    final postGenerateBillDataSource = PostGenerateBillDataSource(apiClient);
    final postGenerateBillRepositoryImpl =
        PostGenerateBillRepositoryImpl(dataSource: postGenerateBillDataSource);
    postGenerateBillUseCase =
        PostGenerateBillUseCase(repository: postGenerateBillRepositoryImpl);
    final myRequestsDataSource = MyRequestsDataSource(apiClient);
    final myRequestsRepositoryImpl =
        MyRequestsRepositoryImpl(dataSource: myRequestsDataSource);
    myRequestsUseCase = MyRequestsUseCase(repository: myRequestsRepositoryImpl);
    final remaindRequestDataSource =
        RemaindRequestDataSource(apiClient: apiClient);
    final remaindRequestRepositoryImpl =
        RemaindRequestRepositoryImpl(dataSource: remaindRequestDataSource);
    remaindRequestUseCase =
        RemaindRequestUseCase(repository: remaindRequestRepositoryImpl);
    final addPrepaidMeterConsumptionDataSource =
        AddPrepaidMeterConsumptionDataSource(apiClient);
    final addPrepaidMeterConsumptionRepositoryImpl =
        AddPrepaidMeterConsumptionRepositoryImpl(
            dataSource: addPrepaidMeterConsumptionDataSource);
    addPrepaidMeterConsumptionUseCase = AddPrepaidMeterConsumptionUseCase(
        repository: addPrepaidMeterConsumptionRepositoryImpl);
    final editPrepaidMeterDataSource = EditPrepaidMeterDatasource(apiClient);
    final editPrepaidMeterRepositoryImpl =
        EditPrepaidMeterRepositoryImpl(dataSource: editPrepaidMeterDataSource);
    editPrepaidMeterUseCase =
        EditPrepaidMeterUsecase(repository: editPrepaidMeterRepositoryImpl);
    final postMeterReadingsDataSource = PostMeterReadingsDataSource(apiClient);
    final postMeterReadingRepositoryImpl = PostMeterReadingsRepositoryImpl(
        dataSource: postMeterReadingsDataSource);
    postMeterReadingUseCase =
        PostMeterReadingsUseCase(repository: postMeterReadingRepositoryImpl);
    final getsingleMeterReadingsDataSource =
        GetSingleMeterReadingsDataSource(apiClient);
    final getsingleMeterReadingsRepositoryImpl =
        GetSingleMeterReadingsRepositoryImpl(getsingleMeterReadingsDataSource);
    getsingleMeterReadingsUseCase =
        GetSingleMeterReadingsUseCase(getsingleMeterReadingsRepositoryImpl);
    final getMeterReadingsDataSource = GetMeterReadingsDataSource(apiClient);
    final getMeterReadingsRepositoryImpl =
        GetMeterReadingsRepositoryImpl(dataSource: getMeterReadingsDataSource);
    getMeterReadingsUseCase =
        GetMeterReadingsUseCase(repository: getMeterReadingsRepositoryImpl);
    final editProfileDataSource = EditProfileDataSource(apiClient: apiClient);
    editProfileRepository =
        EditProfileRepositoryImpl(dataSource: editProfileDataSource);
    final searchyourCommunityDataSource =
        SearchYourCommunityDataSource(apiClient: apiClient);
    final searchYourCommunityRepository = SearchYourCommunityRepositoryImpl(
        dataSource: searchyourCommunityDataSource);
    searchYourCommunityUsecase =
        SearchYourCommunityUsecase(repository: searchYourCommunityRepository);
    final flatDataSource = FlatDataSource(apiClient);
    final flatRepository = FlatRepositoryImpl(flatDataSource);
    flatUseCase = FlatsUseCase(flatRepository);
    flatSendRequestUseCase = FlatSendRequestUseCase(flatRepository);
    final refreshBalanceDatasource = RefreshBalanceDataSource(apiClient);
    final refreshBalanceRepositoryImpl =
        RefreshBalanceRepositoryImpl(refreshBalanceDatasource);
    refreshBalanceUsecase = RefreshBalanceUseCase(refreshBalanceRepositoryImpl);
    final getSingleFlatConsumptionDatasource =
        GetSingleFlatConsumptionDataSource(apiClient);
    final getSingleFlatConsumptionRepositoryImpl =
        GetSingleFlatConsumptionRepositoryImpl(
            getSingleFlatConsumptionDatasource);
    getSingleFlatConsumptionUsecase = GetSingleFlatLastAddedConsumptionUseCase(
        getSingleFlatConsumptionRepositoryImpl);
    allFlatsUsecase = AllFlatsUsecase(
        repository: AllFlatsRepositoryImpl(
            datasource: AllFlatsDatasource(apiClient: ApiClient())));
    final addServiceProviderDatasource =
        AddServiceProviderDataSource(apiClient);
    final addServiceProviderRepositoryImpl =
        AddServiceProviderRepositoryImpl(addServiceProviderDatasource);
    addServiceProviderUsecase =
        AddServiceProviderUseCase(addServiceProviderRepositoryImpl);
    final getServiceProviderDatasource =
        GetServiceProvidersListDataSource(apiClient);
    final getServiceProviderRepositoryImpl =
        GetServiceProvidersListRepositoryImpl(getServiceProviderDatasource);
    getServiceProviderUsecase =
        GetServiceProvidersListUseCase(getServiceProviderRepositoryImpl);
    final addGuestsDataSource = AddGuestsDataSource(apiClient);
    final addGuestsRepositoryImpl =
        AddGuestsRepositoryImpl(addGuestsDataSource);
    addGuestsUseCase = AddGuestsUseCase(addGuestsRepositoryImpl);
    final handleGuestStatusUsecaseDataSource =
        HandleGuestStatusDataSource(apiClient);
    final handleGuestStatusRepositoryImpl =
        HandleGuestStatusRepositoryImpl(handleGuestStatusUsecaseDataSource);
    handleGuestStatusUsecase =
        HandleGuestStatusUsecase(handleGuestStatusRepositoryImpl);
    final updateGuestStatusDataSource = UpdateGuestStatusDataSource(apiClient);
    final updateGuestStatusRepositoryImpl =
        UpdateGuestStatusRepositoryImpl(updateGuestStatusDataSource);

    final editsplitterdetailsDatasource =
        EditSplitterDetailsDatasource(apiClient: apiClient);
    final editSplitterDetailsRepositoryImpl =
        EditSplitterDetailsRepositoryImpl(editsplitterdetailsDatasource);
    editSplitterDetailsUseCase =
        EditSplitterDetailsUseCase(editSplitterDetailsRepositoryImpl);
    final logoutUserDataSource = LogoutUserDataSource(apiClient);
    final logoutUserRepositoryImpl =
        LogoutUserRepositoryImpl(logoutUserDataSource);
    logoutUserUseCase = LogoutUserUseCase(logoutUserRepositoryImpl);
    updateGuestStatusUseCase =
        UpdateGuestStatusUseCase(updateGuestStatusRepositoryImpl);
    configuredVisitorsUsecase = ConfiguredVisitorsUsecase(
        repository: ConfiguredVisitorsRepositoryimpl(
            datasource: ConfiguredVisitorsDatasource(apiClient: ApiClient())));
    complianceUsecase = ComplianceUsecase(
        repository: ComplianceRepositoryimpl(
            datasource: ComplianceDatasource(apiClient: ApiClient())));

    final createPaymentOrderDataSource =
        CreatePaymentOrderDataSource(apiClient: apiClient);
    final createPaymentOrderRepositoryImpl = CreatePaymentOrderRepositoryImpl(
        dataSource: createPaymentOrderDataSource);
    createPaymentOrderUseCase =
        CreatePaymentOrderUseCase(createPaymentOrderRepositoryImpl);

    final verifyPaymentOrderDataSource =
        VerifyPaymentOrderDataSource(apiClient);
    final verifyPaymentOrderRepositoryImpl =
        VerifyPaymentOrderRepositoryImpl(verifyPaymentOrderDataSource);
    verifyPaymentOrderUseCase =
        VerifyPaymentOrderUseCase(verifyPaymentOrderRepositoryImpl);
  }
}
