import 'package:nivaas/data/models/manageApartment/flatmembers_details_model.dart';
import 'package:nivaas/data/repository-impl/manageApartment/flatmembers_details_repository_impl.dart';

class FlatmembersDetailsUsecase {
  final FlatmembersDetailsRepositoryImpl repository;

  FlatmembersDetailsUsecase({required this.repository});

  Future<void> executeUpdateFlatmemberDetails(FlatmembersDetailsModel details, int apartmentId, int flatId){
    return repository.updateFlatMemberDetails(details, apartmentId, flatId);
  }

  Future<bool> executeRemoveMember(int relatedUserId, int onboardingRequestId){
    return repository.removemember(relatedUserId, onboardingRequestId);
  }
}