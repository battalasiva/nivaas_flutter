import 'package:nivaas/data/models/manageApartment/add_ownerdetails_model.dart';
import 'package:nivaas/data/repository-impl/manageApartment/add_owner_details_repository_impl.dart';

class AddOwnerDetailsUsecase {
  final AddOwnerDetailsRepositoryImpl repository;

  AddOwnerDetailsUsecase({required this.repository});

  Future<bool> call(AddOwnerdetailsModel flatDetails, int apartmentId){
    return repository.addOwnerDetails(flatDetails, apartmentId);
  }
}