abstract class ReassignComplaintRepository {
  Future<bool> reassignComplaint({
    required int id,
    required String status,
    required String assignedTo,
    required bool? isAdmin,
  });
}
