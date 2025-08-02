import 'package:nivaas/data/models/dues/admin_due_model.dart';
import 'package:nivaas/data/provider/network/api/dues/admin_due_data_source.dart';
import 'package:nivaas/domain/repositories/dues/admin_due_repository.dart';

class AdminDuesRepositoryImpl implements AdminDuesRepository {
  final AdminDuesDataSource dataSource;

  AdminDuesRepositoryImpl({required this.dataSource});

  @override
  Future<List<AdminDuesModal>> fetchAdminDues(
      int apartmentId, int year, int month) {
    return dataSource.fetchAdminDues(apartmentId, year, month);
  }
}
