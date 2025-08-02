import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/prepaid-meters/GetSingleFlatLastAddedConsumptionUnitsModal.dart';
import 'package:nivaas/data/models/prepaid-meters/last_added_Consumption_model.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/add_consumption_usecase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/get_singleFlat_consumption_usecase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/last_addedConsumption_usecase.dart';

part 'add_consumption_event.dart';
part 'add_consumption_state.dart';

class AddConsumptionBloc
    extends Bloc<AddConsumptionEvent, AddConsumptionState> {
  final AddConsumptionUseCase useCase;
  final LastAddedConsumptionUseCase lastAddedConsumptionUseCase;
  final GetSingleFlatLastAddedConsumptionUseCase
      getSingleFlatLastAddedConsumptionUseCase;

  AddConsumptionBloc(this.useCase, this.lastAddedConsumptionUseCase,
      this.getSingleFlatLastAddedConsumptionUseCase)
      : super(AddConsumptionInitial()) {
    on<SubmitConsumptionData>((event, emit) async {
      emit(AddConsumptionLoading());
      try {
        final result = await useCase.call(event.payload);
        emit(AddConsumptionSuccess(result));
      } catch (e) {
        emit(AddConsumptionFailure(e.toString()));
      }
    });
    on<FetchLastAddedConsumptionEvent>((event, emit) async {
      emit(ConsumptionLoading());
      try {
        final consumptionData = await lastAddedConsumptionUseCase(
          apartmentId: event.apartmentId,
          prepaidId: event.prepaidId,
        );
        emit(ConsumptionLoaded(consumptionData));
      } catch (e) {
        emit(ConsumptionError(e.toString()));
      }
    });
    on<FetchLastAddedSingleFlatConsumptionEvent>((event, emit) async {
      emit(SingleFlatConsumptionLoading());
      try {
        final singleFlatconsumptionData =
            await getSingleFlatLastAddedConsumptionUseCase(
          apartmentId: event.apartmentId,
          prepaidId: event.prepaidId,
          flatId: event.flatId,
        );
        print('SINGLE_FLAT_DATA : $singleFlatconsumptionData');
        emit(SingleFlatConsumptionLoaded(singleFlatconsumptionData));
      } catch (e) {
        emit(SingleFlatConsumptionError(e.toString()));
      }
    });
  }
}
