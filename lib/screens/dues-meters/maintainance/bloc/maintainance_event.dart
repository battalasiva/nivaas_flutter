part of 'maintainance_bloc.dart';

sealed class MaintainanceEvent extends Equatable {
  const MaintainanceEvent();

  @override
  List<Object> get props => [];
}

final class GetCurrentBalanceEvent extends MaintainanceEvent {
  final int apartmentId;

  const GetCurrentBalanceEvent({required this.apartmentId});

  @override
  List<Object> get props => [apartmentId];
}

class FetchTransactions extends MaintainanceEvent {
  final int apartmentId;
  final int page;
  final int size;
  final Map<String, dynamic> appliedFilters;
  const FetchTransactions({
    required this.apartmentId,
    required this.page,
    required this.size,
    required this.appliedFilters,
  });

  @override
  List<Object> get props => [apartmentId, page, size, appliedFilters];
}

class RefreshBalanceRequested extends MaintainanceEvent {
  final int apartmentId;

  const RefreshBalanceRequested(this.apartmentId);

  @override
  List<Object> get props => [apartmentId];
}