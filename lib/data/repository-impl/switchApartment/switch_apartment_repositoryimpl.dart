import 'package:nivaas/data/models/switchApartment/switch_apartment_model.dart';
import 'package:nivaas/data/provider/network/api/switchApartment/switch_apartment_datasource.dart';
import 'package:nivaas/domain/repositories/switchApartment/switch_apartment_repository.dart';

class SwitchApartmentRepositoryimpl implements SwitchApartmentRepository {
  final SwitchApartmentDatasource datasource;

  SwitchApartmentRepositoryimpl({required this.datasource});
  @override
  Future<List<ApartmentModel>> getApartments() {
    final response = datasource.fetchApartments();
    print('--------response in repo : $response');
    return response;
  }
  
  @override
  Future<void> setCurrentFlat(int apartmentId, int flatId) {
    return datasource.setCurrentFlatDetails(apartmentId, flatId);
  }
  
  @override
  Future<void> setCurrentApartment(int userId, int apartmentId) {
    return datasource.setCurrentApartment(userId, apartmentId);
  }
  
}