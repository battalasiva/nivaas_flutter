import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/security/gate_activities_usecase.dart';

import '../../../../data/models/security/guest_invite_entries_model.dart';

part 'gate_activities_event.dart';
part 'gate_activities_state.dart';

class GateActivitiesBloc extends Bloc<GateActivitiesEvent, GateActivitiesState> {
  final GateActivitiesUsecase gateActivitiesUsecase;
  GateActivitiesBloc(this.gateActivitiesUsecase) : super(GateActivitiesInitial()) {
    on<FetchCheckinHistoryEvent>((event, emit) async{
      emit(GateActivitiesLoading());
      try {
        final response = await gateActivitiesUsecase.call(event.apartmentId, event.status, event.pageNo, event.pageSize);
        emit(GateActivitiesLoaded(details: response));
      } catch (e) {
        emit(GateActivitiesFailure(message: e.toString()));
      }
    });
  }
}
