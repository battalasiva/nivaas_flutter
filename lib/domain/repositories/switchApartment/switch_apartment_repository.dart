import 'package:nivaas/data/models/switchApartment/switch_apartment_model.dart';

abstract class SwitchApartmentRepository {
  Future<List<ApartmentModel>> getApartments();
  Future<void> setCurrentFlat(int apartmentId, int flatId);
  Future<void> setCurrentApartment(int userId, int apartmentId);
}