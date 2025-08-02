part of 'search_your_community_bloc.dart';

sealed class SearchYourCommunityEvent extends Equatable {
  const SearchYourCommunityEvent();

  @override
  List<Object> get props => [];
}
 class SearchCityEvent extends SearchYourCommunityEvent{
  final String query;
  final int pageNo;
  final int pageSize;

  const SearchCityEvent({required this.query, required this.pageNo, required this.pageSize});
  @override
  List<Object> get props => [query];
 }

 class SearchApartmentEvent extends SearchYourCommunityEvent{
  final String query;
  final int cityId;
  final int pageNo;
  final int pageSize;

  const SearchApartmentEvent({required this.query, required this.cityId, required this.pageNo, required this.pageSize});
  @override
  List<Object> get props => [query, cityId, pageNo, pageSize];
 }