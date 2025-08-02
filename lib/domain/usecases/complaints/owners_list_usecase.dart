import 'package:nivaas/data/models/complaints/owners_list_model.dart';
import 'package:nivaas/domain/repositories/complaints/owners_list_repository.dart';

class GetOwnersListUseCase {
  final OwnersRepository repository;

  GetOwnersListUseCase({required this.repository});

  Future<List<Data>> call(int apartmentId, int pageNo, int pageSize) async {
    return await repository.getOwnersList(apartmentId, pageNo, pageSize);
  }
}
