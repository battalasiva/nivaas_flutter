import 'package:nivaas/data/models/gate-management/ApproveDeclineGuestModel.dart';
import 'package:nivaas/data/provider/network/api/gate-management/handle_guest_status_datasource.dart';
import 'package:nivaas/domain/repositories/gate-management/handle_guest_status_repository.dart';

class HandleGuestStatusRepositoryImpl implements HandleGuestStatusRepository {
  final HandleGuestStatusDataSource dataSource;

  HandleGuestStatusRepositoryImpl(this.dataSource);

  @override
  Future<ApproveDeclineGuestModel> getGuestStatus({
    required int apartmentId,
    required int flatId,
    required String status,
  }) {
    return dataSource.getGuestStatus(
      apartmentId: apartmentId,
      flatId: flatId,
      status: status,
    );
  }
}
