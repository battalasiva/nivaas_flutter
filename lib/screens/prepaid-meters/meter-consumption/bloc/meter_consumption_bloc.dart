import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/data/models/prepaid-meters/PrepaidMetersList.dart';
import 'package:nivaas/domain/usecases/prepaid-meters/prepaidmeters_list_usecase.dart';
import 'package:nivaas/screens/prepaid-meters/meter-consumption/bloc/meter_consumption_event.dart';
import 'package:nivaas/screens/prepaid-meters/meter-consumption/bloc/meter_consumption_state.dart';

class PrepaidMeterBloc extends Bloc<PrepaidMeterEvent, PrepaidMeterState> {
  final FetchPrepaidMetersListUseCase fetchPrepaidMetersUseCase;
  PrepaidMeterBloc(this.fetchPrepaidMetersUseCase)
      : super(PrepaidMeterInitial()) {
    on<FetchPrepaidMeterList>((event, emit) async {
  emit(PrepaidMeterLoading());
  try {
    final result = await fetchPrepaidMetersUseCase.execute(
      apartmentId: event.apartmentId,
      pageNo: event.pageNo,
      pageSize: event.pageSize,
    );

    if (result is PrepaidMetersListModal) {
      emit(PrepaidMeterLoaded(result));
    } else if (result is Map<String, dynamic>) {
      emit(PrepaidMeterError(result['errorMessage']));
    } else {
      emit(PrepaidMeterError(result['errorMessage']));
    }
  } catch (e) {
    emit(PrepaidMeterError(e.toString()));
  }
});
  }
}
