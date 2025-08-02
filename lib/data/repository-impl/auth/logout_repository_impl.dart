import 'package:nivaas/data/provider/network/api/auth/logout_data_source.dart';
import 'package:nivaas/domain/repositories/auth/logout_repository.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutDataSource dataSource;

  LogoutRepositoryImpl({required this.dataSource});

  @override
  Future<void> logout() {
    return dataSource.logOut();
  }
}
