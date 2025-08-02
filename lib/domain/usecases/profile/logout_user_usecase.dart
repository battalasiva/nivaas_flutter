
import 'package:nivaas/domain/repositories/profile/logout_user_repository.dart';

class LogoutUserUseCase {
  final LogoutUserRepository repository;

  LogoutUserUseCase(this.repository);

  Future<Map<String, dynamic>> logoutUser(String userId) {
    return repository.logoutUser(userId);
  }
}
