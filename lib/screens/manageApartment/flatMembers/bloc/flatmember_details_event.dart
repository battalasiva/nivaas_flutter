part of 'flatmember_details_bloc.dart';

sealed class FlatmemberDetailsEvent extends Equatable {
  const FlatmemberDetailsEvent();

  @override
  List<Object> get props => [];
}
class UpdateFlatmemberDetailsEvent extends FlatmemberDetailsEvent {
  final FlatmembersDetailsModel details;
  final int apartmentId; 
  final int flatId;

  UpdateFlatmemberDetailsEvent({required this.details, required this.apartmentId, required this.flatId});
}

class RemoveFlatmemberEvent extends FlatmemberDetailsEvent {
  final int relatedUserId;
  final int onboardingRequestId;

  RemoveFlatmemberEvent({required this.relatedUserId, required this.onboardingRequestId});
}