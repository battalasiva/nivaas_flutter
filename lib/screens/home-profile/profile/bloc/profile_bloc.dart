import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/auth/logout_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LogoutUsecase logoutUsecase;
    // final ApiClient apiClient;
  ProfileBloc(this.logoutUsecase) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        await logoutUsecase.call();
        emit(ProfileLoaded());
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
