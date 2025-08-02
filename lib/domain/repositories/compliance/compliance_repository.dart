import '../../../data/models/compliance/compliance_model.dart';

abstract class ComplianceRepository {
  Future<ComplianceModel> getCompliance(int apartmentId);
  Future<bool> addCompliance(int apartmentId, List<String> dos, List<String> donts);
  Future<bool> updateCompliance(int apartmentId, List<String> dos, List<String> donts);
}