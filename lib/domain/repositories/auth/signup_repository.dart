
abstract class SignupRepository {


  Future<String> sendOtp(String mobileNumber);

  Future<void> verifyOtp(String name, String mobileNumber, String otp);

}