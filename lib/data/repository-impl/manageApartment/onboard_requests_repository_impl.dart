import 'package:nivaas/data/models/manageApartment/onboard_requests_model.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/onboard_requests_datasource.dart';
import 'package:nivaas/domain/repositories/manageApartment/onboard_requests_repository.dart';

class OnboardRequestsRepositoryImpl implements OnboardRequestsRepository {
  final OnboardRequestsDatasource datasource;

  OnboardRequestsRepositoryImpl({required this.datasource});
  @override
  Future<bool> ownerOnboardRequest(OwnerOnboardRequestModel details) {
    return datasource.ownerOnboardRequest(details);
  }

  @override
  Future<bool> tenantOnboardRequest(TenantOnboardRequestModel details) {
    return datasource.tenantOnboardRequest(details);
  }
  
  @override
  Future<bool> rejectOnboardRequest(int id, int userId) {
    return datasource.rejectOnboardRequest(id, userId);
  }
  
}