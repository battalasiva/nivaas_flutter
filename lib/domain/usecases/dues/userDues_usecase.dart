import 'package:nivaas/data/models/dues/userDue_model.dart';
import 'package:nivaas/domain/repositories/dues/userDue_repository.dart';

class FetchUserDuesUseCase {
  final UserDuesRepository repository;

  FetchUserDuesUseCase({required this.repository});

  Future<List<UserDuesModal>> call({
    required int apartmentId,
    required int flatId,
    required int year,
    required int month,
  }) async {
    return await repository.getUserDues(
      apartmentId: apartmentId,
      flatId: flatId,
      year: year,
      month: month,
    );
  }
}
