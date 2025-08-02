import 'package:nivaas/data/models/gate-management/ApproveDeclineGuestModel.dart';

abstract class HandleGuestStatusRepository {
  Future<ApproveDeclineGuestModel> getGuestStatus({
    required int apartmentId,
    required int flatId,
    required String status,
  });
}
