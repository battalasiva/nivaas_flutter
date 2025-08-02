import 'package:nivaas/data/models/search-community/apartment_model.dart';
import 'package:nivaas/data/models/search-community/city_model.dart';
import 'package:nivaas/data/provider/network/api/search-community/search_your_community_data_source.dart';
import 'package:nivaas/domain/repositories/search-community/search_your_community_repository.dart';

class SearchYourCommunityRepositoryImpl extends SearchYourCommunityRepository {
  final SearchYourCommunityDataSource dataSource;

  SearchYourCommunityRepositoryImpl({required this.dataSource});

  @override
  Future<List<Content>> selectCity(String query, int pageNo, int pageSize) async {
    return await dataSource.selectCity(query, pageNo, pageSize);
  }

  @override
  Future<List<ApartmentContent>> selectApartment(
      String query, int cityId, int pageNo, int pageSize) async {
    return await dataSource.selectApartment(query, cityId, pageNo, pageSize);
  }
}
