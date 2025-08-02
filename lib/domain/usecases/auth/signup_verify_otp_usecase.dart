import '../../../data/repository-impl/auth/signup_repository_impl.dart';

class SignupVerifyOtpUseCase {
  final SignupRepositoryImpl repository;

  SignupVerifyOtpUseCase({required this.repository});

  Future<void> call(String name, String mobileNumber, String otp) {
    return repository.verifyOtp(name, mobileNumber, otp);
  }
}
