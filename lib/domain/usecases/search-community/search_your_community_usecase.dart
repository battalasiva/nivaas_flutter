import 'package:nivaas/data/models/search-community/apartment_model.dart';
import 'package:nivaas/data/repository-impl/search-community/search_your_community_repository_impl.dart';

import '../../../data/models/search-community/city_model.dart';

class SearchYourCommunityUsecase {
  final SearchYourCommunityRepositoryImpl repository;

  SearchYourCommunityUsecase({required this.repository});

  Future<List<Content>> call(String query, int pageNo, int pageSize) async {
    final cities = await repository.selectCity(query, pageNo, pageSize);
    print('CityUseCase: Found ${cities.length} cities');
    return cities;
  }

  Future<List<ApartmentContent>> apartmentCall(
      String query, int cityId, int pageNo, int pageSize) async {
    final apartments =
        await repository.selectApartment(query, cityId, pageNo, pageSize);
    print('ApartmentUseCase: Found ${apartments.length} apartments');
    return apartments;
  }
}
