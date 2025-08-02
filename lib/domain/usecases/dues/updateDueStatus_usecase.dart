import 'package:nivaas/domain/repositories/dues/updatedueStatus_repository.dart';

class UpdateDueUseCase {
  final UpdateDueRepository repository;

  UpdateDueUseCase(this.repository);

  Future<String> call({
    required String apartmentId,
    required String status,
    required String societyDueIds,
  }) {
    return repository.updateDue(
      apartmentId: apartmentId,
      status: status,
      societyDueIds: societyDueIds,
    );
  }
}
