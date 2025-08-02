import 'package:nivaas/data/models/apartmentOnboarding/my_request_modal.dart';
import 'package:nivaas/domain/repositories/apartmentOnboarding/my_requests_repository.dart';

class MyRequestsUseCase {
  final MyRequestsRepository repository;

  MyRequestsUseCase({required this.repository});

  Future<List<MyRequestModal>> fetchMyRequests(String type) {
    return repository.fetchMyRequests(type);
  }
}
