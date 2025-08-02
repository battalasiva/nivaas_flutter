import '../../../data/repository-impl/auth/login_repository_impl.dart';

class LoginVerifyOtpUseCase {
  final LoginRepositoryImpl repository;

  LoginVerifyOtpUseCase({required this.repository});

  Future<void> call(
    String mobileNumber,
    String otp,
  ) {
    return repository.verifyOtp(
      mobileNumber,
      otp,
    );
  }
}
