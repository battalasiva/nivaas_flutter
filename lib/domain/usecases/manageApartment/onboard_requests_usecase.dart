import 'package:nivaas/data/models/manageApartment/onboard_requests_model.dart';
import 'package:nivaas/data/repository-impl/manageApartment/onboard_requests_repository_impl.dart';

class OnboardRequestsUsecase {
  final OnboardRequestsRepositoryImpl repository;

  OnboardRequestsUsecase({required this.repository});

  Future<bool> executeOwnerOnboardRequest(OwnerOnboardRequestModel details){
    return repository.ownerOnboardRequest(details);
  }
  Future<bool> executeTenantOnboardRequest(TenantOnboardRequestModel details){
    return repository.tenantOnboardRequest(details);
  }
  Future<bool> executeRejectOnboardRequest(int id, int userId){
    return repository.rejectOnboardRequest(id, userId);
  }
}