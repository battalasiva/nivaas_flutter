abstract class EditProfileRepository {
  Future<bool> updateProfile({
    required int id,
    required String fullName,
    required String email,
    required String fcmToken,
    required String gender,
  });
}