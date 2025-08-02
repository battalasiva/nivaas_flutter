class ApiUrls {
  static const baseUrl = "https://nivaas.solutions/api/";      
  // static const baseUrl = "https://nivaas.homes/api/";
  static const login = "access-mgmt/nivaas/auth/login";
  static const signin = "access-mgmt/nivaas/auth/jtuserotp/trigger/sign-in";
  static const signup = "access-mgmt/nivaas/auth/jtuserotp/trigger/sign-up";
  static const refreshToken = "access-mgmt/nivaas/auth/refreshToken";
  static const myrequests = "customer/onboarding/my-requests";
  static const remaindRequest = "customer/onboarding/remind";
  // static const currentCustomer = "customer/onboarding/requests";
  static const currentCustomer = "customer/current-apartment/get/flat";
  static const apartmentList = "customer/user/all/entities";
  static String setCurrentFlat(int apartmentId, int flatId) {
    return "customer/current-apartment/$apartmentId/flat/$flatId/set";
  }

  static String setCurrentApartment(int userId, int apartmentId){
    return "customer/current-apartment/set?userId=$userId&apartmentId=$apartmentId";
  }

  // Search your Community
  // static const city = "core/nivaascity/search?pageNo=0&pageSize=10";
  static String city(int pageNo, int pageSize){
    return "core/nivaascity/search?pageNo=$pageNo&pageSize=$pageSize";
  }
  static String apartment(int cityId, int pageNo, int pageSize) {
    return "customer/jtapartment/city/$cityId?pageNo=$pageNo&pageSize=$pageSize";
  }

  static String flatList(int apartmentId, int pageNo, int pageSize) {
    return "customer/jtflat/apartment/$apartmentId/flats?pageNo=$pageNo&pageSize=$pageSize";
  }

  static const tenantOnboarding = "customer/onboarding/flat/request";
  static const ownerOnboarding = "customer/onboarding/flat_owner/request";

  static const editprofile = "access-mgmt/user/userDetails";
  static const logoutUser = "access-mgmt/user/logout";


  //noticeboard
  static const postNotice = "customer/noticeboard/save";
  static const getNotices = "customer/noticeboard/list";
  static const getnotifications = 'customer/jtnotification/user/list';
  static const clearallNotifications = 'customer/jtnotification/clear-all';

  //complaints
  static const mycomplaints = "customer/complaints/apartment";
  static const RaiseComplaint = "customer/complaints/raise";
  static const getOwnersList =
      "customer/jtflat";
  
  // manage flats
  static String postFlatDetails(int flatId) {
    return "customer/jtflat/manage/flat/$flatId";
  }
  static String getFlatDetails(int flatId) {
    return "customer/jtflat/details/$flatId";
  }
  static String getFlatmembers(int apartmentId, int flatId){
    return "customer/onboarding/list/apartment/$apartmentId/flat/$flatId";
  }
  static String flatForRent(int flatId, bool isRent){
    return "customer/jtflat/manage/rent/$flatId?availableForRent=$isRent";
  }
  static String flatForSale(int flatId, bool isSale){
    return "customer/jtflat/manage/sale/$flatId?availableForSale=$isSale";
  }

  static const uploadProfilePic = "customer/upload";

  //coins&subscription
  static const purchasePlan = "customer/jtapartment/subscription/renew";
  static const purchasePlanPayment = "customer/jtapartment/subscription/renewWithPayment";
  static const getCoinsBalance = "customer/apartment/coins/get";
  static const getWalletTransactions = "customer/apartment/coins/get/history";
  static String createOrderUrl(int apartmentId, String months,String coinsToUse) {
    return "customer/payment/create-order/$apartmentId?months=$months&coinsToUse=$coinsToUse";
  }
  static String verifyPaymentOrderUrl(String paymentId, String orderId,String signature) {
    return "customer/payment/verify?paymentId=$paymentId&orderId=$orderId&signature=$signature";
  }
  //apartment/Maintainance
  static const getAdminsList = "customer/apartment/users/admins";
  static const getCurrentBalance = "customer/apartment/current-balance";
  static const addDebitMaintainance = "customer/apartment/debit-history";
  static const addCreditMaintainance = "customer/apartment/credit-history/save";
  static const editDebitMaintainance = "customer/apartment/debit-history";
  static const deleteDebitMaintainance =
      "customer/apartment/debit-history/apartment";
  static const editCreditMaintainence = "customer/apartment/credit-history";
  static const deleteCreditMaintainence =
      "customer/apartment/credit-history/apartment";
  static const refreshBalance = "customer/apartment/current-balance";

  //Monthly Maintainance
  static const getLastAddedBill = "customer/jtmaintanance/apartment";
  static const generateBill = "customer/jtmaintanance/save";
  static const transactionHistory = "customer/transactions/recent";
  static const pdf = "customer/report/apartment";
  // static const updateComplaintStatus = "customer/complaints/update-status/${id}?status=${status}&&assignedTo=${assignedTo}";
  static const apartmentOnboarding = "customer/jtapartment/save";

  //Manage Apartment
  static String getFlats(int apartmentId) {
    return "customer/onboarding/flat/list/$apartmentId";
  }
  static String getFlatsWithoutDetails(int apartmentId, int pageNo, int pageSize){
    return "customer/jtflat/without-owners/flat/list?apartmentId=$apartmentId&pageNo=$pageNo&pageSize=$pageSize";
  }

  static const onboardFlatsWithDetails = "customer/jtflat/bulk/onboard";
  static const onboardFlatsWithoutDetails =
      "customer/jtflat/without-owners/bulk/onboard";
  static String addOwnerDetails (int apartmentId){
    return "customer/jtflat/update/owner-details?apartmentId=$apartmentId";
  }
  static const ownerOnboardRequest = "customer/onboarding/approve/falt_owner";
  static const tenantOnboardRequest = "customer/onboarding/approve/flat/related-user";
  static String rejectOnboardRequest(int onboardingRequestId, int userId) {
    return "customer/onboarding/reject?onboardingRequestId=$onboardingRequestId&userId=$userId";
  }

  static String editmemberDetails(int apartmentId, int flatId){
    return "customer/jtflat/apartment/$apartmentId/flat/$flatId/update";
  }
  static String removemember(int relatedUserId, int onboardingRequestId){
    return "customer/jtflat/tenant/remove?relatedUserId=$relatedUserId&onboardingRequestId=$onboardingRequestId";
  }
  //my_Complaints
  static const adminList = "customer/apartment/users/admins";
  static const complaintsList = "customer/complaints/apartment";
  static const reassignComplaint = "customer/complaints/update-status";

  //society-dues
  static const getAdminDues = "customer/society/dues/list";
  static const getUserDues = "customer/society/dues/apartment";
  static const updateDueStatus = "customer/society/update";

  //prepaid-meters
  static const addPrepaidMeters = "customer/prepaidmeter/save";
  static const getPrepaidMetersList = "customer/prepaidmeter/list";
  static const updateConsumptionUnits =
      "customer/prepaid-usage/flat/update-consumed";
  // static const lastAddedGenerateBill = "customer/jtmaintanance/2";
  static const lastAddedConsumptionUnits = "customer/prepaid-usage/apartment";
  static const updateReadings = "customer/prepaid-reading/flat/update-reading";
  static const getMeterReadings = "customer/prepaid-reading/apartment";
  static const updateMeterDetails = "customer/prepaidmeter/update";

  // managementMembers
  static const addCoAdmin = "customer/jtapartment/add/co-admin";
  static String ownersList(int apartmentID){
    return "customer/jtflat/$apartmentID/owner/list";
  }
  static const addSecurity = "customer/apartment-helper/add-helper";
  static String securitiesList(int apartmentID){
    return "customer/apartment-helper/list/apartment/$apartmentID";
  }
  //Services
  static const addServiceProvider = "customer/apartment-partner/onboard";
  static const getserviceProvidersList = "customer/apartment-partner/partners";


  // Gate management
  static String guestInviteEntries(int apartmentId, int pageNo, int pageSize){
    return "customer/visitor-request/requests/apartment/$apartmentId?status=RESIDENT_REQUESTED&page=$pageNo&size=$pageSize";
  }
  static String otpValidation(int requestId, String otp){
    return "customer/visitor-request/validate/otp?requestId=$requestId&otp=$otp";
  }
  static const addGuest = "customer/visitor-request/pre-approve/request";
  static const guestStatus = "customer/visitor-request/requests/apartment";
  static const updateGuestStatus = "customer/visitor-request/approve";
  static String visitorsRecentHistory(int apartmentId, int flatId, int pageNo, int pageSize){
    return "customer/visitor-request/visitor-history/apartment/$apartmentId/flat/$flatId?page=$pageNo&size=$pageSize";
  }
  static const checkinRequest = "customer/visitor-request/raise-request";
  static String checkinHistory(int apartmentId, String status, int pageNo, int pageSize){
    return "customer/visitor-request/requests/apartment/$apartmentId?status=$status&page=$pageNo&size=$pageSize";
  }
  static String configuredVisitors(int apartmentId,int flatId, int pageNo, int pageSize){
    return "customer/visitor-request/requests/apartment/$apartmentId/flat/$flatId?status=RESIDENT_REQUESTED&page=$pageNo&size=$pageSize";
  }

  // Expense Splitter
  static String getExpenseSplitters (int apartmentId){
    return "customer/expense-split/all/$apartmentId";
  }
  static const addExpenseSplitter = "customer/expense-split";
  static String getExpenseSplitterDetails(int splitterId){
    return "customer/expense-split/$splitterId";
  }
  static String enableExpenseSplitterDetails(int splitterId, bool isEnabled){
    return "customer/expense-split/$splitterId/status?enabled=$isEnabled";
  }
  static const editExpenseSplitter = "customer/expense-split";
  // Compliance
  static String compliances(int apartmentId){
    return "customer/compliance/$apartmentId";
  }
} 