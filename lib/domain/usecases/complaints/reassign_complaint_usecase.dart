import 'package:nivaas/domain/repositories/complaints/reassign_complaint_repository.dart';

class ReassignComplaintUseCase {
  final ReassignComplaintRepository repository;

  ReassignComplaintUseCase(this.repository);

  Future<bool> call({
    required int id,
    required String status,
    required String assignedTo,
    required bool isAdmin,
  }) {
    return repository.reassignComplaint(
        id: id, status: status, assignedTo: assignedTo, isAdmin: isAdmin);
  }
}
