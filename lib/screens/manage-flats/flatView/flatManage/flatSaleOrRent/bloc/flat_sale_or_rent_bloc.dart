import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/manageFlats/flat_sale_rent_usecase.dart';

part 'flat_sale_or_rent_event.dart';
part 'flat_sale_or_rent_state.dart';

class FlatSaleOrRentBloc extends Bloc<FlatSaleOrRentEvent, FlatSaleOrRentState> {
  final FlatSaleRentUsecase flatSaleRentUsecase;
  FlatSaleOrRentBloc(this.flatSaleRentUsecase) : super(FlatSaleOrRentInitial()) {
    on<PostFlatForRentEvent>((event, emit) async{
      emit(FlatForRentLoading());
      try {
        final response = await flatSaleRentUsecase.executeFlatForRent(event.flatId, event.isRent);
        print('--------- $response');
        emit(FlatForRentSuccess());
      } catch (e) {
        emit(FlatSaleOrRentFailure(errorMessage: e.toString()));
      }
    });

    on<PostFlatForSaleEvent>((event, emit) async{
      emit(FlatForSaleLoading());
      try {
        final response = await flatSaleRentUsecase.executeFlatForSale(event.flatId, event.isSale);
        print('--------- $response');
        emit(FlatForSaleSuccess());
      } catch (e) {
        emit(FlatSaleOrRentFailure(errorMessage: e.toString()));
      }
    });
  }
}
