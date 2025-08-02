import 'package:nivaas/data/models/auth/current_customer_model.dart';
import 'package:nivaas/data/repository-impl/auth/user_repository_impl.dart';

class UserUsecase {
  final UserRepositoryImpl repository;

  UserUsecase({required this.repository});

  Future<CurrentCustomerModel> call() async {
    return await repository.getUserDetails();
  }
}
