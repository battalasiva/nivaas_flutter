import '../../../domain/repositories/auth/signup_repository.dart';
import '../../provider/network/api/auth/signup_data_source.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupDataSource dataSource;

  SignupRepositoryImpl({required this.dataSource});

  @override
  Future<String> sendOtp(String mobileNumber) {
    return dataSource.sendOtp(mobileNumber);
  }

  @override
  Future<void> verifyOtp(String name, String mobileNumber, String otp) {
    return dataSource.verifyOtp(name, mobileNumber, otp);
  }
}
