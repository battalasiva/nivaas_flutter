import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/screens/apartmentOnboarding/apartment_onboarding.dart';
import 'package:nivaas/screens/search-community/searchYourCommunity/bloc/search_your_community_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/searchbox.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/img_consts.dart';
import '../../../core/constants/text_styles.dart';
import '../../core/constants/gradients.dart';
import '../../data/models/search-community/city_model.dart';

class SearchCity extends StatefulWidget {
  const SearchCity({super.key});

  @override
  State<SearchCity> createState() => _SearchCommunityState();
}

class _SearchCommunityState extends State<SearchCity> {
  final TextEditingController _cityController = TextEditingController();
  String? selectedCity;
  int? selectedCityId;
  int pageNo = 0;
  int pageSize = 20;

  String? district;
  String? region;
  List<String> selectedPostalCodes = [];
  FocusNode cityFocusNode = FocusNode();
  bool isLoadingMore = false;
  bool hasMoreCities = true;
  List<Content> cities = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cityController.clear();
    cityFocusNode.addListener(() {
      _onSearch('');
    });
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    cityFocusNode.dispose();
    _cityController.dispose();
    super.dispose();
  }
  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !isLoadingMore &&
        hasMoreCities) {
      pageNo++;
      _loadCities();
    }
  }
  void _loadCities({String query = ''}) {
    if (isLoadingMore || !hasMoreCities) return; 
    setState(() {
      isLoadingMore = true;
    });

    context.read<SearchYourCommunityBloc>().add(
      SearchCityEvent(query: _cityController.text, pageNo: pageNo, pageSize: pageSize),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22))),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: AppGradients.gradient1,
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
              )),
          title: Text(
            'Select City',
            style: txt_17_800.copyWith(color: AppColor.white1),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
              child: Column(
                children: [
                  Searchbox(
                    searchController: _cityController,
                    searchFocusNode: cityFocusNode,
                    onSearch: _onSearch,
                    hintText: 'Select City',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchYourCommunityBloc, SearchYourCommunityState>(
        builder: (context, state) {
          print('-------------------$state');
          if (state is SearchCityLoading && pageNo == 0) {
            return Center(child: AppLoader());
          } else if (state is SearchCityError) {
            return Center(child: Text(state.message));
          } 
          else if(state is SearchCityLoaded){
            if (state.cities.isNotEmpty &&
              (cities.isEmpty || cities.last.id != state.cities.last.id)) {
              cities.addAll(state.cities);
              hasMoreCities = state.cities.length == pageSize;
            }
            isLoadingMore = false;
             if (cityFocusNode.hasFocus) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: cities.length + (isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == cities.length) {
                    return const Center(child: AppLoader());
                  }
                  final city = cities[index];
                  return ListTile(
                    title: Text(city.name),
                    onTap: () {
                      setState(() {
                        selectedCity = city.name;
                        selectedCityId = city.id;
                        district = city.district;
                        region = city.region;
                        selectedPostalCodes = city.postalCodes.map((postalCode) => postalCode.code).toList();
                      });
                      _cityController.text = selectedCity!;
                      cityFocusNode.unfocus();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        ApartmentOnboarding(
                          city: selectedCity!, cityId: selectedCityId!, 
                          region: region!, postalCodes: selectedPostalCodes,
                        )
                      ));
                    },
                  );
                },
              );
            } 
          } 
            return Center(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Search & Select Your City',
                  style: txt_17_700.copyWith(color: AppColor.black2),
                ),
                Text(
                  'Eg. Hyderabad',
                  style: txt_12_400.copyWith(color: AppColor.black2),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  void _onSearch(String query) {
    setState(() {
      pageNo = 0; 
      isLoadingMore = false;
      hasMoreCities = true; 
      if (selectedCity == null) {
        cities.clear();
        _loadCities(query: query);
      }
    });
  }
}
