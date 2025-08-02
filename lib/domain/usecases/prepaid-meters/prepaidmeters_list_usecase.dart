import 'package:nivaas/domain/repositories/prepaid-meters/prepaidMeter_list_repository.dart';

class FetchPrepaidMetersListUseCase {
  final PrepaidMeterListRepository repository;

  FetchPrepaidMetersListUseCase({required this.repository});

  Future<dynamic> execute({
    required int apartmentId,
    required int pageNo,
    required int pageSize,
  }) {
    return repository.getPrepaidMeters(
      apartmentId: apartmentId,
      pageNo: pageNo,
      pageSize: pageSize,
    );
  }
}
