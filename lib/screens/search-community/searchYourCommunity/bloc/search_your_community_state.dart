part of 'search_your_community_bloc.dart';

sealed class SearchYourCommunityState extends Equatable {
  const SearchYourCommunityState();
  
  @override
  List<Object> get props => [];
}

final class SearchYourCommunityInitial extends SearchYourCommunityState {}

final class SearchCityLoading extends SearchYourCommunityState {}
final class SearchCityLoaded extends SearchYourCommunityState {
  final List<Content> cities;
  

  const SearchCityLoaded({required this.cities});

  @override
  List<Object> get props => [cities];
}
final class SearchCityError extends SearchYourCommunityState {
  final String message;

  const SearchCityError({required this.message});

  @override
  List<Object> get props => [message];
}

final class SearchApartmentLoading extends SearchYourCommunityState {}
final class SearchApartmentLoaded extends SearchYourCommunityState {
  final List<ApartmentContent> apartments;

  const SearchApartmentLoaded({required this.apartments});

  @override
  List<Object> get props => [apartments];
}