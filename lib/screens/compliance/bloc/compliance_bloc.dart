import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/compliance/compliance_model.dart';
import 'package:nivaas/domain/usecases/compliance/compliance_usecase.dart';

part 'compliance_event.dart';
part 'compliance_state.dart';

class ComplianceBloc extends Bloc<ComplianceEvent, ComplianceState> {
  final ComplianceUsecase complianceUsecase;
  ComplianceBloc(this.complianceUsecase) : super(ComplianceInitial()) {
    on<GetCompliancesEvent>((event, emit) async{
      emit(ComplianceLoading());
      try {
        final response = await complianceUsecase.getCompliance(event.apartmentId);
        emit(ComplianceListLoaded(details: response));
      } catch (e) {
        emit(ComplianceFailure(message: e.toString()));
      }
    });

    on<AddComplianceEvent>((event, emit) async{
      emit(ComplianceLoading());
      try {
        final response = await complianceUsecase.addCompliance(event.apartmentId, event.dos, event.donts);
        emit(ComplianceUpdated());
      } catch (e) {
        emit(ComplianceFailure(message: e.toString()));
      }
    });

    on<UpdateComplianceEvent>((event, emit) async{
      emit(ComplianceLoading());
      try {
        final response = await complianceUsecase.updateCompliance(event.apartmentId, event.dos, event.donts);
        emit(ComplianceUpdated());
      } catch (e) {
        emit(ComplianceFailure(message: e.toString()));
      }
    });
  }
}
