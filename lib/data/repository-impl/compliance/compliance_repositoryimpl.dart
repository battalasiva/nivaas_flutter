import 'package:nivaas/data/models/compliance/compliance_model.dart';
import 'package:nivaas/data/provider/network/api/compliance/compliance_datasource.dart';
import 'package:nivaas/domain/repositories/compliance/compliance_repository.dart';

class ComplianceRepositoryimpl implements ComplianceRepository {
  final ComplianceDatasource datasource;

  ComplianceRepositoryimpl({required this.datasource});
  @override
  Future<ComplianceModel> getCompliance(int apartmentId) {
    return datasource.getCompliance(apartmentId);
  }
  
  @override
  Future<bool> addCompliance(int apartmentId, List<String> dos, List<String> donts) {
    return datasource.addCompliance(apartmentId, dos, donts);
  }

  @override
  Future<bool> updateCompliance(int apartmentId, List<String> dos, List<String> donts) {
    return datasource.updateCompliance(apartmentId, dos, donts);
  }
  
}