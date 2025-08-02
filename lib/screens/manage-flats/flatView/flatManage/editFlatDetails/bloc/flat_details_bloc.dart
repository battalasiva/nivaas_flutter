import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/manageFlats/flat_details_usecase.dart';

import '../../../../../../data/models/manageFlats/flat_details_model.dart';

part 'flat_details_event.dart';
part 'flat_details_state.dart';

class FlatDetailsBloc extends Bloc<FlatDetailsEvent, FlatDetailsState> {
  final FlatDetailsUsecase flatDetailsUsecase;
  FlatDetailsBloc(this.flatDetailsUsecase) : super(FlatDetailsInitial()) {
    on<UpdateFlatDetailsEvent>((event, emit) async {
      emit(FlatDetailsUpdating());
      try {
        print(
            "Updating flat details with: ${event.flatId}, ${event.flatDetails}");
        final response = await flatDetailsUsecase.executeUpdateflatDetails(
            event.flatId, event.flatDetails);
        print('-----response in bloc: $response');
        emit(FlatDetailsUpdated());
      } catch (e) {
        emit(FlatDetailsFailure(message: e.toString()));
      }
    });

    on<FetchFlatDetailsEvent>((event, emit) async {
      emit(FlatDetailsLoading());
      try {
        final response =
            await flatDetailsUsecase.executeGetflatDetails(event.flatid);
        print('-----------response in bloc: $response');
        emit(FlatDetailsLoaded(flatDetails: response));
      } catch (e) {
        emit(FlatDetailsFailure(message: e.toString()));
      }
    });
  }
}
