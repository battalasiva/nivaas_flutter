import 'dart:io';

abstract class ProfilePicRepository {
  Future<bool> uploadProfilePicture(File image);
}
