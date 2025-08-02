import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/repositories/profile/editProfile_repository.dart';
import 'package:nivaas/domain/repositories/profile/profile_upload_repository.dart';
import 'package:nivaas/domain/usecases/profile/logout_user_usecase.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileRepository editProfileRepository;
  final ProfilePicRepository profilePicRepository;
  final LogoutUserUseCase? logoutUserUseCase;

  EditProfileBloc({
    required this.editProfileRepository,
    required this.profilePicRepository,
    this.logoutUserUseCase,
  }) : super(EditProfileInitial()) {
    // Handle Edit Profile
    on<EditProfileSubmitted>((event, emit) async {
      emit(EditProfileLoading());
      final success = await editProfileRepository.updateProfile(
        id: int.parse(event.id),
        fullName: event.fullName,
        email: event.email,
        fcmToken: event.fcmToken,
        gender: event.gender,
      );
      if (success) {
        emit(EditProfileSuccess());
      } else {
        emit(EditProfileFailure(error: 'Failed to update profile.'));
      }
    });

    // Handle Upload Profile Picture
    on<UploadProfilePicture>((event, emit) async {
      emit(ProfileUploadLoading());
      try {
        final success =
            await profilePicRepository.uploadProfilePicture(event.image);
        if (success) {
          emit(ProfileUploadSuccess());
        } else {
          emit(ProfileUploadFailure(error: 'Failed to upload profile picture'));
        }
      } catch (e) {
        emit(ProfileUploadFailure(error: e.toString()));
      }
    });
    on<LogoutButtonPressed>((event, emit) async {
      emit(LogoutLoading());
      final result = await logoutUserUseCase?.logoutUser(event.userId);
      if (result?['success']) {
        emit(LogoutSuccess(result?['message']));
      } else {
        emit(LogoutFailure(result?['message']));
      }
    });
  }
}
