import 'package:nivaas/data/models/complaints/admins_list_model.dart';

abstract class AdminsRepository {
  Future<List<AdminsListModal>> getAdmins({required int apartmentId});
}
