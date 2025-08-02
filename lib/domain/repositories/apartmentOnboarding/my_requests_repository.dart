import 'package:nivaas/data/models/apartmentOnboarding/my_request_modal.dart';

abstract class MyRequestsRepository {
  Future<List<MyRequestModal>> fetchMyRequests(String type);
}
