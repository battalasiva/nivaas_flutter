import 'package:nivaas/data/models/dues/userDue_model.dart';

abstract class UserDuesRepository {
  Future<List<UserDuesModal>> getUserDues({
    required int apartmentId,
    required int flatId,
    required int year,
    required int month,
  });
}
