import 'package:nivaas/data/models/gateManagement/configured_visitor_invites_model.dart';
import 'package:nivaas/data/repository-impl/gate-management/configured_visitors_repositoryimpl.dart';

import '../../../data/models/security/guest_invite_entries_model.dart';

class ConfiguredVisitorsUsecase {
  final ConfiguredVisitorsRepositoryimpl repository;

  ConfiguredVisitorsUsecase({required this.repository});

  Future<ConfiguredVisitorInvitesModel> call(int apartmentId,int flatId, int pageNo, int pageSize){
    return repository.fetchConfiguredVisitorsHistory(apartmentId, flatId, pageNo, pageSize);
  }
}