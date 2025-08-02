import 'package:nivaas/domain/repositories/prepaid-meters/PostMeterReadingsRepository.dart';

class PostMeterReadingsUseCase {
  final PostMeterReadingsRepository repository;

  PostMeterReadingsUseCase({required this.repository});

  Future<String> postMeterReading(Map<String, dynamic> payload) async {
    return await repository.postMeterReading(payload);
  }
}
