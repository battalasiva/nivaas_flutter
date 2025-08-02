import 'package:nivaas/data/models/dues/userDue_model.dart';
import 'package:nivaas/data/provider/network/api/dues/userDue_data_source.dart';
import 'package:nivaas/domain/repositories/dues/userDue_repository.dart';

class UserDuesRepositoryImpl implements UserDuesRepository {
  final UserDuesDataSource dataSource;

  UserDuesRepositoryImpl({required this.dataSource});

  @override
  Future<List<UserDuesModal>> getUserDues({
    required int apartmentId,
    required int flatId,
    required int year,
    required int month,
  }) async {
    return await dataSource.fetchUserDues(
      apartmentId: apartmentId,
      flatId: flatId,
      year: year,
      month: month,
    );
  }
}
