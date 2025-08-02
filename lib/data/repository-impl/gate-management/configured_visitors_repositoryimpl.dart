import 'package:nivaas/data/models/gateManagement/configured_visitor_invites_model.dart';
import 'package:nivaas/data/models/security/guest_invite_entries_model.dart';
import 'package:nivaas/data/provider/network/api/gate-management/configured_visitors_datasource.dart';
import 'package:nivaas/domain/repositories/gate-management/configured_visitors_repository.dart';

class ConfiguredVisitorsRepositoryimpl implements ConfiguredVisitorsRepository {
  final ConfiguredVisitorsDatasource datasource;

  ConfiguredVisitorsRepositoryimpl({required this.datasource});
  @override
  Future<ConfiguredVisitorInvitesModel> fetchConfiguredVisitorsHistory(int apartmentId, int flatId, int pageNo, int pageSize) {
    return datasource.fetchConfiguredVisitorsHistory(apartmentId, flatId, pageNo, pageSize);
  }
  
}