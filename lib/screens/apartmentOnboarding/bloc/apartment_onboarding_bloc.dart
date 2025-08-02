import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/domain/usecases/apartmentOnboarding/apartment_onboarding_usecase.dart';

import '../../../data/models/apartmentOnboarding/apartment_onboard_model.dart';

part 'apartment_onboarding_event.dart';
part 'apartment_onboarding_state.dart';

class ApartmentOnboardingBloc extends Bloc<ApartmentOnboardingEvent, ApartmentOnboardingState> {
  final ApartmentOnboardingUsecase apartmentOnboardingUsecase;
  ApartmentOnboardingBloc(this.apartmentOnboardingUsecase) : super(ApartmentOnboardingInitial()) {
    on<PostApartmentDetailsEvent>((event, emit) async{
      emit(ApartmentOnboardingLoading());
      try {
        final success = await apartmentOnboardingUsecase.execute(event.apartment);
        if (success) {
          emit(ApartmentOnboardingLoaded(message: "Apartment details posted successfully"));
        } else {
          emit(ApartmentOnboardingError(error: "Failed to post Apartment details"));
        }
      } catch (e) {
        if (e is AppException) {
          emit(ApartmentOnboardingError(error: e.message));
        } else {
          emit(ApartmentOnboardingError(error: e.toString()));
        }
      }
    });
  }
}
