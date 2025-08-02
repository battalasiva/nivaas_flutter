import 'package:nivaas/data/repository-impl/security/gate_activities_repositoryimpl.dart';

import '../../../data/models/security/guest_invite_entries_model.dart';

class GateActivitiesUsecase {
 final GateActivitiesRepositoryimpl repository;

  GateActivitiesUsecase({required this.repository});
  Future<GuestInviteEntriesModel> call(int apartmentId, String status, int pageNo, int pageSize) {
    return repository.fetchCheckinHistory(apartmentId, status, pageNo, pageSize);
  } 
}