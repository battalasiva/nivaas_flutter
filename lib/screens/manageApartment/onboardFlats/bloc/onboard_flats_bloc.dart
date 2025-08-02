import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/manageApartment/onboarding_flat_withdetails_model.dart';
import '../../../../data/models/manageApartment/onboarding_flat_withoutdetails_model.dart';
import '../../../../domain/usecases/manageApartment/onboard_flats_usecase.dart';

part 'onboard_flats_event.dart';
part 'onboard_flats_state.dart';

class OnboardFlatsBloc extends Bloc<OnboardFlatsEvent, OnboardFlatsState> {
  final OnboardFlatsUsecase onboardFlatsUsecase;
  OnboardFlatsBloc(this.onboardFlatsUsecase) : super(OnboardFlatsInitial()) {
    on<OnboardFlatWithDetailsEvent>((event, emit) async{
      emit(OnboardFlatsLoading());
      try {
        final success = await onboardFlatsUsecase.executeFlatWithDetails(event.flatDetails);
        if (success) {
          emit(OnboardFlatsLoaded());
        } else {
          emit(OnboardFlatsError(message: 'Failed to onboard flat details'));
        }
      } catch (e) {
        emit(OnboardFlatsError(message: e.toString()));
      }
    });

    on<OnboardFlatWithoutDetailsEvent>((event, emit) async{
      emit(OnboardFlatsLoading());
      try {
        final success = await onboardFlatsUsecase.executeFlatWithoutDetails(event.flatDetails);
        if (success) {
          emit(OnboardFlatsLoaded());
        } else {
          emit(OnboardFlatsError(message: 'Failed to onboard flat details'));
        }
      } catch (e) {
        emit(OnboardFlatsError(message: e.toString()));
      }
    });
  }
}
