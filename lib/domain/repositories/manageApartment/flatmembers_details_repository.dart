import 'package:nivaas/data/models/manageApartment/flatmembers_details_model.dart';

abstract class FlatmembersDetailsRepository {
  Future<void> updateFlatMemberDetails(FlatmembersDetailsModel details, int apartmentId, int flatId);
  Future <bool> removemember(int relatedUserId, int onboardingRequestId);
}