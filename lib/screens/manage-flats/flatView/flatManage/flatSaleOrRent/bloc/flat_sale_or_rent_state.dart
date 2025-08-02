part of 'flat_sale_or_rent_bloc.dart';

sealed class FlatSaleOrRentState extends Equatable {
  const FlatSaleOrRentState();
  
  @override
  List<Object> get props => [];
}

final class FlatSaleOrRentInitial extends FlatSaleOrRentState {}

class FlatForSaleLoading extends FlatSaleOrRentState{}
class FlatForSaleSuccess extends FlatSaleOrRentState{}
class FlatForRentLoading extends FlatSaleOrRentState{}
class FlatForRentSuccess extends FlatSaleOrRentState{}
class FlatSaleOrRentFailure extends FlatSaleOrRentState{
  final String errorMessage;

  FlatSaleOrRentFailure({required this.errorMessage});
}

