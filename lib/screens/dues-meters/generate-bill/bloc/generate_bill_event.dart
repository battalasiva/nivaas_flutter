part of 'generate_bill_bloc.dart';

sealed class GenerateBillEvent extends Equatable {
  const GenerateBillEvent();

  @override
  List<Object> get props => [];
}

final class FetchLastAddedGenerateBill extends GenerateBillEvent {
  final int apartmentId;

  const FetchLastAddedGenerateBill(this.apartmentId);

  @override
  List<Object> get props => [apartmentId];
}

class PostGenerateBillRequested extends GenerateBillEvent {
  final Map<String, dynamic> payload;

  const PostGenerateBillRequested(this.payload);

  @override
  List<Object> get props => [payload];
}