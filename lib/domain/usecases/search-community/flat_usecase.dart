import 'package:nivaas/data/models/search-community/flat_list_model.dart';
import 'package:nivaas/data/repository-impl/search-community/flat_repository_impl.dart';

class FlatsUseCase {
  final FlatRepositoryImpl flatRepository;

  FlatsUseCase(this.flatRepository);

  Future<FlatListModel> execute(String memberType, int apartmentId, int pageNo, int pageSize) {
    return flatRepository.getFlats(memberType, apartmentId, pageNo, pageSize);
  }
}

class FlatSendRequestUseCase {
  final FlatRepositoryImpl flatRepository;

  FlatSendRequestUseCase(this.flatRepository);

  Future<void> execute(String memberType, int flatId) {
    return flatRepository.sendRequest(memberType, flatId);
  }
}
