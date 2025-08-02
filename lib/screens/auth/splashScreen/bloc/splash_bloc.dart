import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/auth/current_customer_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/domain/usecases/auth/user_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserUsecase userUsecase;
  final ApiClient apiClient;

  SplashBloc({required this.userUsecase, required this.apiClient})
      : super(SplashInitial()) {
    on<CheckTokenEvent>((event, emit) async {
      emit(SplashLoading());
      String? accessToken = await apiClient.getAccessToken();
      print("Access Token: $accessToken");
      if (accessToken != null && accessToken.isNotEmpty) {
        {
          try {
            CurrentCustomerModel currentUser = await userUsecase();
            print("User: $currentUser");
            if (currentUser.currentFlat != null || 
              (currentUser.currentApartment?.apartmentAdmin ?? false) ||
              ((currentUser.user.roles.contains('ROLE_APARTMENT_HELPER') && (currentUser.currentApartment != null)))
            ) {
              emit(SplashSuccess(user: currentUser));
            } else {
              emit(SplashApartmentNotFound(user: currentUser));
            }
          } catch (e) {
            print("Error: $e");
            emit(SplashFailure(message: e.toString()));
          }
        }
      } else {
        emit(SplashFailureTokenNotFound());
      }
    });
  }
}
