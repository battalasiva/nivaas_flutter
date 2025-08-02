import 'package:nivaas/data/provider/network/api/profile/logout_user_datasource.dart';
import 'package:nivaas/domain/repositories/profile/logout_user_repository.dart';


class LogoutUserRepositoryImpl implements LogoutUserRepository {
  final LogoutUserDataSource dataSource;

  LogoutUserRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> logoutUser(String userId) {
    return dataSource.logoutUser(userId);
  }
}
