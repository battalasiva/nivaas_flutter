import 'package:nivaas/data/models/search-community/flat_list_model.dart';
import 'package:nivaas/domain/repositories/search-community/flat_repository.dart';

import '../../provider/network/api/search-community/flat_data_source.dart';

class FlatRepositoryImpl extends FlatRepository {
  final FlatDataSource flatDataSource;

  FlatRepositoryImpl(this.flatDataSource);

  @override
  Future<FlatListModel> getFlats(String memberType, int apartmentId,int pageNo, int pageSize) {
    return flatDataSource.fetchFlats(memberType, apartmentId, pageNo, pageSize);
  }

  @override
  Future<void> sendRequest(String memberType, int flatId) {
    return flatDataSource.sendRequest(memberType, flatId);
  }
}
