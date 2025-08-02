import 'package:nivaas/data/models/complaints/admins_list_model.dart';
import 'package:nivaas/data/provider/network/api/complaints/admins_list_dataSource.dart';
import 'package:nivaas/domain/repositories/complaints/admins_list_repository.dart';

class AdminsRepositoryImpl implements AdminsRepository {
  final AdminsDataSource adminsDataSource;

  AdminsRepositoryImpl({required this.adminsDataSource});

  @override
  Future<List<AdminsListModal>> getAdmins({required int apartmentId}) async {
    return await adminsDataSource.fetchAdmins(apartmentId);
  }
}
