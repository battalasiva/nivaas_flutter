import 'package:nivaas/data/provider/network/api/security/gate_activities_datasource.dart';
import 'package:nivaas/domain/repositories/security/gate_activities_repository.dart';

import '../../models/security/guest_invite_entries_model.dart';

class GateActivitiesRepositoryimpl implements GateActivitiesRepository{
  final GateActivitiesDatasource datasource;

  GateActivitiesRepositoryimpl({required this.datasource});
  @override
  Future<GuestInviteEntriesModel> fetchCheckinHistory(int apartmentId, String status, int pageNo, int pageSize) {
    return datasource.fetchCheckinHistory(apartmentId, status, pageNo, pageSize);
  }
  
}