import 'package:nivaas/data/models/manageFlats/flat_details_model.dart';

abstract class FlatDetailsRepository {

  Future<FlatDetailsModel> updateFlatDetails(int flatId, FlatDetailsModel flatDetails);
  Future <FlatDetailsModel> getFlatDetails(int flatId);
}