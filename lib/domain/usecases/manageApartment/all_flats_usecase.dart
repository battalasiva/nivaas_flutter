import 'package:nivaas/data/models/manageApartment/flats_model.dart';
import 'package:nivaas/data/models/manageApartment/flats_without_details_model.dart';
import 'package:nivaas/data/repository-impl/manageApartment/all_flats_repository_impl.dart';

class AllFlatsUsecase {
  final AllFlatsRepositoryImpl repository;

  AllFlatsUsecase({required this.repository});

  Future<List<FlatsModel>> call(int apartmentId){
    final response = repository.getFlats(apartmentId);
    print('response in usecase -------- $response');
    return response;
  }

  Future<FlatsWithoutDetailsModel> callGetFlatsWithoutDetails(int apartmentId,int pageNo, int pageSize){
    return repository.getFlatsWithoutDetails(apartmentId,pageNo, pageSize);
  }

  Future<List<FlatsModel>> callGetmembers(int apartmentId, int flatId){
    return repository.getFlatMembers(apartmentId, flatId);
  }
}