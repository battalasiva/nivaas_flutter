import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/switchApartment/switch_apartment_usecase.dart';

import '../../../data/models/switchApartment/switch_apartment_model.dart';

part 'switch_apartment_event.dart';
part 'switch_apartment_state.dart';

class SwitchApartmentBloc extends Bloc<SwitchApartmentEvent, SwitchApartmentState> {
  final SwitchApartmentUsecase switchApartmentUsecase;
  SwitchApartmentBloc(this.switchApartmentUsecase) : super(SwitchApartmentInitial()) {
    on<SwitchApartmentOrFlatEvent>((event, emit) async{
      print('------------------SwitchApartmentOrFlatEvent triggered');
      emit(SwitchApartmentLoading());
      try {
        final apartments = await switchApartmentUsecase.call();
        print('-------response in bloc loaded: $apartments');
        if (apartments.isEmpty) {
          emit(NoFlatsState());
        } else {
          emit(SwitchApartmentLoaded(apartments: apartments));          
        }
      } catch (e) {
        emit(SwitchApartmentError(message: e.toString()));
      }
    });

    on<SetCurrentFlatEvent>((event, emit) async {
      emit(SwitchApartmentLoading());
      try {
        await switchApartmentUsecase.executeCurrentFlat(event.apartmentId, event.flatId);
        emit(SwitchApartmentChangedSuccess());
      } catch (e) {
        emit(SwitchApartmentChangedFailure(errorMessage: e.toString()));
      }
    });

    on<SetCurrentApartmentEvent>((event, emit) async {
      emit(SwitchApartmentLoading());
      try {
        await switchApartmentUsecase.executeCurrentApartment(event.userId, event.apartmentId);
        emit(SwitchApartmentChangedSuccess());
      } catch (e) {
        emit(SwitchApartmentChangedFailure(errorMessage: e.toString()));
      }
    });
  }
}
