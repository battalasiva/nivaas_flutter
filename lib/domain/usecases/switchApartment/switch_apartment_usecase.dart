import 'package:nivaas/data/models/switchApartment/switch_apartment_model.dart';
import 'package:nivaas/data/repository-impl/switchApartment/switch_apartment_repositoryimpl.dart';

class SwitchApartmentUsecase {
  final SwitchApartmentRepositoryimpl repository;

  SwitchApartmentUsecase({required this.repository});

  Future<List<ApartmentModel>> call(){
    return repository.getApartments();
  }

  Future<void> executeCurrentFlat(int apartmentId, int flatId){
    return repository.setCurrentFlat(apartmentId, flatId);
  }

  Future<void> executeCurrentApartment(int userId, int apartmentId){
    return repository.setCurrentApartment(userId, apartmentId);
  }
}