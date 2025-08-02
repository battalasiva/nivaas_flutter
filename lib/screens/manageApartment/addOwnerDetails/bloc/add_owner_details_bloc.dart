import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/manageApartment/add_ownerdetails_model.dart';
import 'package:nivaas/data/models/manageApartment/onboarding_flat_withdetails_model.dart';
import 'package:nivaas/domain/usecases/manageApartment/add_owner_details_usecase.dart';

part 'add_owner_details_event.dart';
part 'add_owner_details_state.dart';

class AddOwnerDetailsBloc extends Bloc<AddOwnerDetailsEvent, AddOwnerDetailsState> {
  final AddOwnerDetailsUsecase addOwnerDetailsUsecase;
  AddOwnerDetailsBloc(this.addOwnerDetailsUsecase) : super(AddOwnerDetailsInitial()) {
    on<AddDetailsEvent>((event, emit) async{
      emit(AddOwnerDetailsLoading());
      try {
        await addOwnerDetailsUsecase.call(event.flatDetails, event.apartmentId);
        emit(AddOwnerDetailsSuccess());
      } catch (e) {
        emit(AddOwnerDetailsFailure(message: e.toString()));
      }
    });
  }
}
