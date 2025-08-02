import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/data/models/search-community/apartment_model.dart';

import '../../../../data/models/search-community/city_model.dart';
import '../../../../domain/usecases/search-community/search_your_community_usecase.dart';

part 'search_your_community_event.dart';
part 'search_your_community_state.dart';

class SearchYourCommunityBloc
    extends Bloc<SearchYourCommunityEvent, SearchYourCommunityState> {
  final SearchYourCommunityUsecase communityUsecase;

  SearchYourCommunityBloc(this.communityUsecase)
      : super(SearchYourCommunityInitial()) {
    on<SearchCityEvent>((event, emit) async {
      emit(SearchCityLoading());
      try {
        final cities = await communityUsecase.call(event.query, event.pageNo, event.pageSize);
        // bool hasMore = cities.length == event.pageSize;
        // print('-----hasMore: $hasMore');
        emit(SearchCityLoaded(cities: cities,));
      } catch (_) {
        emit(SearchCityError(message: 'Failed to load cities'));
      }
    });

    on<SearchApartmentEvent>((event, emit) async {
      emit(SearchApartmentLoading());
      try {
        final apartments = await communityUsecase.apartmentCall(
            event.query, event.cityId, event.pageNo, event.pageSize);
        print('-----------Apartments fetched: $apartments');
        emit(SearchApartmentLoaded(apartments: apartments));
      } catch (e) {
        emit(SearchCityError(message: 'Failed to load apartments: $e'));
      }
    });
  }
}
