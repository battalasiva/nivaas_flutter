import 'package:nivaas/data/provider/network/api/security/checkin_request_datasource.dart';
import 'package:nivaas/domain/repositories/security/checkin_request_repository.dart';

class CheckinRequestRepositoryimpl implements CheckinRequestRepository {
  final CheckinRequestDatasource datasource;

  CheckinRequestRepositoryimpl({required this.datasource});
  @override
  Future<bool> sendCheckinRequest(int apartmentId, int flatId, String type, String name, String mobileNumber) {
    return datasource.sendCheckinRequest(apartmentId, flatId, type, name, mobileNumber);
  }
  
}