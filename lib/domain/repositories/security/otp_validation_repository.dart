abstract class OtpValidationRepository {
  Future<bool> otpValidation(int requestId, String otp);
}