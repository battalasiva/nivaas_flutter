part of 'compliance_bloc.dart';

sealed class ComplianceState extends Equatable {
  const ComplianceState();
  
  @override
  List<Object> get props => [];
}

final class ComplianceInitial extends ComplianceState {}
class ComplianceLoading extends ComplianceState {}
class ComplianceListLoaded extends ComplianceState {
  final ComplianceModel details;

  const ComplianceListLoaded({required this.details});
}
class ComplianceUpdated extends ComplianceState {}
class ComplianceFailure extends ComplianceState {
  final String message;

  const ComplianceFailure({required this.message});
}
