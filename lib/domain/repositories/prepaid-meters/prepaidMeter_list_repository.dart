abstract class PrepaidMeterListRepository {
  Future<dynamic> getPrepaidMeters({
    required int apartmentId,
    required int pageNo,
    required int pageSize,
  });
}