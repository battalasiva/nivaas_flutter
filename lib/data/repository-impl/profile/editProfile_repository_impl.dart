import 'package:nivaas/data/provider/network/api/profile/editProfile_data_source.dart';
import 'package:nivaas/domain/repositories/profile/editProfile_repository.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileDataSource dataSource;

  EditProfileRepositoryImpl({required this.dataSource});

  @override
  Future<bool> updateProfile({
    required int id,
    required String fullName,
    required String email,
    required String fcmToken,
    required String gender,
  }) async {
    try {
      final data = {'id': id, 'fullName': fullName, 'email': email,'fcmToken':fcmToken,'gender':gender};
      final response = await dataSource.updateProfile(id: id, data: data);
      print(
          'Update Profile Response: $data ${response.statusCode}, ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update profile. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }
}
