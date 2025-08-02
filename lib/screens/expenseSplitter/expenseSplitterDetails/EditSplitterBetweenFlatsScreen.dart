import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/core/validations/validations.dart';
import 'package:nivaas/data/models/expenseSplitter/expense_splitters_list_model.dart';
import 'package:nivaas/screens/expenseSplitter/expenseSplitterDetails/bloc/expense_splitter_details_bloc.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/details_field.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class SplitterFlatsEditScreen extends StatefulWidget {
  final ExpenseSplittersListModel details;
  final TextEditingController nameController;
  final TextEditingController amountController;
  final String splitSchedule;

  const SplitterFlatsEditScreen({
    super.key,
    required this.details,
    required this.nameController,
    required this.amountController,
    required this.splitSchedule,
  });

  @override
  State<SplitterFlatsEditScreen> createState() =>
      _SplitterFlatsEditScreenState();
}

class _SplitterFlatsEditScreenState extends State<SplitterFlatsEditScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<TextEditingController> _percentageControllers;

  @override
  void initState() {
    super.initState();

    int initialTabIndex = widget.details.splitMethod == "PERCENTAGE"
        ? 1
        : widget.details.splitMethod == "RATIO"
            ? 2
            : 0;

    _tabController =
        TabController(length: 3, vsync: this, initialIndex: initialTabIndex);

    _percentageControllers = List.generate(
      widget.details.splitDetails.length,
      (index) => TextEditingController(),
    );

    _populateControllers(
        initialTabIndex); 

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _populateControllers(_tabController.index);
      }
    });
  }

  void _populateControllers(int tabIndex) {
    for (int i = 0; i < widget.details.splitDetails.length; i++) {
      final flat = widget.details.splitDetails[i];
      String value = '';

      if (tabIndex == 0) {
        value = (flat.splitRatio == null || flat.splitRatio == 0 || flat.splitRatio > 1)
            ? '1'
            : flat.splitRatio.toString();
      } else if (tabIndex == 1 && widget.details.splitMethod == "PERCENTAGE") {
        value = flat.splitRatio.toString();
      } else if (tabIndex == 2 && widget.details.splitMethod == "RATIO") {
        value = flat.splitRatio.toString();
      }

      _percentageControllers[i].text = value;
    }

    setState(() {});
  }

  List<Map<String, dynamic>> _getUpdatedSplitDetails() {
    return List.generate(widget.details.splitDetails.length, (i) {
      final detail = widget.details.splitDetails[i];
      return {
        "id": detail.id,
        "flatId": detail.flatId,
        "splitRatio": double.tryParse(_percentageControllers[i].text) ?? 0.0,
        "flatNo": detail.flatNo,
      };
    });
  }

  void submitData() {
    String? validationMessage = validateSplitData(
      splitterName: widget.nameController.text,
      amount: widget.amountController.text,
      percentageControllers: _percentageControllers,
    );

    if (validationMessage != null) {
      CustomSnackbarWidget(
        context: context,
        title: validationMessage,
        backgroundColor: AppColor.red,
      );
      return;
    }

    final payload = {
      "apartmentId": widget.details.apartmentId,
      "amount": double.parse(widget.amountController.text),
      "splitSchedule": widget.splitSchedule,
      "enabled": true,
      "splitterName": widget.nameController.text,
      "splitMethod": _tabController.index == 0
          ? "EQUALLY"
          : _tabController.index == 1
              ? "PERCENTAGE"
              : "RATIO",
      "splitDetails": _getUpdatedSplitDetails(),
    };

    context.read<ExpenseSplitterDetailsBloc>().add(
          SubmitEditSplitterDetails(widget.details.id, payload),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Edit Splitter'),
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Equally'),
                Tab(text: 'By Percentage'),
                Tab(text: 'By Share')
              ],
              indicatorColor: AppColor.primaryColor1,
            ),
            SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(3, (tabIndex) {
                  return ListView.builder(
                    itemCount: widget.details.splitDetails.length,
                    itemBuilder: (context, i) {
                      final flat = widget.details.splitDetails[i];
                      if (_tabController.index == tabIndex) {
                        if (tabIndex == 0) {
                        } else if (tabIndex == 1 &&
                            widget.details.splitMethod == "PERCENTAGE") {
                        } else if (tabIndex == 2 &&
                            widget.details.splitMethod == "RATIO") {
                        }
                      }

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColor.blueShade,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(flat.flatNo),
                            Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: DetailsField(
                                    controller: _percentageControllers[i],
                                    hintText: '1.0',
                                    isDecimals: true,
                                  ),
                                ),
                                if (_tabController.index == 1)
                                  SizedBox(width: 4),
                                if (_tabController.index == 1) Text('%'),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
            BlocConsumer<ExpenseSplitterDetailsBloc,
                ExpenseSplitterDetailsState>(
              listener: (context, state) {
                if (state is EditSplitterDetailsSuccess) {
                  CustomSnackbarWidget(
                    context: context,
                    title: "Updated successfully!",
                    backgroundColor: AppColor.green,
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else if (state is EditSplitterDetailsFailure) {
                  CustomSnackbarWidget(
                    context: context,
                    title: state.message ?? "Something went wrong!",
                    backgroundColor: AppColor.red,
                  );
                }
              },
              builder: (context, state) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: CustomizedButton(
                    label: state is EditSplitterDetailsLoading
                        ? "Saving..."
                        : "Save",
                    onPressed:
                        state is EditSplitterDetailsLoading ? () {} : submitData,
                    style: txt_14_600.copyWith(color: AppColor.white1),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
