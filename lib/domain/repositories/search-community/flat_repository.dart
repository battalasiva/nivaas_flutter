import 'package:nivaas/data/models/search-community/flat_list_model.dart';

abstract class FlatRepository {
  Future<FlatListModel> getFlats(String memberType, int apartmentId, int pageNo, int pageSize);
  Future<void> sendRequest(String memberType, int flatId);
}
