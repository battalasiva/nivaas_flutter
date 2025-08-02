import 'package:nivaas/data/models/manageApartment/flats_model.dart';
import 'package:nivaas/data/models/manageApartment/flats_without_details_model.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/all_flats_datasource.dart';
import 'package:nivaas/domain/repositories/manageApartment/all_flats_repository.dart';

class AllFlatsRepositoryImpl implements AllFlatsRepository {
  final AllFlatsDatasource datasource;

  AllFlatsRepositoryImpl({required this.datasource});
  @override
  Future<List<FlatsModel>> getFlats(int apartmentId) {
    try {
      final response = datasource.getFlats(apartmentId);
      print('---response in repo: $response'); 
      return response;
    } catch (e) {
      print('Error fetching flats: $e'); 
      rethrow;
    }
  }

  @override
  Future<FlatsWithoutDetailsModel> getFlatsWithoutDetails(int apartmentId,int pageNo, int pageSize) {
    try {
      final response = datasource.getFlatsWithoutDetails(apartmentId,pageNo, pageSize);
      print('---response in repo: $response'); 
      return response;
    } catch (e) {
      print('Error fetching flats: $e'); 
      rethrow;
    }
  }
  
  @override
  Future<List<FlatsModel>> getFlatMembers(int apartmentId, int flatId) {
    try {
      final response = datasource.getFlatmembers(apartmentId, flatId);
      print('---response in repo: $response'); 
      return response;
    } catch (e) {
      print('Error fetching flats: $e'); 
      rethrow;
    }
  }
  
}