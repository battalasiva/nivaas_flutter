import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/expenseSplitter/add_expense_splitter_model.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../data/models/search-community/flat_list_model.dart';
import '../../search-community/apartment_details/bloc/flat_bloc.dart';
import 'bloc/add_expense_splitter_bloc.dart';

class AddSplitShare extends StatefulWidget {
  final String expenseTitle, splitType;
  final double amount;
  final int apartmentId;
  const AddSplitShare(
      {super.key,
      required this.expenseTitle,
      required this.splitType,
      required this.amount,
      required this.apartmentId});

  @override
  State<AddSplitShare> createState() => _AddSplitShareState();
}

class _AddSplitShareState extends State<AddSplitShare>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int pageNo = 0;
  final int pageSize = 20;
  late List<TextEditingController> _percentageControllers;
  late List<FlatContent> _flats;
  String tabText = 'By Share';

  @override
  void initState() {
    super.initState();
    _percentageControllers = [];
    _flats = [];
    _fetchFlats();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 0) {
          tabText = 'By Share';
          _setEqualValues();
        } else if (_tabController.index == 1) {
          tabText = 'By Percentage';
        } else {
          tabText = 'By Share';
        }
      });
    });
  }

  void _fetchFlats() {
    context
        .read<FlatBloc>()
        .add(FetchFlats('Owner', widget.apartmentId, pageNo, pageSize));
  }

  void _setEqualValues() {
    for (var controller in _percentageControllers) {
      controller.text = '1';
    }
  }

  void _validate() {
    if (_tabController.index == 1) {
      double totalPercentage = 0;
      for (var controller in _percentageControllers) {
        totalPercentage += double.tryParse(controller.text) ?? 0;
      }

      if (totalPercentage != 100) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Total percentage must be 100'),
            backgroundColor: AppColor.red,
          ),
        );
        return;
      }
    }
    List<SplitDetail> splitDetails = [];
  for (int i = 0; i < _flats.length; i++) {
    double splitRatio = 0.0;
    if (_tabController.index == 1) {
      splitRatio = double.tryParse(_percentageControllers[i].text) ?? 0.0;
    } else if (_tabController.index == 2) {
      splitRatio = double.tryParse(_percentageControllers[i].text) ?? 0; 
    }else{
      splitRatio = 1;
    }

    splitDetails.add(SplitDetail(
    flatId: _flats[i].id,
    splitRatio: splitRatio,
  ));
  }
  final details = AddExpenseSplitterModel(
    apartmentId: widget.apartmentId, 
    amount: widget.amount, 
    splitSchedule: widget.splitType, 
    enabled: true, splitterName: widget.expenseTitle,
    splitMethod: _tabController.index == 1 ? "PERCENTAGE" 
      : _tabController.index == 0 ? "EQUALLY" : "RATIO",
    splitDetails: splitDetails
  );
    context.read<AddExpenseSplitterBloc>().add(CreateExpenseSplitterEvent(
     splitDetails: details
    ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _percentageControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: widget.expenseTitle),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Equally',
                ),
                Tab(
                  text: 'By Percentage',
                ),
                Tab(
                  text: 'By Share',
                )
              ],
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(color: AppColor.primaryColor1, width: 3),
                  insets: const EdgeInsets.symmetric(horizontal: 100)),
            ),
            Flexible(
              child: TabBarView(
                  controller: _tabController,
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25,
                                right: _tabController.index == 1 ? 10 : 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('Flat Number'), Text(tabText)],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          BlocBuilder<FlatBloc, FlatState>(
                            builder: (context, state) {
                              if (state is FlatLoading) {
                                return AppLoader();
                              } else if (state is FlatFailure) {
                                print(state.message);
                                return Center(child: Text(state.message));
                              } else if (state is FlatLoaded) {
                                if (pageNo == 0) {
                                  _flats = state.flats.content;
                                } else {
                                  _flats.addAll(state.flats.content);
                                }
                                _percentageControllers = List.generate(
                                  _flats.length,
                                  (index) => TextEditingController(),
                                );
                                if (pageNo < state.flats.totalPages - 1) {
                                  pageNo++;
                                  _fetchFlats();
                                }
                                if (_tabController.index == 0) {
                                  _setEqualValues();
                                }
                                return Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _flats.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: AppColor.blueShade),
                                            padding: EdgeInsets.all(15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(_flats[index].flatNo),
                                                Spacer(),
                                                Container(
                                                  width: 85,
                                                  child: DetailsField(
                                                    controller:
                                                        _percentageControllers[
                                                            index],
                                                    hintText: '0',
                                                    isDecimals: true,
                                                    condition:
                                                        _tabController.index ==
                                                                0
                                                            ? false
                                                            : true,
                                                  ),
                                                ),
                                                SizedBox(width: 4,),
                                                if(_tabController.index == 1)
                                                Text('%')
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BlocListener<AddExpenseSplitterBloc, AddExpenseSplitterState>(
                            listener: (context, state) {
                              print(state);
                              if (state is AddExpenseSplitterFailure) {
                                print(state.message);
                                Text(state.message);
                              } else if(state is AddExpenseSplitterSuccess){
                                Navigator.pop(context);
                                Navigator.of(context).pop(true);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CustomizedButton(
                                  label: 'Save',
                                  onPressed: _validate,
                                  style: txt_14_600.copyWith(
                                      color: AppColor.white1)),
                            ),
                          )
                        ],
                      ),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
