import 'package:nivaas/data/repository-impl/manageFlats/flat_sale_rent_repository_impl.dart';

class FlatSaleRentUsecase {
  final FlatSaleRentRepositoryImpl repository;

  FlatSaleRentUsecase({required this.repository});
  
  Future<bool> executeFlatForSale(int flatId, bool isSale){
    return repository.postFlatForSale(flatId, isSale);
  }

  Future<bool> executeFlatForRent(int flatId, bool isRent){
    return repository.postFlatForSale(flatId, isRent);
  }
}