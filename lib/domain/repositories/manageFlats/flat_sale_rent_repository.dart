abstract class FlatSaleRentRepository {
  Future<bool>postFlatForSale(int flatId, bool isSale);
  Future<bool>postFlatForRent(int flatId, bool isRent);
}