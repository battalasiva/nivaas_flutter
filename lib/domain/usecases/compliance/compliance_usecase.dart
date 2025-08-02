import 'package:nivaas/data/repository-impl/compliance/compliance_repositoryimpl.dart';

import '../../../data/models/compliance/compliance_model.dart';

class ComplianceUsecase {
  final ComplianceRepositoryimpl repository;

  ComplianceUsecase({required this.repository});

  Future<ComplianceModel> getCompliance(int apartmentId){
    return repository.getCompliance(apartmentId);
  }

  Future<bool> addCompliance(int apartmentId, List<String> dos, List<String> donts){
    return repository.updateCompliance(apartmentId, dos, donts);
  }

  Future<bool> updateCompliance(int apartmentId, List<String> dos, List<String> donts){
    return repository.updateCompliance(apartmentId, dos, donts);
  }
}