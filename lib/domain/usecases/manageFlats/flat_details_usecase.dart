import 'package:nivaas/data/models/manageFlats/flat_details_model.dart';
import 'package:nivaas/data/repository-impl/manageFlats/flat_details_repository_impl.dart';

class FlatDetailsUsecase {
  final FlatDetailsRepositoryImpl repository;

  FlatDetailsUsecase({required this.repository});

  Future<FlatDetailsModel> executeUpdateflatDetails(int flatId, FlatDetailsModel flatDetails){
    return repository.updateFlatDetails(flatId, flatDetails);
  }
  Future<FlatDetailsModel> executeGetflatDetails(int flatId) {
    final response =  repository.getFlatDetails(flatId);
    print('-----API response in usecase: $response');
      return response; 
  }
}