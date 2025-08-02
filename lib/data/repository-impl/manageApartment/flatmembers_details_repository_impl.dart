import 'package:nivaas/data/models/manageApartment/flatmembers_details_model.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/flatmembers_details_datasource.dart';
import 'package:nivaas/domain/repositories/manageApartment/flatmembers_details_repository.dart';

class FlatmembersDetailsRepositoryImpl implements FlatmembersDetailsRepository {
  final FlatmembersDetailsDatasource datasource;

  FlatmembersDetailsRepositoryImpl({required this.datasource});
  
  @override
  Future<bool> removemember(int relatedUserId, int onboardingRequestId) {
    return datasource.removeMember(relatedUserId, onboardingRequestId);
  }
  
  @override
  Future<void> updateFlatMemberDetails(FlatmembersDetailsModel details, int apartmentId, int flatId) {
    return datasource.updateFlatMemberDetails(details, apartmentId, flatId);
  }
  
}