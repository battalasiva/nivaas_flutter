part of 'flat_bloc.dart';

sealed class FlatEvent extends Equatable {
  const FlatEvent();

  @override
  List<Object> get props => [];
}

class FetchFlats extends FlatEvent{
  final String memberType;
  final int apartmentId, pageNo, pageSize;

  const FetchFlats(this.memberType, this.apartmentId, this.pageNo, this.pageSize);
}

class SendRequest extends FlatEvent {
  final String memberType;
  final int flatId;

  const SendRequest(this.memberType, this.flatId);
}