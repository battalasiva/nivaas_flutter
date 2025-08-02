import 'package:nivaas/data/models/gate-management/ApproveDeclineGuestModel.dart';
import 'package:nivaas/domain/repositories/gate-management/handle_guest_status_repository.dart';

class HandleGuestStatusUsecase {
  final HandleGuestStatusRepository repository;

  HandleGuestStatusUsecase(this.repository);

  Future<ApproveDeclineGuestModel> call({
    required int apartmentId,
    required int flatId,
    required String status,
  }) async {
    return await repository.getGuestStatus(
      apartmentId: apartmentId,
      flatId: flatId,
      status: status,
    );
  }
}
