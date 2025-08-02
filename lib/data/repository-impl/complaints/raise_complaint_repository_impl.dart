import 'package:nivaas/data/provider/network/api/complaints/raise_complaint_data_source.dart';
import 'package:nivaas/domain/repositories/complaints/raise_complaint_repository.dart';

class RaiseComplaintRepositoryImpl implements RaiseComplaintRepository {
  final RaiseComplaintDataSource dataSource;

  RaiseComplaintRepositoryImpl({required this.dataSource});

  @override
  Future<String> raiseComplaint(Map<String, dynamic> payload) {
    return dataSource.raiseComplaint(payload);
  }
}
