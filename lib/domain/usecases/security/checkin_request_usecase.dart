import 'package:nivaas/data/repository-impl/security/checkin_request_repositoryimpl.dart';

class CheckinRequestUsecase {
  final CheckinRequestRepositoryimpl repository;

  CheckinRequestUsecase({required this.repository});

  Future<bool> call(int apartmentId, int flatId, String type, String name, String mobileNumber){
    return repository.sendCheckinRequest(apartmentId, flatId, type, name, mobileNumber);
  }
}