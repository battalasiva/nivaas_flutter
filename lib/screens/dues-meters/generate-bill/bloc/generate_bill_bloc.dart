import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/dues/LastAddedGenerateBill_modal.dart';
import 'package:nivaas/domain/usecases/dues/last_added_generate_bill_usecase.dart';
import 'package:nivaas/domain/usecases/dues/post_generate_bill_usecase.dart';

part 'generate_bill_event.dart';
part 'generate_bill_state.dart';

class GenerateBillBloc extends Bloc<GenerateBillEvent, GenerateBillState> {
  final LastAddedGenerateBillUseCase lastAddedGenerateBillUseCase;
  final PostGenerateBillUseCase postGenerateBillUseCase;

  GenerateBillBloc(
      this.lastAddedGenerateBillUseCase, this.postGenerateBillUseCase)
      : super(GenerateBillInitial()) {
    on<FetchLastAddedGenerateBill>((event, emit) async {
      emit(GenerateBillLoading());
      try {
        final result = await lastAddedGenerateBillUseCase(event.apartmentId);
        if (result is LastAddedGenerateBillModal) {
          emit(GenerateBillLoaded(result));
        } else if (result is Map && result.containsKey("errorMessage")) {
          emit(GenerateBillError(result["errorMessage"]));
        } else {
          emit(GenerateBillError("Unknown error occurred"));
        }
      } catch (e) {
        emit(GenerateBillError(e.toString()));
      }
    });

    on<PostGenerateBillRequested>((event, emit) async {
      emit(PostGenerateBillLoading());
      try {
        final result = await postGenerateBillUseCase.call(event.payload);
        emit(PostGenerateBillSuccess(result));
      } catch (e) {
        emit(PostGenerateBillFailure(e.toString()));
      }
    });
  }
}
