import 'package:nivaas/data/provider/network/api/manageFlats/flat_sale_rent_datasource.dart';
import 'package:nivaas/domain/repositories/manageFlats/flat_sale_rent_repository.dart';

class FlatSaleRentRepositoryImpl implements FlatSaleRentRepository {
  final FlatSaleRentDatasource datasource;

  FlatSaleRentRepositoryImpl({required this.datasource});
  @override
  Future<bool> postFlatForRent(int flatId, bool isRent) {
    return datasource.postFlatForRent(flatId, isRent);
  }

  @override
  Future<bool> postFlatForSale(int flatId, bool isSale) {
    return datasource.postFlatForSale(flatId, isSale);
  }
  
}