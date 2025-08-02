import 'package:nivaas/data/models/manageApartment/add_ownerdetails_model.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/add_owner_details_datasource.dart';
import 'package:nivaas/domain/repositories/manageApartment/add_owner_details_repository.dart';

class AddOwnerDetailsRepositoryImpl  implements AddOwnerDetailsRepository{
  final AddOwnerDetailsDatasource datasource;

  AddOwnerDetailsRepositoryImpl({required this.datasource});
  @override
  Future<bool> addOwnerDetails(AddOwnerdetailsModel flatDetails, int apartmentId) {
    return datasource.addOwnerDetails(flatDetails, apartmentId);
  }
  
}