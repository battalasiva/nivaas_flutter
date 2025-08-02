import 'package:nivaas/domain/repositories/gate-management/update_guest_status_repository.dart';

class UpdateGuestStatusUseCase {
  final UpdateGuestStatusRepository repository;

  UpdateGuestStatusUseCase(this.repository);

  Future<String> call(int id, String status) async {
    return await repository.updateGuestStatus(id, status);
  }
}
