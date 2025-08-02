import 'package:nivaas/data/models/complaints/owners_list_model.dart';
import 'package:nivaas/data/provider/network/api/complaints/owners_list_datasource.dart';
import 'package:nivaas/domain/repositories/complaints/owners_list_repository.dart';

class OwnersRepositoryImpl implements OwnersRepository {
  final OwnersDataSource remoteDataSource;

  OwnersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Data>> getOwnersList(
      int apartmentId, int pageNo, int pageSize) async {
    return await remoteDataSource.fetchOwners(apartmentId, pageNo, pageSize);
  }
}
