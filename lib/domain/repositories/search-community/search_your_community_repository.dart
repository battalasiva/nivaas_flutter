import 'package:nivaas/data/models/search-community/apartment_model.dart';
import 'package:nivaas/data/models/search-community/city_model.dart';

abstract class SearchYourCommunityRepository {
  Future<List<Content>> selectCity(String query, int pageNo, int pageSize);
  Future<List<ApartmentContent>> selectApartment(
      String query, int cityId, int pageNo, int pageSize);
}
