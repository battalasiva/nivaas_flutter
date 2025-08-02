import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/gate-management/configured_visitors_usecase.dart';

import '../../../../data/models/gateManagement/configured_visitor_invites_model.dart';
import '../../../../data/models/security/guest_invite_entries_model.dart';

part 'configured_visitors_event.dart';
part 'configured_visitors_state.dart';

class ConfiguredVisitorsBloc extends Bloc<ConfiguredVisitorsEvent, ConfiguredVisitorsState> {
  final ConfiguredVisitorsUsecase configuredVisitorsUsecase;
  ConfiguredVisitorsBloc(this.configuredVisitorsUsecase) : super(ConfiguredVisitorsInitial()) {
    on<FetchConfiguredVisitorsEvent>((event, emit) async{
      emit(ConfiguredVisitorsLoading());
      try {
        final response = await configuredVisitorsUsecase.call(
          event.apartmentId, event.flatId, event.pageNo, event.pageSize
        );
        emit(ConfiguredVisitorsLoaded(details: response));
      } catch (e) {
        emit(ConfiguredVisitorsFailure(message: e.toString()));
      }
    });
  }
}
