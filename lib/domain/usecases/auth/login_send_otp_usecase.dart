import '../../../data/repository-impl/auth/login_repository_impl.dart';

class LoginSendOtpUseCase {
  final LoginRepositoryImpl repository;

  LoginSendOtpUseCase({required this.repository});

  Future<String> call(String mobileNumber) {
    return repository.sendOtp(mobileNumber);
  }
}
