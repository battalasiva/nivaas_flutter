import 'package:nivaas/data/models/services/GetServicesPartnersListmodal.dart';

abstract class GetServiceProvidersListRepository {
  Future<List<GetServicePartnersListModel>> getServiceProviders(int apartmentId, int categoryId);
}
