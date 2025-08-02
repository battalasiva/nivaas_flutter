part of 'raise_complaint_bloc.dart';

sealed class RaiseComplaintEvent extends Equatable {
  const RaiseComplaintEvent();

  @override
  List<Object> get props => [];
}

final class SubmitRaiseComplaintEvent extends RaiseComplaintEvent {
  final Map<String, dynamic> payload;

  const SubmitRaiseComplaintEvent(this.payload);

  @override
  List<Object> get props => [payload];
}

class FetchAdminsEvent extends RaiseComplaintEvent {
  final int apartmentId;

  const FetchAdminsEvent({required this.apartmentId});

  @override
  List<Object> get props => [apartmentId];
}
