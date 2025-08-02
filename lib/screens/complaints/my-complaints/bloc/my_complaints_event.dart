part of 'my_complaints_bloc.dart';

sealed class MyComplaintsEvent extends Equatable {
  const MyComplaintsEvent();

  @override
  List<Object?> get props => [];
}

class FetchMyComplaintsEvent extends MyComplaintsEvent {
  final int apartmentId;
  final int pageNo;
  final int pageSize;

  const FetchMyComplaintsEvent({
    required this.apartmentId,
    required this.pageNo,
    required this.pageSize,
  });

  @override
  List<Object?> get props => [apartmentId, pageNo, pageSize];
}
