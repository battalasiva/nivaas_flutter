import 'package:nivaas/data/models/complaints/admins_list_model.dart';
import 'package:nivaas/domain/repositories/complaints/admins_list_repository.dart';

class FetchAdminsUseCase {
  final AdminsRepository repository;

  FetchAdminsUseCase({required this.repository});

  Future<List<AdminsListModal>> call({required int apartmentId}) async {
    return await repository.getAdmins(apartmentId: apartmentId);
  }
}
