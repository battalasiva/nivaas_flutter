import 'package:nivaas/domain/repositories/complaints/raise_complaint_repository.dart';

class RaiseComplaintUseCase {
  final RaiseComplaintRepository repository;

  RaiseComplaintUseCase(this.repository);

  Future<String> execute(Map<String, dynamic> payload) {
    return repository.raiseComplaint(payload);
  }
}
