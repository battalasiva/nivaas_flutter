import '../../../data/models/gateManagement/visitors_history_model.dart';

abstract class VisitorsHistoryRepository {
  Future<List<VisitorsHistoryModel>> fetchVisitorsHistory(int apartmentId, int flatId, int pageNo, int pageSize);
}