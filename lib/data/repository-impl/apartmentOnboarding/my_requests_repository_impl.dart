import 'package:nivaas/data/models/apartmentOnboarding/my_request_modal.dart';
import 'package:nivaas/data/provider/network/api/apartmentOnboarding/my_requests_datasource.dart';
import 'package:nivaas/domain/repositories/apartmentOnboarding/my_requests_repository.dart';

class MyRequestsRepositoryImpl implements MyRequestsRepository {
  final MyRequestsDataSource dataSource;

  MyRequestsRepositoryImpl({required this.dataSource});

  @override
  Future<List<MyRequestModal>> fetchMyRequests(String type) {
    return dataSource.fetchMyRequests(type);
  }
}
