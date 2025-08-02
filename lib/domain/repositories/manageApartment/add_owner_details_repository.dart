import 'package:nivaas/data/models/manageApartment/add_ownerdetails_model.dart';

abstract class AddOwnerDetailsRepository {
  Future<bool> addOwnerDetails(AddOwnerdetailsModel flatDetails, int apartmentId);
}