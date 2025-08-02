import 'package:nivaas/data/models/complaints/owners_list_model.dart';

abstract class OwnersRepository {
  Future<List<Data>> getOwnersList(int apartmentId, int pageNo, int pageSize);
}
