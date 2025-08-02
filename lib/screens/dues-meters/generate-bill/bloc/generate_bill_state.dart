part of 'generate_bill_bloc.dart';

sealed class GenerateBillState extends Equatable {
  const GenerateBillState();

  @override
  List<Object> get props => [];
}

final class GenerateBillInitial extends GenerateBillState {}

final class GenerateBillLoading extends GenerateBillState {}

final class GenerateBillLoaded extends GenerateBillState {
  final LastAddedGenerateBillModal bill;

  const GenerateBillLoaded(this.bill);

  @override
  List<Object> get props => [bill];
}

final class GenerateBillError extends GenerateBillState {
  final String error;

  const GenerateBillError(this.error);

  @override
  List<Object> get props => [error];
}

class PostGenerateBillInitial extends GenerateBillState {}

class PostGenerateBillLoading extends GenerateBillState {}

class PostGenerateBillSuccess extends GenerateBillState {
  final String message;

  const PostGenerateBillSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class PostGenerateBillFailure extends GenerateBillState {
  final String error;

  const PostGenerateBillFailure(this.error);

  @override
  List<Object> get props => [error];
}