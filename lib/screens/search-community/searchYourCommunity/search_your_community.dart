import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/screens/apartmentOnboarding/apartment_onboarding.dart';
import 'package:nivaas/screens/search-community/searchYourCommunity/bloc/search_your_community_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/img_consts.dart';
import '../../../core/constants/text_styles.dart';
import '../apartment_details/apartment_details.dart';

class SearchYourCommunity extends StatefulWidget {
  final String source;
  const SearchYourCommunity({super.key, required this.source});

  @override
  State<SearchYourCommunity> createState() => _SearchCommunityState();
}

class _SearchCommunityState extends State<SearchYourCommunity> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  String? selectedCity;
  String? selectedApartment;
  List<String> availableApartments = [];
  int? selectedCityId;
  int? selectedApartmentId;
  int pageNo = 0;
  int pageSize = 20;
  String? district;
  String? state;

  @override
  void initState() {
    super.initState();
    _cityController.clear();
    _apartmentController.clear();
  }

  @override
  void dispose() {
    _cityController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  void _onCitySelected(Map<String, dynamic> cityInfo) {
    setState(() {
      selectedCity = cityInfo['city'];
      selectedCityId = cityInfo['cityId'];
      district = cityInfo['district'];
      state = cityInfo['state'];
      selectedApartment = null;
      pageNo = 0;
    });
  }

  void _onCityRowTapped(BuildContext context) async {
    final cityBloc = context.read<SearchYourCommunityBloc>();
    final selected = await showSearch<Map<String, dynamic>>(
      context: context,
      delegate: CitySearchDelegate(cityBloc: cityBloc),
    );
    if (selected != null && selected.isNotEmpty) {
      _onCitySelected(selected);
    }
  }

  void _onApartmentSelected(Map<String, dynamic> apartmentInfo) {
    setState(() {
      selectedApartment = apartmentInfo['apartment'];
      selectedApartmentId = apartmentInfo['apartmentId'];
    });
    if (selectedApartment != null &&
        selectedCity != null &&
        district != null &&
        state != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApartmentDetails(
            apartmentName: selectedApartment ?? 'Default Apartment',
            city: selectedCity ?? 'Default City',
            district: district ?? 'Default District',
            state: state ?? 'Default State',
            apartmentId: selectedApartmentId ?? 0,
            source: widget.source,
          ),
        ),
      );
    } 
    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Some required data is missing.')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryColor1, AppColor.primaryColor2],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              backArrow,
              width: 24,
              height: 24,
              color: AppColor.white,
            ),
          ),
          title: Text(
            selectedCity == null ? 'Select City' : 'Search Your Community',
            style: txt_17_800.copyWith(color: AppColor.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              height: selectedCity == null
                  ? getHeight(context) * 0.1
                  : getHeight(context) * 0.15,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.primaryColor1, AppColor.primaryColor2],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22))),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () async {
                        final cityBloc =
                            context.read<SearchYourCommunityBloc>();
                        final selected = await showSearch<Map<String, dynamic>>(
                            context: context,
                            delegate: CitySearchDelegate(cityBloc: cityBloc));
                        if (selected != null && selected.isNotEmpty) {
                          _onCitySelected(selected);
                        }
                      },
                      child: selectedCity == null
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColor.white1,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                children: [
                                  Icon(Icons.search),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Select City',
                                    style: txt_13_400.copyWith(
                                        color: AppColor.greyText1),
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _onCityRowTapped(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 95,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      selectedCity!,
                                      style: txt_16_500.copyWith(
                                          color: AppColor.white1),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down_outlined,
                                      size: 20,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            )),
                  if (selectedCity != null) ...[
                    SizedBox(height: 16),
                    GestureDetector(
                        onTap: () async {
                          final apartmentBloc =
                              context.read<SearchYourCommunityBloc>();
                          final apartmentSelected =
                              await showSearch<Map<String, dynamic>>(
                            context: context,
                            delegate: ApartmentSearchDelegate(
                                apartmentBloc: apartmentBloc,
                                city: selectedCity!,
                                cityId: selectedCityId!,
                                region: state!,
                                pageSize: pageSize),
                          );
                          if (apartmentSelected != null) {
                            _onApartmentSelected(apartmentSelected);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColor.white1,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              SizedBox(width: 8),
                              Text(
                                'Search by apartment, society etc',
                                style: txt_13_400.copyWith(
                                    color: AppColor.greyText1),
                              ),
                            ],
                          ),
                        )),
                  ],
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  selectedCity == null
                      ? 'Search & Select Your City'
                      : 'Search & join your community',
                  style: txt_17_700.copyWith(color: AppColor.black2),
                ),
                Text(
                  selectedCity == null
                      ? 'Eg. Hyderabad'
                      : 'Eg. Anna Poorna apartment',
                  style: txt_12_400.copyWith(color: AppColor.black2),
                ),
              ],
            ),
            Container()
          ],
        ));
  }
}

class CitySearchDelegate extends SearchDelegate<Map<String, dynamic>> {
  final Bloc<SearchYourCommunityEvent, SearchYourCommunityState> cityBloc;

  CitySearchDelegate({required this.cityBloc});

  @override
  String get searchFieldLabel => 'Search City';

  @override
  TextStyle get searchFieldStyle => const TextStyle(color: Colors.grey);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, {});
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    cityBloc.add(SearchCityEvent(query: query, pageNo: 0, pageSize: 20));

    return BlocBuilder<SearchYourCommunityBloc, SearchYourCommunityState>(
      builder: (context, state) {
        if (state is SearchCityLoading) {
          return const Center(child: AppLoader());
        } else if (state is SearchCityLoaded) {
          if (state.cities.isEmpty) {
            return const Center(child: Text('No cities found.'));
          }
          return ListView.builder(
            itemCount: state.cities.length,
            itemBuilder: (context, index) {
              final city = state.cities[index];
              return ListTile(
                title: Text(city.name),
                onTap: () {
                  close(context, {
                    'city': city.name,
                    'cityId': city.id,
                    'district': city.district,
                    'state': city.region
                  });
                },
              );
            },
          );
        } else if (state is SearchCityError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Start typing to search.'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    cityBloc.add(SearchCityEvent(query: query, pageNo: 0, pageSize: 20));


    return BlocBuilder<SearchYourCommunityBloc, SearchYourCommunityState>(
      builder: (context, state) {
        if (state is SearchCityLoading) {
          return const Center(child: AppLoader());
        } else if (state is SearchCityLoaded) {
          final suggestions = state.cities
              .where((city) =>
                  city.name.toLowerCase().startsWith(query.toLowerCase()))
              .toList();
          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final city = suggestions[index];
              return ListTile(
                title: Text(city.name),
                onTap: () {
                  query = city.name;
                  showResults(context);
                  close(context, {
                    'city': city.name,
                    'cityId': city.id,
                    'district': city.district,
                    'state': city.region
                  });
                },
              );
            },
          );
        } else if (state is SearchCityError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}

class ApartmentSearchDelegate extends SearchDelegate<Map<String, dynamic>> {
  final Bloc<SearchYourCommunityEvent, SearchYourCommunityState> apartmentBloc;
  final String city;
  final int cityId;
  final String region;
  final int pageSize;
  bool bottomSheetShown = false;
  int currentPage = 0; // Track the current page for pagination
  bool isLoading = false; // Flag to prevent multiple API calls

  ScrollController _scrollController = ScrollController();

  ApartmentSearchDelegate(
      {required this.apartmentBloc,required this.city, required this.cityId,required this.region, this.pageSize = 10});

  @override
  String get searchFieldLabel => 'Search Apartment';

  @override
  TextStyle get searchFieldStyle => const TextStyle(color: Colors.grey);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, {});
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // if(query.length >= 3){
    //   apartmentBloc.add(SearchApartmentEvent(
    //     query: query, cityId: cityId, pageNo: 0, pageSize: pageSize));
    // }
    _loadApartments(query: query);

    return BlocBuilder<SearchYourCommunityBloc, SearchYourCommunityState>(
      builder: (context, state) {
        if (state is SearchApartmentLoading) {
          return const Center(child: AppLoader());
        } else if (state is SearchApartmentLoaded) {
          final apartments = state.apartments;
          final totalApartments = state.apartments.length;
          if (apartments.isEmpty) {
            if (!bottomSheetShown) {
              bottomSheetShown = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showNoResultsBottomSheet(context, city, cityId, region);
              });
            }
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: apartments.length +(totalApartments > apartments.length ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == apartments.length) {
                return isLoading ? const Center(child: AppLoader()) : const SizedBox();
              }
              final apartment = apartments[index];
              return ListTile(
                title: Text(apartment.name),
                onTap: () {
                  close(context, {
                    'apartment': apartment.name,
                    'apartmentId': apartment.id
                  });
                },
              );
            },
          );
        } else if (state is SearchCityError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // if(query.length >= 3){
    //   apartmentBloc.add(SearchApartmentEvent(
    //     query: query, cityId: cityId, pageNo: 0, pageSize: pageSize));
    // }
    _loadApartments(query: query);

    return BlocBuilder<SearchYourCommunityBloc, SearchYourCommunityState>(
      builder: (context, state) {
        if (state is SearchApartmentLoading) {
          return const Center(child: AppLoader());
        } else if (state is SearchApartmentLoaded) {
          final apartments = state.apartments;
          final totalApartments = state.apartments.length;
          final suggestions = apartments
              .where((apartment) =>
                  apartment.name.toLowerCase().startsWith(query.toLowerCase()))
              .toList();
          if (suggestions.isEmpty) {
            if (!bottomSheetShown) {
              bottomSheetShown = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showNoResultsBottomSheet(context, city, cityId, region);
              });
            }
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: suggestions.length +(totalApartments > suggestions.length ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == suggestions.length) {
                return isLoading ? const Center(child: AppLoader()) : const SizedBox();
              }
              final apartment = suggestions[index];
              return ListTile(
                title: Text(apartment.name),
                onTap: () {
                  query = apartment.name;
                  showResults(context);
                  close(context, {
                    'apartment': apartment.name,
                    'apartmentId': apartment.id
                  });
                },
              );
            },
          );
        } else if (state is SearchCityError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }

  void _loadApartments({String query = ''}) {
    if (!isLoading) {
        isLoading = true;

      apartmentBloc.add(SearchApartmentEvent(
        query: query,
        cityId: cityId,
        pageNo: currentPage,
        pageSize: pageSize,
      ));
    }
  }

  void _showNoResultsBottomSheet(BuildContext context, String city, int cityId, String region) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 67),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Apartment Doesn’t Exist! Please Click\nOnboard Apartment Button To Send A Request!',
                style: txt_14_500.copyWith(color: AppColor.black2),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              CustomizedButton(
                  label: 'Onboard Apartment',
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> ApartmentOnboarding(city: city, cityId: cityId, region: region,)));
                  },
                  style: txt_14_500.copyWith(color: AppColor.white))
            ],
          ),
        );
      },
    );
  }
}
