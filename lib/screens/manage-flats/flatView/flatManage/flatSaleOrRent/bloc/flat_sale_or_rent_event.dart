part of 'flat_sale_or_rent_bloc.dart';

sealed class FlatSaleOrRentEvent extends Equatable {
  const FlatSaleOrRentEvent();

  @override
  List<Object> get props => [];
}

class PostFlatForSaleEvent extends FlatSaleOrRentEvent {
  final int flatId;
  final bool isSale;

  PostFlatForSaleEvent({required this.flatId, required this.isSale});
}

class PostFlatForRentEvent extends FlatSaleOrRentEvent {
  final int flatId;
  final bool isRent;

  PostFlatForRentEvent({required this.flatId, required this.isRent});
}