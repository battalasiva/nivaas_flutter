import 'package:nivaas/data/models/auth/current_customer_model.dart';
import 'package:nivaas/data/provider/network/api/auth/user_data_source.dart';
import 'package:nivaas/domain/repositories/auth/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({required this.userDataSource});

  @override
  Future<CurrentCustomerModel> getUserDetails() async {
    return await userDataSource.getUserDetails();
  }
}
