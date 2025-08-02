import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/gradients.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/manageApartment/flats_model.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/add_owner_details_datasource.dart';
import 'package:nivaas/data/provider/network/api/manageApartment/onboard_requests_datasource.dart';
import 'package:nivaas/data/repository-impl/manageApartment/add_owner_details_repository_impl.dart';
import 'package:nivaas/data/repository-impl/manageApartment/onboard_requests_repository_impl.dart';
import 'package:nivaas/domain/usecases/manageApartment/add_owner_details_usecase.dart';
import 'package:nivaas/domain/usecases/manageApartment/onboard_requests_usecase.dart';
import 'package:nivaas/screens/manageApartment/addOwnerDetails/add_owner_details.dart';
import 'package:nivaas/screens/manageApartment/addOwnerDetails/bloc/add_owner_details_bloc.dart';
import 'package:nivaas/screens/manageApartment/flatMembers/flat_members.dart';
import 'package:nivaas/screens/manageApartment/onboardFlats/bloc/onboard_flats_bloc.dart';
import 'package:nivaas/screens/manageApartment/onboardFlats/onboard_flats.dart';
import 'package:nivaas/screens/manageApartment/pendingOnboardRequests/bloc/onboard_requests_bloc.dart';
import 'package:nivaas/screens/manageApartment/pendingOnboardRequests/pending_onboard_requests.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/short_button.dart';

import '../../core/constants/colors.dart';
import '../../data/models/manageApartment/flats_without_details_model.dart';
import '../../data/provider/network/api/manageApartment/onboardflats_datasource.dart';
import '../../data/provider/network/service/api_client.dart';
import '../../data/repository-impl/manageApartment/onboard_flats_repository_impl.dart';
import '../../domain/usecases/manageApartment/onboard_flats_usecase.dart';
import '../../widgets/elements/toggleButton.dart';
import 'bloc/all_flats_bloc.dart';

class ManageApt extends StatefulWidget {
  final int apartmentId;
  const ManageApt({super.key, required this.apartmentId});

  @override
  State<ManageApt> createState() => _ManageAptState();
}

class _ManageAptState extends State<ManageApt> {
  List<FlatsModel> allFlatsWithDetails = []; 
  List<String> allFlatNumbers = [];
  List<String> filteredFlatNumbers = [];
  TextEditingController searchController = TextEditingController();
  List<FlatsModel> flats = [];
  List<Data> flatsNumbersWithoutDetails =[];
  List<String> filterFlatNumbers = [];
  bool isLeftSelected = true;
  int currentPage= 0;
  int pageSize = 20;
  bool isLoading = false;
  bool hasMoreData = true;
  int totalPages = 0;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterFlats);
    _fetchFlats();
  }

  void _fetchFlats() {
    if (isLeftSelected) {
      context.read<AllFlatsBloc>().add(GetFlatDetailsEvent(apartmentId: widget.apartmentId));
    } else {
      if (isLoading || !hasMoreData) return; 
      setState(() {
        isLoading = true;
      });
      context.read<AllFlatsBloc>().add(
        GetFlatsWithoutDetailsEvent(apartmentId: widget.apartmentId, pageNo: currentPage, pageSize: pageSize
      ));
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      isLoading = true; 
      hasMoreData = true; 
      currentPage = 0;
    });

    _fetchFlats();

    setState(() {
      isLoading = false;
    });
  }


  void _filterFlats() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredFlatNumbers = allFlatNumbers
        .where((flat) => flat.toLowerCase().contains(query))
        .toList();
      filterFlatNumbers = flatsNumbersWithoutDetails
          .where((flat) =>
              flat.flatNo.toLowerCase().contains(query))
          .map((flat) => flat.flatNo)
          .toList();
    });
  }

  void _onToggleChanged(bool isLeft) {
    setState(() {
      isLeftSelected = isLeft;
      currentPage =0;
      hasMoreData = true;
      _fetchFlats();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterFlats);
    searchController.dispose();
    super.dispose();
  }

  Widget _buildFlatsWithDetails(List<FlatsModel> flats, String query) {
    allFlatNumbers = flats.where((flat) => flat.approved == true).map((flat) => flat.flatNo).toList();
    Map<String, int> flatNoCount = {};
    for (var flatNo in allFlatNumbers) {
      flatNoCount[flatNo] = (flatNoCount[flatNo] ?? 0) + 1;
    }
    List<MapEntry<String, int>> uniqueFlatNos = flatNoCount.entries.toList();
    List<MapEntry<String, int>> filteredUniqueFlatNos = uniqueFlatNos
        .where((entry) => entry.key.toLowerCase().contains(query))
        .toList();
    if (filteredUniqueFlatNos.isEmpty) {
      return Center(
        child: Text(
          'No Flats Available',
          style: txt_16_600.copyWith(color: AppColor.black2),
        ),
      );
    }
    return ListView.builder(
      itemCount: filteredUniqueFlatNos.length,
      itemBuilder: (context, index) {
        var flatNo = filteredUniqueFlatNos[index].key;
        var count = filteredUniqueFlatNos[index].value;
        return Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              color: AppColor.blueShade,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        shape: BoxShape.circle,
                        boxShadow: [],
                      ),
                      child: Opacity(opacity: 1.0, child: Image.asset(building)),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            flatNo,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: txt_16_700.copyWith(color: AppColor.black2),
                          ),
                          Row(
                            children: [
                              Image.asset(residents, width: 17, height: 17),
                              SizedBox(width: 5),
                              Text(
                                '$count ${count > 1 ? 'Members' : 'Member'}',
                                style: txt_12_400.copyWith(color: AppColor.black2.withOpacity(0.5)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ShortButton(
                      label: 'View Details',
                      onPressed: () {
                        final bloc = BlocProvider.of<AllFlatsBloc>(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: bloc,
                              child: FlatMembers(
                                apartmentId: widget.apartmentId,
                                flatNo: flatNo,
                              ),
                            ),
                          ),
                        ).then((result) {
                          if(result == 'success'){_fetchFlats();}
                        });
                      },
                      style: txt_12_500.copyWith(color: AppColor.white1),
                      color: AppColor.primaryColor1,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4)
          ],
        );
      },
    );
  }

  Widget _buildFlatsWithoutDetails(List<Data> flatsWithoutDetails, String query) {
    flatsNumbersWithoutDetails = flatsWithoutDetails;
    if (searchController.text.isEmpty) {
      filterFlatNumbers = flatsNumbersWithoutDetails.map((flat) => flat.flatNo).toList();
    }
    print('-----filter flat numbers: $filterFlatNumbers');
    if (filterFlatNumbers.isEmpty) {
      return Center(
        child: Text(
          'No Flats Available',
          style: txt_16_600.copyWith(color: AppColor.black2),
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: filterFlatNumbers.length,
            itemBuilder: (context, index) {
              final flatWithoutDetails = flatsNumbersWithoutDetails.firstWhere((flat) => flat.flatNo == filterFlatNumbers[index]);
              return Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: AppColor.blueShade,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: AppColor.white1,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(building),
                              ),
                              SizedBox(width: 15),
                              Text(
                                flatWithoutDetails.flatNo,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: txt_16_700.copyWith(color: AppColor.black2),
                              ),
                            ],
                          ),
                          ShortButton(
                            label: 'Add Details',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => AddOwnerDetailsBloc(
                                      AddOwnerDetailsUsecase(
                                        repository: AddOwnerDetailsRepositoryImpl(
                                          datasource: AddOwnerDetailsDatasource(apiClient: ApiClient())
                                        )
                                      )
                                    ),
                                    child: AddOwnerDetails(
                                      flatNo: flatWithoutDetails.flatNo,
                                      flatId: flatWithoutDetails.id,
                                      apartmentId: widget.apartmentId,
                                    ),
                                  ),
                                ),
                              ).then((_) {
                                _fetchFlats();
                              });
                            },
                            style: txt_12_500.copyWith(color: AppColor.white1),
                            color: AppColor.primaryColor1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 4)
                ],
              );
            },
          ),
        ),
        if (isLoading)
          Center(child: AppLoader()),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => onRefresh(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          child: AppBar(
            shape: RoundedRectangleBorder(
                // borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
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
              'Manage Apartment',
              style: txt_17_800.copyWith(color: AppColor.white1),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                child: _SearchFlat(searchController: searchController),
              ),
            ),
          ),
        ),
        body: 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                ToggleButtonWidget(
                  leftTitle: 'Flats with Details',
                  rightTitle: 'Flats without Details',
                  isLeftSelected: isLeftSelected,
                  onChange: _onToggleChanged
                ),
                SizedBox(height: 20,),
                BlocListener<AllFlatsBloc, AllFlatsState>(
                listener: (context, state) {
                  print('--------state $state');
                  if (state is AllFlatsError) {
                    print(state.message);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state is FlatDetailsLoaded) {
                    setState(() {
                      flats = state.flats;
                      allFlatsWithDetails = state.flats.where((flat) => flat.approved == true).toList();
                      filteredFlatNumbers = allFlatsWithDetails.map((flat) => flat.flatNo).toList();
                      print('filteredFlatNumbers - ---- $filteredFlatNumbers');
                    });
                  } else if (state is FlatWithoutDetailsLoaded) {
                     setState(() {
                      isLoading = false;
                      if (currentPage == 0) {
                        flatsNumbersWithoutDetails = state.flatsWithoutDetails.data;
                      } else {
                        flatsNumbersWithoutDetails.addAll(state.flatsWithoutDetails.data);
                      }
                      if (currentPage < state.flatsWithoutDetails.totalPages - 1) {
                        currentPage++;
                        hasMoreData = true;
                        _fetchFlats();
                      } else {
                        hasMoreData = false;
                      }
                    });
                  }
                },
                child: BlocBuilder<AllFlatsBloc, AllFlatsState>(
                  builder: (context, state) {
                    if (state is AllFlatsLoading) {
                      return Center(child: AppLoader());
                    }
                    print(allFlatsWithDetails);
                    return Expanded(
                      child: isLeftSelected
                          ? _buildFlatsWithDetails(allFlatsWithDetails, searchController.text)
                          : _buildFlatsWithoutDetails(flatsNumbersWithoutDetails, searchController.text),
                    );
                  },
                ),
              ),
              ],
            ),
          ),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              gradient: AppGradients.gradient1,
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => OnboardRequestsBloc(
                                          OnboardRequestsUsecase(
                                              repository:
                                                  OnboardRequestsRepositoryImpl(
                                                      datasource:
                                                          OnboardRequestsDatasource(
                                                              apiClient:
                                                                  ApiClient())))),
                                      child: PendingOnboardRequests(
                                        flats: flats,
                                        source: 'admin',
                                        isAdmin: true,
                                      ),
                                    )));
                        _fetchFlats();
                      },
                      child: Text(
                        'Onboard \nRequests',
                        textAlign: TextAlign.center,
                        style: txt_17_500.copyWith(color: AppColor.white1),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 60,
                    color: AppColor.white1,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => OnboardFlatsBloc(
                                          OnboardFlatsUsecase(
                                              repository:
                                                  OnboardFlatsRepositoryImpl(
                                                      onboardflatsDatasource:
                                                          OnboardflatsDatasource(
                                                              apiClient:
                                                                  ApiClient())))),
                                      child: OnboardFlats(
                                        apartmentId: widget.apartmentId,
                                      ),
                                    ))).then((_) {
                                _fetchFlats();
                              });
                      },
                      child: Text(
                        'Onboard \nNew Flat',
                        textAlign: TextAlign.center,
                        style: txt_17_500.copyWith(color: AppColor.white1),
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
      ),
    );
  }
}

class _SearchFlat extends StatelessWidget {
  final TextEditingController searchController;

  const _SearchFlat({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search Flat',
          hintStyle: txt_13_400.copyWith(color: AppColor.greyText1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
