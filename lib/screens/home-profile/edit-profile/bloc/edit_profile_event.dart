part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditProfileSubmitted extends EditProfileEvent {
  final String id;
  final String fullName;
  final String email;
  final String fcmToken;
  final String gender;

  EditProfileSubmitted({
    required this.id,
    required this.fullName,
    required this.email,
    required this.fcmToken,
    required this.gender,
  });

  @override
  List<Object?> get props => [id, fullName, email,fcmToken];
}

class UploadProfilePicture extends EditProfileEvent {
  final File image;

  UploadProfilePicture(this.image);

  @override
  List<Object> get props => [image];
}

class LogoutButtonPressed extends EditProfileEvent {
  final String userId;

  LogoutButtonPressed({required this.userId});

  @override
  List<Object> get props => [userId];
}