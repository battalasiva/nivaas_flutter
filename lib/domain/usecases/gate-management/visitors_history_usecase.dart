import 'package:nivaas/data/repository-impl/gate-management/visitors_history_repository_impl.dart';

import '../../../data/models/gateManagement/visitors_history_model.dart';

class VisitorsHistoryUsecase {
  final VisitorsHistoryRepositoryImpl repository;

  VisitorsHistoryUsecase({required this.repository});

  Future<List<VisitorsHistoryModel>> execute(int apartmentId, int flatId, int pageNo, int pageSize) {
    return repository.fetchVisitorsHistory(apartmentId, flatId, pageNo, pageSize);
  }

}