import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/screens/expenseSplitter/addExpenseSplitter/add_expense_splitter.dart';
import 'package:nivaas/screens/expenseSplitter/expenseSplitterDetails/expense_splitter_details.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../widgets/elements/short_button.dart';
import '../../widgets/elements/top_bar.dart';
import 'bloc/expense_splitter_bloc.dart';

class ExpenseSplitter extends StatefulWidget {
  final int apartmentId;
  final bool? isAdmin;
  const ExpenseSplitter({super.key, required this.apartmentId, this.isAdmin});

  @override
  State<ExpenseSplitter> createState() => _ExpenseSplitterState();
}

class _ExpenseSplitterState extends State<ExpenseSplitter>
    with WidgetsBindingObserver {
  List<dynamic> _splitterDetails = [];
  Map<int, bool> _switchLoadingStates = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadSplitters();
  }

  void _loadSplitters() {
    context
        .read<ExpenseSplitterBloc>()
        .add(FetchExpenseSplittersListEvent(apartmentId: widget.apartmentId));
  }

  Future<void> _refreshSplitters() async{
    _loadSplitters();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadSplitters();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _toggleSwitch(int splitterId, bool newValue) {
    setState(() {
      _switchLoadingStates[splitterId] = true;
      _splitterDetails = _splitterDetails.map((detail) {
        if (detail.id == splitterId) {
          return detail.copyWith(enabled: newValue);
        }
        return detail;
      }).toList();
    });

    context.read<ExpenseSplitterBloc>().add(
          EnableExpenseSplitterEvent(
            splitterId: splitterId,
            isEnabled: newValue,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshSplitters,
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: TopBar(title: 'Expense Splitter'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: BlocConsumer<ExpenseSplitterBloc, ExpenseSplitterState>(
            listener: (context, state) {
              if (state is ExpenseSplitterListLoaded) {
                setState(() {
                  _splitterDetails = state.details;
                  _switchLoadingStates.clear();
                });
              } else if (state is EnableExpenseSplitterLoaded) {
                setState(() {
                  _switchLoadingStates[state.details.id] = false;
                  _splitterDetails = _splitterDetails.map((detail) {
                    if (detail.id == state.details.id) {
                      return state.details;
                    }
                    return detail;
                  }).toList();
                });
              } else if (state is ExpenseSplitterListFailure) {
                setState(() {
                  _switchLoadingStates.clear();
                });
                // CustomSnackbarWidget(
                //   context: context,
                //   title: 'Failed to update splitter status',
                //   backgroundColor: AppColor.orange,
                // );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Expense Splitters',
                      style: txt_14_600.copyWith(color: AppColor.black1)),
                  const SizedBox(height: 15),
                  if (state is ExpenseSplitterListLoading)
                    const AppLoader()
                  else if (_splitterDetails.isEmpty)
                    const Center(
                        child: Text('No Expense Splitters are available'))
                  else
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: _splitterDetails.length,
                                itemBuilder: (context, index) {
                                  final detail = _splitterDetails[index];
                                  final isLoading =
                                      _switchLoadingStates[detail.id] ?? false;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: detail.enabled
                                                  ? AppColor.blueShade
                                                  : AppColor.greyBackground,
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  detail.name,
                                                  style: txt_14_600.copyWith(
                                                      color: AppColor.black2),
                                                ),
                                                ShortButton(
                                                  label: 'View Details',
                                                  onPressed: () {
                                                    detail.enabled
                                                        ? showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            builder: (context) =>
                                                                ExpenseSplitterDetailsPopup(
                                                              details: detail,
                                                              isAdmin:
                                                                  widget.isAdmin,
                                                            ),
                                                          )
                                                        : CustomSnackbarWidget(
                                                            context: context,
                                                            title:
                                                                "Splitter is disabled!",
                                                            backgroundColor:
                                                                AppColor.orange,
                                                          );
                                                  },
                                                  style: txt_13_500.copyWith(
                                                      color: AppColor.white1),
                                                  color: AppColor.primaryColor1,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: 50,
                                          height: 30,
                                          child: Center(
                                            child: isLoading
                                                ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        AppColor.primaryColor2,
                                                      ),
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      if (!widget.isAdmin!) {
                                                        showSnackbarForNonAdmins(
                                                            context);
                                                      }
                                                    },
                                                    child: AbsorbPointer(
                                                      absorbing: widget.isAdmin!
                                                          ? false
                                                          : true,
                                                      child: CupertinoSwitch(
                                                        value: detail.enabled,
                                                        onChanged: (bool value) {
                                                          _toggleSwitch(
                                                              detail.id, value);
                                                        },
                                                        inactiveTrackColor:
                                                            AppColor
                                                                .greyBackground,
                                                        thumbColor: AppColor
                                                            .primaryColor2,
                                                        activeTrackColor: AppColor
                                                            .greyBackground,
                                                        inactiveThumbColor:
                                                            AppColor.grey,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: CustomizedButton(
                      label: 'Add Expense Splitter',
                      isReadOnly: !widget.isAdmin!,
                      onPressed: () {
                        widget.isAdmin ?? false
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddExpenseSplitter(
                                    apartmentId: widget.apartmentId,
                                  ),
                                ),
                              ).then((result) {
                                if (result == true) {
                                  _loadSplitters();
                                }
                              })
                            : CustomSnackbarWidget(
                                context: context,
                                title: "You don't have permission to add!",
                                backgroundColor: AppColor.orange,
                              );
                      },
                      style: txt_16_500.copyWith(color: AppColor.white1),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
