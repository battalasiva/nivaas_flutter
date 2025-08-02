import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/domain/repositories/dues/userDue_repository.dart';
import 'package:nivaas/screens/dues-meters/user-dues/bloc/user_dues_event.dart';
import 'package:nivaas/screens/dues-meters/user-dues/bloc/user_dues_state.dart';

class UserDuesBloc extends Bloc<UserDuesEvent, UserDuesState> {
  final UserDuesRepository repository;

  UserDuesBloc({required this.repository}) : super(UserDuesInitial()) {
    on<FetchUserDuesEvent>((event, emit) async {
      emit(UserDuesLoading());
      print(
          "Fetching User Dues for Apartment: ${event.apartmentId}, Flat: ${event.flatId}");
      try {
        final userDues = await repository.getUserDues(
          apartmentId: event.apartmentId,
          flatId: event.flatId,
          year: event.year,
          month: event.month,
        );
        print("User Dues Loaded: $userDues");
        emit(UserDuesLoaded(userDues: userDues));
      } catch (error) {
        print("Error Fetching User Dues: $error");
        emit(UserDuesError(message: error.toString()));
      }
    });
  }
}
