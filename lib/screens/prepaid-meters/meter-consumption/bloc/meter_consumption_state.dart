import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/prepaid-meters/PrepaidMetersList.dart';

abstract class PrepaidMeterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PrepaidMeterInitial extends PrepaidMeterState {}

class PrepaidMeterLoading extends PrepaidMeterState {}

class PrepaidMeterLoaded extends PrepaidMeterState {
  final PrepaidMetersListModal meters;

  PrepaidMeterLoaded(this.meters);

  @override
  List<Object?> get props => [meters];
}

class PrepaidMeterError extends PrepaidMeterState {
  final String message;

  PrepaidMeterError(this.message);

  @override
  List<Object?> get props => [message];
}
