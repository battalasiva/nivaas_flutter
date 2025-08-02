part of 'all_flats_bloc.dart';

sealed class AllFlatsEvent extends Equatable {
  const AllFlatsEvent();

  @override
  List<Object> get props => [];
}

class GetFlatDetailsEvent extends AllFlatsEvent {
  final int apartmentId;

  const GetFlatDetailsEvent({required this.apartmentId});
}

class GetFlatsWithoutDetailsEvent extends AllFlatsEvent {
  final int apartmentId, pageNo, pageSize;

  const GetFlatsWithoutDetailsEvent({required this.apartmentId, required this.pageNo, required this.pageSize});
}

class GetFlatmembersEvent extends AllFlatsEvent {
  final int apartmentId;
  final int flatId;

  const GetFlatmembersEvent({required this.apartmentId, required this.flatId});
}