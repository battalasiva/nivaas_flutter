import 'package:nivaas/data/provider/network/api/gate-management/update_guest_status_datasource.dart';
import 'package:nivaas/domain/repositories/gate-management/update_guest_status_repository.dart';

class UpdateGuestStatusRepositoryImpl implements UpdateGuestStatusRepository {
  final UpdateGuestStatusDataSource dataSource;

  UpdateGuestStatusRepositoryImpl(this.dataSource);

  @override
  Future<String> updateGuestStatus(int id, String status) async {
    return await dataSource.updateGuestStatus(id, status);
  }
}
