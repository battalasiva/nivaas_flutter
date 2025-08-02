abstract class UpdateDueRepository {
  Future<String> updateDue({
    required String apartmentId,
    required String status,
    required String societyDueIds,
  });
}
