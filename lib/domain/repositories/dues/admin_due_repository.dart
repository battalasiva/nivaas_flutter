import 'package:nivaas/data/models/dues/admin_due_model.dart';

abstract class AdminDuesRepository {
  Future<List<AdminDuesModal>> fetchAdminDues(
      int apartmentId, int year, int month);
}
