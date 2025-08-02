import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/usecases/manageApartment/flatmembers_details_usecase.dart';

import '../../../../data/models/manageApartment/flatmembers_details_model.dart';

part 'flatmember_details_event.dart';
part 'flatmember_details_state.dart';

class FlatmemberDetailsBloc extends Bloc<FlatmemberDetailsEvent, FlatmemberDetailsState> {
  final FlatmembersDetailsUsecase flatmembersDetailsUsecase;
  FlatmemberDetailsBloc(this.flatmembersDetailsUsecase) : super(FlatmemberDetailsInitial()) {
    on<UpdateFlatmemberDetailsEvent>((event, emit) async{
      emit(FlatmemberDetailsLoading());
      try {
        print('Details: ${event.details}');
print('Apartment ID: ${event.apartmentId}');
print('Flat ID: ${event.flatId}');

        final response = await flatmembersDetailsUsecase.executeUpdateFlatmemberDetails(
          event.details, event.apartmentId, event.flatId
        );
        print('-----response in bloc:');
        emit(UpdateFlatmemberDetailsSuccess());
      } catch (e) {
        emit(FlatmemberDetailsFailure(errorMessage: e.toString()));
      }
    });

    on<RemoveFlatmemberEvent>((event, emit) async{
      emit(FlatmemberDetailsLoading());
      try {
        await flatmembersDetailsUsecase.executeRemoveMember(
          event.relatedUserId, event.onboardingRequestId
        );
        emit(RemoveFlatmemberDetailsSuccess());
      } catch (e) {
        emit(FlatmemberDetailsFailure(errorMessage: e.toString()));
      }
    });
  }
}
