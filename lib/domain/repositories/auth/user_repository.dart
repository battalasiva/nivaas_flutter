import 'package:nivaas/data/models/auth/current_customer_model.dart';

abstract class UserRepository {
  Future<CurrentCustomerModel> getUserDetails();
}
