part of 'my_complaints_bloc.dart';

sealed class MyComplaintsState extends Equatable {
  const MyComplaintsState();

  @override
  List<Object?> get props => [];
}

class MyComplaintsInitial extends MyComplaintsState {}

class MyComplaintsLoading extends MyComplaintsState {}

class MyComplaintsLoaded extends MyComplaintsState {
  final MyComplaintsModel complaints;

  const MyComplaintsLoaded(this.complaints);

  @override
  List<Object?> get props => [complaints];
}

class MyComplaintsError extends MyComplaintsState {
  final String message;

  const MyComplaintsError(this.message);

  @override
  List<Object?> get props => [message];
}
