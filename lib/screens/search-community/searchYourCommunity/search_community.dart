import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/data/models/search-community/apartment_model.dart';
import 'package:nivaas/screens/search-community/apartment_details/apartment_details.dart';
import 'package:nivaas/screens/search-community/searchYourCommunity/bloc/search_your_community_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/elements/searchbox.dart';
import 'package:nivaas/widgets/elements/short_button.dart';
import 'package:nivaas/widgets/others/ContactUsModel.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/constants/img_consts.dart';
import '../../../core/constants/text_styles.dart';
import '../../../data/models/search-community/city_model.dart';
import '../../../widgets/elements/button.dart';
import '../../apartmentOnboarding/apartment_onboarding.dart';

class SearchCommunity extends StatefulWidget {
  final String source;
  const SearchCommunity({super.key, required this.source});

  @override
  State<SearchCommunity> createState() => _SearchCommunityState();
}

class _SearchCommunityState extends State<SearchCommunity> {
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
  String? region;
  List<String> selectedPostalCodes = [];
  FocusNode cityFocusNode = FocusNode();
  FocusNode apartmentFocusNode = FocusNode();
  bool isLoadingMore = false;
  bool hasMoreCities = true;
  List<Content> cities = [];
  List<ApartmentContent> apartments = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _resetState();
    cityFocusNode.addListener(() {
      _onSearch('');
    });

    apartmentFocusNode.addListener(() {
      _onSearch('');
    });
    _scrollController.addListener(_scrollListener);
  }
  void showContactUsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ContactUsModal(),
    );
  }
  void _resetState() {
  _cityController.clear();
  _apartmentController.clear();
  selectedCity = null;
  selectedApartment = null;
  availableApartments.clear();
  selectedCityId = null;
  selectedApartmentId = null;
  pageNo = 0;
  district = null;
  region = null;
  isLoadingMore = false;
  hasMoreCities = true;
  cities.clear();
  apartments.clear();
}

  @override
  void dispose() {
    cityFocusNode.dispose();
    apartmentFocusNode.dispose();
    _cityController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }
  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !isLoadingMore &&
        hasMoreCities) {
      pageNo++;
      selectedCity == null ? _loadCities() : _loadApartments();
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
  void _loadApartments({String query = ''}) {
    if (isLoadingMore || !hasMoreCities) return; 
    setState(() {
      isLoadingMore = true;
    });

    context.read<SearchYourCommunityBloc>().add(
      SearchApartmentEvent(query: _apartmentController.text, cityId: selectedCityId!, pageNo: pageNo, pageSize: pageSize),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: selectedCity == null ? Size.fromHeight(120.0) : Size.fromHeight(160),
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
            selectedCity == null ? 'Select City' : 'Search Your Community',
            style: txt_17_800.copyWith(color: AppColor.white1),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
              child: Column(
                children: [
                  selectedCity == null ?
                  Searchbox(
                    searchController: _cityController,
                    searchFocusNode: cityFocusNode,
                    onSearch: _onSearch,
                    hintText: 'select City',
                  ): 
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCity = null;  
                        cityFocusNode.requestFocus();
                        _cityController.clear();
                      });
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
                  ),
                  if (selectedCity != null) ...[
                    SizedBox(height: 20,),
                    Searchbox(
                    searchController: _apartmentController,
                    searchFocusNode: apartmentFocusNode,
                    onSearch: _onSearch,
                    hintText: 'Select Apartment',
                  )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchYourCommunityBloc, SearchYourCommunityState>(
        builder: (context, state) {
          print('-------------------$state');
          if ((state is SearchCityLoading || state is SearchApartmentLoading) && pageNo == 0) {
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
                    },
                  );
                },
              );
            } 
          } else if(state is SearchApartmentLoaded){
            if (state.apartments.isNotEmpty &&
              (apartments.isEmpty || apartments.last.id != state.apartments.last.id)) {
              apartments.addAll(state.apartments);
              hasMoreCities = state.apartments.length == pageSize;
            }
            if (apartments.isEmpty && selectedCity != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Apartment not found, for any queries contact us."),
                    SizedBox(height: 15,),
                    ShortButton(
                      label: "Contact Us", 
                      onPressed: (){
                            showContactUsModal(context);
                          },
                      style: txt_14_500.copyWith(color: AppColor.white1), 
                      color: AppColor.primaryColor2
                    )
                  ],
                ),
              );
            }
      //       WidgetsBinding.instance.addPostFrameCallback((_) {
      //       if (apartments.isEmpty) {
      //   _showNoResultsBottomSheet(context, selectedCity!, selectedCityId!, region!, selectedPostalCodes);
      // }}
            isLoadingMore = false;
             if (apartmentFocusNode.hasFocus) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: apartments.length + (isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == apartments.length) {
                    return const Center(child: AppLoader());
                  }
                  final apartment = apartments[index];
                  return ListTile(
                    title: Text(apartment.name),
                    onTap: () {
                      setState(() {
                        selectedApartment = apartment.name;
                        selectedApartmentId = apartment.id;
                      });
                      _apartmentController.text = selectedApartment!;
                      apartmentFocusNode.unfocus();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> 
                        ApartmentDetails(
                          apartmentName: selectedApartment!, 
                          apartmentId: selectedApartmentId!, 
                          city: selectedCity!, 
                          district: district!, 
                          state: region!, 
                          source: widget.source
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
      } else {
        apartments.clear();
        _loadApartments(query: query);
      }
    });
    // selectedCity == null ? _loadCities(query: query) : _loadApartments(query: query); 
  }

  void _showNoResultsBottomSheet(BuildContext context, String city, int cityId, String region, List<String> postalCodes) {
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> 
                      ApartmentOnboarding(city: city, cityId: cityId, region: region, postalCodes: postalCodes)
                    ));
                  },
                  style: txt_14_500.copyWith(color: AppColor.white))
            ],
          ),
        );
      },
    );
  }
}

