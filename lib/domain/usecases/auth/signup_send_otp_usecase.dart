import '../../../data/repository-impl/auth/signup_repository_impl.dart';

class SignupSendOtpUsecase {
  final SignupRepositoryImpl repository;

  SignupSendOtpUsecase({required this.repository});

  Future<String> call(String mobileNumber) {
    return repository.sendOtp(mobileNumber);
  }
}
