import 'package:nivaas/data/repository-impl/security/otp_validation_repositoryimpl.dart';

class OtpValidationUsecase {
  final OtpValidationRepositoryimpl repository;

  OtpValidationUsecase({required this.repository});

  Future<bool> execute(int requestId, String otp){
    return repository.otpValidation(requestId, otp);
  }
}