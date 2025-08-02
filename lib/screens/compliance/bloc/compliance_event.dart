part of 'compliance_bloc.dart';

sealed class ComplianceEvent extends Equatable {
  const ComplianceEvent();

  @override
  List<Object> get props => [];
}

class GetCompliancesEvent extends ComplianceEvent {
  final int apartmentId;

  const GetCompliancesEvent({required this.apartmentId});
}

class AddComplianceEvent extends ComplianceEvent {
  final int apartmentId;
  final List<String> dos, donts;

  const AddComplianceEvent({required this.apartmentId, required this.dos, required this.donts});
}

class UpdateComplianceEvent extends ComplianceEvent {
  final int apartmentId;
  final List<String> dos, donts;

  const UpdateComplianceEvent({required this.apartmentId, required this.dos, required this.donts});
}