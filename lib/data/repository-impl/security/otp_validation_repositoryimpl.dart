import 'package:nivaas/data/provider/network/api/security/otp_validation_datasource.dart';
import 'package:nivaas/domain/repositories/security/otp_validation_repository.dart';

class OtpValidationRepositoryimpl implements OtpValidationRepository{
  final OtpValidationDatasource datasource;

  OtpValidationRepositoryimpl({required this.datasource});
  @override
  Future<bool> otpValidation(int requestId, String otp) {
    return datasource.otpValidation(requestId, otp);
  }
  
}