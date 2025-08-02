import 'package:nivaas/domain/repositories/auth/login_repository.dart';

import '../../provider/network/api/auth/login_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImpl({required this.dataSource});

  @override
  Future<String> sendOtp(String mobileNumber) {
    return dataSource.sendOtp(mobileNumber);
  }

  @override
  Future<void> verifyOtp(
    String mobileNumber,
    String otp,
  ) {
    return dataSource.verifyOtp(
      mobileNumber,
      otp,
    );
  }
}
