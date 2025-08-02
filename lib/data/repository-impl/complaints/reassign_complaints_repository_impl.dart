import 'package:nivaas/data/provider/network/api/complaints/reassign_complaint_dataSource.dart';
import 'package:nivaas/domain/repositories/complaints/reassign_complaint_repository.dart';

class ReassignComplaintRepositoryImpl implements ReassignComplaintRepository {
  final ReassignComplaintDataSource dataSource;

  ReassignComplaintRepositoryImpl({required this.dataSource});

  @override
  Future<bool> reassignComplaint({
    required int id,
    required String status,
    required String assignedTo,
    required bool? isAdmin,
  }) {
    return dataSource.reassignComplaint(
        id: id, status: status, assignedTo: assignedTo, isAdmin: isAdmin);
  }
}
