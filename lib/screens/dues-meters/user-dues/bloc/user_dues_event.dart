import 'package:equatable/equatable.dart';

abstract class UserDuesEvent extends Equatable {
  const UserDuesEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserDuesEvent extends UserDuesEvent {
  final int apartmentId;
  final int flatId;
  final int year;
  final int month;

  const FetchUserDuesEvent({
    required this.apartmentId,
    required this.flatId,
    required this.year,
    required this.month,
  });

  @override
  List<Object?> get props => [apartmentId, flatId, year, month];
}
