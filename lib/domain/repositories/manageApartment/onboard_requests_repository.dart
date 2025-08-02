import 'package:nivaas/data/models/manageApartment/onboard_requests_model.dart';

abstract class OnboardRequestsRepository {
  Future<bool>ownerOnboardRequest(OwnerOnboardRequestModel details);
  Future<bool>tenantOnboardRequest(TenantOnboardRequestModel details);
  Future<bool>rejectOnboardRequest(int id, int userId);
}