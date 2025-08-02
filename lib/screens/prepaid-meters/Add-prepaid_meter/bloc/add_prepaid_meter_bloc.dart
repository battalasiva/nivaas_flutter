import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/add_prepaid_meter_consumption_usecase.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/edit_prepaid_meter_usecase.dart';

part 'add_prepaid_meter_event.dart';
part 'add_prepaid_meter_state.dart';

class AddPrepaidMeterBloc extends Bloc<AddPrepaidMeterEvent, AddPrepaidMeterState> {
  final AddPrepaidMeterConsumptionUseCase addPrepaidMeterConsumptionUseCase;
  final EditPrepaidMeterUsecase editPrepaidMeterUsecase;

  AddPrepaidMeterBloc(this.addPrepaidMeterConsumptionUseCase,this.editPrepaidMeterUsecase) : super(AddPrepaidMeterInitial()) {
    on<SubmitPrepaidMeterData>((event, emit) async {
      emit(AddPrepaidMeterLoading());
      try {
        final result = await addPrepaidMeterConsumptionUseCase.addPrepaidMeter(event.payload);
        emit(AddPrepaidMeterSuccess(result.toString()));
      } catch (e) {
        emit(AddPrepaidMeterFailure(e.toString()));
      }
    });
    on<EditPrepaidMeterData>((event, emit) async {
      emit(EditPrepaidMeterLoading());
      try {
        final result = await editPrepaidMeterUsecase.updatePrepaidMeter(event.payload);
        emit(EditPrepaidMeterSuccess(result.toString()));
      } catch (e) {
        emit(EditPrepaidMeterFailure(e.toString()));
      }
    });
  }
}
