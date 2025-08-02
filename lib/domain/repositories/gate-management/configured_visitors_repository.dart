import 'package:nivaas/data/models/gateManagement/configured_visitor_invites_model.dart';

abstract class ConfiguredVisitorsRepository {
  Future<ConfiguredVisitorInvitesModel> fetchConfiguredVisitorsHistory(int apartmentId,int flatId, int pageNo, int pageSize);
}