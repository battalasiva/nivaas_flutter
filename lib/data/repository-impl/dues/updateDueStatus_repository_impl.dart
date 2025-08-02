import 'package:nivaas/data/provider/network/api/dues/updateDueStatus_data_source.dart';
import 'package:nivaas/domain/repositories/dues/updatedueStatus_repository.dart';

class UpdateDueRepositoryImpl implements UpdateDueRepository {
  final UpdateDueDataSource dataSource;

  UpdateDueRepositoryImpl({required this.dataSource});

  @override
  Future<String> updateDue({
    required String apartmentId,
    required String status,
    required String societyDueIds,
  }) {
    return dataSource.updateDue(
      apartmentId: apartmentId,
      status: status,
      societyDueIds: societyDueIds,
    );
  }
}
