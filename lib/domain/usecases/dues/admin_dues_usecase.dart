import 'package:nivaas/data/models/dues/admin_due_model.dart';
import 'package:nivaas/domain/repositories/dues/admin_due_repository.dart';

class AdminDuesUseCase {
  final AdminDuesRepository repository;

  AdminDuesUseCase({required this.repository});

  Future<List<AdminDuesModal>> execute(int apartmentId, int year, int month) {
    return repository.fetchAdminDues(apartmentId, year, month);
  }
}
