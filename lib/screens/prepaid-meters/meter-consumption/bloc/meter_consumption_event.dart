import 'package:equatable/equatable.dart';

abstract class PrepaidMeterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPrepaidMeterList extends PrepaidMeterEvent {
  final int apartmentId;
  final int pageNo;
  final int pageSize;

  FetchPrepaidMeterList({
    required this.apartmentId,
    required this.pageNo,
    required this.pageSize,
  });

  @override
  List<Object?> get props => [apartmentId, pageNo, pageSize];
}
