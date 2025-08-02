import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/prepaid-meters/GetMeterReadingsModal.dart';
import 'package:nivaas/data/models/prepaid-meters/GetSingleMeterReadings.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/PostMeterReadingsUseCase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/get_single_meter_readings_usecase.dart';

import '../../../../domain/usecases/prepaid-meters/get_meter_readings_usecase.dart';

part 'add_meter_readings_event.dart';
part 'add_meter_readings_state.dart';

class AddMeterReadingsBloc extends Bloc<AddMeterReadingsEvent, AddMeterReadingsState> {
   final GetMeterReadingsUseCase getMeterReadingsUseCase;
   final PostMeterReadingsUseCase postMeterReadingUseCase;
   final GetSingleMeterReadingsUseCase getSingleMeterReadingsUseCase;

  AddMeterReadingsBloc(this.getMeterReadingsUseCase,this.postMeterReadingUseCase,this.getSingleMeterReadingsUseCase) : super(AddMeterReadingsInitial()) {
    on<FetchMeterReadingsEvent>((event, emit) async {
      emit(GetMeterReadingsLoading());
      try {
        final readings = await getMeterReadingsUseCase.execute(event.apartmentId, event.prepaidMeterId);
        emit(GetMeterReadingsLoaded(readings));
      } catch (error) {
        emit(GetMeterReadingsError(error.toString()));
      }
    });
    on<SubmitMeterReadingEvent>((event, emit) async {
      emit(PostMeterReadingsLoading());
      try {
        final message = await postMeterReadingUseCase.postMeterReading(event.payload);
        emit(PostMeterReadingsSuccess(message: message));
      } catch (error) {
        emit(PostMeterReadingsError(message: error.toString()));
      }
    });
    on<FetchSingleMeterReadings>((event, emit) async {
      emit(GetSingleMeterReadingsLoading());
      try {
        final reading = await getSingleMeterReadingsUseCase(
          apartmentId: event.apartmentId,
          prepaidMeterId: event.prepaidMeterId,
          flatId: event.flatId,
        );
        emit(GetSingleMeterReadingsLoaded(reading));
      } catch (error) {
        emit(GetSingleMeterReadingsError(error.toString()));
      }
    });
    
  }
}