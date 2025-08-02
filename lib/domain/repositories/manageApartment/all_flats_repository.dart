import 'package:nivaas/data/models/manageApartment/flats_model.dart';
import 'package:nivaas/data/models/manageApartment/flats_without_details_model.dart';

abstract class AllFlatsRepository {
  Future<List<FlatsModel>> getFlats(int apartmentId);
  Future<FlatsWithoutDetailsModel> getFlatsWithoutDetails(int apartmentId, int pageNo, int pageSize);
  Future<List<FlatsModel>> getFlatMembers(int apartmentId, int flatId);
}