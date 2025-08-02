import 'package:nivaas/data/repository-impl/auth/logout_repository_impl.dart';

class LogoutUsecase {
  final LogoutRepositoryImpl repository;

  LogoutUsecase({required this.repository});

  Future<void> call() {
    return repository.logout();
  }
}
