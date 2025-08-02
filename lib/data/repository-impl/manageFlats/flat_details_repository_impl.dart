import 'package:nivaas/data/models/manageFlats/flat_details_model.dart';
import 'package:nivaas/data/provider/network/api/manageFlats/flat_details_data_source.dart';
import 'package:nivaas/domain/repositories/manageFlats/flat_details_repository.dart';

class FlatDetailsRepositoryImpl  extends FlatDetailsRepository{
  final FlatDetailsDataSource dataSource;

  FlatDetailsRepositoryImpl({required this.dataSource});
  @override
  Future<FlatDetailsModel> updateFlatDetails(int flatId, FlatDetailsModel flatDetails) async{
    try {
    final response = await dataSource.saveFlatDetails(flatId, flatDetails);
    print('---response in repo: $response'); 
    return response;
  } catch (e) {
    print('Error updating flat details: $e');
    rethrow;
  }
  }
  
  @override
  Future <FlatDetailsModel> getFlatDetails(int flatId) async{
    try {
    final response = await dataSource.fetchFlatDetails(flatId);
    print('---response in repo: $response'); 
    return response;
  } catch (e) {
    print('Error fetching flat details: $e'); 
    rethrow;
  }
  }
}