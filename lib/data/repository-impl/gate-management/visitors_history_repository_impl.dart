import 'package:nivaas/data/models/gateManagement/visitors_history_model.dart';
import 'package:nivaas/data/provider/network/api/gate-management/visitors_history_datasource.dart';
import 'package:nivaas/domain/repositories/gate-management/visitors_history_repository.dart';

class VisitorsHistoryRepositoryImpl implements VisitorsHistoryRepository {
  final VisitorsHistoryDatasource datasource;

  VisitorsHistoryRepositoryImpl({required this.datasource});
  @override
  Future<List<VisitorsHistoryModel>> fetchVisitorsHistory(int apartmentId, int flatId, int pageNo, int pageSize) {
    return datasource.fetchVisitorsHistory(apartmentId, flatId, pageNo, pageSize);
  }
  
}