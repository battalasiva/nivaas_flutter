import 'package:nivaas/data/provider/network/api/prepaid-meters/post_meter_readings_datasource.dart';
import 'package:nivaas/domain/repositories/prepaid-meters/PostMeterReadingsRepository.dart';


class PostMeterReadingsRepositoryImpl implements PostMeterReadingsRepository {
  final PostMeterReadingsDataSource dataSource;

  PostMeterReadingsRepositoryImpl({required this.dataSource});

  @override
  Future<String> postMeterReading(Map<String, dynamic> payload) async {
    return await dataSource.postMeterReading(payload);
  }
}
