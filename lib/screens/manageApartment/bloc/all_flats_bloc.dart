import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/manageApartment/flats_model.dart';
import 'package:nivaas/domain/usecases/manageApartment/all_flats_usecase.dart';

import '../../../data/models/manageApartment/flats_without_details_model.dart';

part 'all_flats_event.dart';
part 'all_flats_state.dart';

class AllFlatsBloc extends Bloc<AllFlatsEvent, AllFlatsState> {
  final AllFlatsUsecase allFlatsUsecase;
  AllFlatsBloc(this.allFlatsUsecase) : super(AllFlatsInitial()) {
    on<GetFlatsWithoutDetailsEvent>((event, emit) async{
      emit(AllFlatsLoading());
      try {
        final response = await allFlatsUsecase.callGetFlatsWithoutDetails(event.apartmentId, event.pageNo, event.pageSize);
        print('-----------response in bloc: $response');
        emit(FlatWithoutDetailsLoaded(flatsWithoutDetails: response));
      } catch (e) {
        emit(AllFlatsError(message: e.toString()));
      }
    });

    on<GetFlatDetailsEvent>((event, emit) async{
      emit(AllFlatsLoading());
      try {
        final response =await allFlatsUsecase.call(event.apartmentId);
        print('-----------response in bloc: $response');
        emit(FlatDetailsLoaded(flats: response));
      } catch (e) {
        emit(AllFlatsError(message: e.toString()));
      }
    });

    on<GetFlatmembersEvent>((event, emit) async{
      emit(AllFlatsLoading());
      try {
        final response =await allFlatsUsecase.callGetmembers(event.apartmentId, event.flatId);
        print('-----------response in bloc: $response');
        emit(FlatMembersLoaded(flats: response));
      } catch (e) {
        emit(AllFlatsError(message: e.toString()));
      }
    });
  }
}
