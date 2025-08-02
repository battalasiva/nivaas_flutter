
abstract class LoginRepository {
  Future<String> sendOtp(String mobileNumber);

  Future<void> verifyOtp(String mobileNumber, String otp,);
}