part of 'flat_bloc.dart';

sealed class FlatState extends Equatable {
  const FlatState();
  
  @override
  List<Object> get props => [];
}

final class FlatInitial extends FlatState {}
final class FlatLoading extends FlatState {}
final class FlatLoaded extends FlatState {
  final FlatListModel flats;

  const FlatLoaded(this.flats);
}
final class FlatFailure extends FlatState {
  final String message;

  const FlatFailure(this.message);
}

class SendRequestLoading extends FlatState {}
class SendRequestSuccess extends FlatState {}
class SendRequestFailure extends FlatState {
  final String message;

  const SendRequestFailure(this.message);
}
