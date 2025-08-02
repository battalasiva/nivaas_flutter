
import 'package:nivaas/data/provider/network/api/apartmentOnboarding/remaind_request_datasource.dart';
import 'package:nivaas/domain/repositories/apartmentOnboarding/remaind_request_repository.dart';

class RemaindRequestRepositoryImpl implements RemaindRequestRepository {
  final RemaindRequestDataSource dataSource;

  RemaindRequestRepositoryImpl({required this.dataSource});

  @override
  Future<String> remindRequest(String apartmentId, String flatId, String onboardingId) {
    return dataSource.remindRequest(apartmentId, flatId, onboardingId);
  }
}
