import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/search-community/flat_list_model.dart';
import 'package:nivaas/domain/usecases/search-community/flat_usecase.dart';

part 'flat_event.dart';
part 'flat_state.dart';

class FlatBloc extends Bloc<FlatEvent, FlatState> {
  final FlatsUseCase flatsUseCase;
  final FlatSendRequestUseCase sendRequestUseCase;
  FlatBloc(this.flatsUseCase, this.sendRequestUseCase) : super(FlatInitial()) {
    on<FetchFlats>((event, emit) async {
      emit(FlatLoading());
      try {
        final flats =
            await flatsUseCase.execute(event.memberType, event.apartmentId, event.pageNo, event.pageSize);
        emit(FlatLoaded(flats));
      } catch (e) {
        emit(FlatFailure(e.toString()));
      }
    });

    on<SendRequest>((event, emit) async {
      emit(SendRequestLoading());
      try {
        await sendRequestUseCase.execute(event.memberType, event.flatId);
        emit(SendRequestSuccess());
      } catch (e) {
        emit(SendRequestFailure(e.toString()));
      }
    });
  }
}
