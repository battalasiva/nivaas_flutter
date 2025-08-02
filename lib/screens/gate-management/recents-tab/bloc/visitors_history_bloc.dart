import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/gate-management/visitors_history_usecase.dart';

import '../../../../data/models/gateManagement/visitors_history_model.dart';

part 'visitors_history_event.dart';
part 'visitors_history_state.dart';

class VisitorsHistoryBloc extends Bloc<VisitorsHistoryEvent, VisitorsHistoryState> {
  final VisitorsHistoryUsecase visitorsHistoryUsecase;
  VisitorsHistoryBloc(this.visitorsHistoryUsecase) : super(VisitorsHistoryInitial()) {
    on<FetchVisitorsHistoryEvent>((event, emit) async{
      emit(VisitorsHistoryLoading());
      try {
        final response = await visitorsHistoryUsecase.execute(
          event.apartmentId, event.flatId, event.pageNo, event.pageSize 
        );
        emit(VisitorsHistoryLoaded(details: response));
      } catch (e) {
        emit(VisitorsHistoryFailure(message: e.toString()));
      }
    });
  }
}
