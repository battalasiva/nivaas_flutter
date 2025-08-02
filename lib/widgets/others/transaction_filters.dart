import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/CustomDatePicker.dart';
import 'package:nivaas/widgets/elements/button.dart';

class TransactionFilters extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;

  const TransactionFilters({Key? key, required this.onApplyFilters})
      : super(key: key);

  @override
  _TransactionFiltersState createState() => _TransactionFiltersState();
}

class _TransactionFiltersState extends State<TransactionFilters> {
  final List<String> mainFilters = ['Bill Type', 'Date'];
  final Map<String, List<Map<String, String>>> filterOptions = {
    'Bill Type': [
      {'label': 'Bill Payment', 'value': 'BILL', 'type': 'transactionType'},
      {'label': 'Debit', 'value': 'DEBIT', 'type': 'transactionType'},
      {'label': 'Credit', 'value': 'CREDIT', 'type': 'transactionType'},
    ],
    'Date': [
      {'label': 'Date', 'value': 'Date', 'type': 'transactionDate'},
    ],
  };

  String? selectedMainFilter;
  Map<String, List<String>> selectedSubFilters = {};
  String? selectedDate = '';

  @override
  void initState() {
    super.initState();
    selectedMainFilter = mainFilters.first;
    for (var filter in mainFilters) {
      selectedSubFilters[filter] = [];
    }
  }

  void toggleSubFilter(String mainFilter, String value) {
    setState(() {
      if (selectedSubFilters[mainFilter]!.contains(value)) {
        selectedSubFilters[mainFilter]!.remove(value);
      } else {
        selectedSubFilters[mainFilter]!.add(value);
      }
    });
  }

  void onDateSelected(String date) {
    setState(() {
      selectedDate = date;
      selectedSubFilters['Date'] = [date];
    });
  }

  Map<String, dynamic> formatFilters() {
    List<Map<String, String>> formattedFilters = [];

    selectedSubFilters.forEach((mainFilter, values) {
      final type = filterOptions[mainFilter]?[0]['type'];

      for (var value in values) {
        formattedFilters.add({
          'field': type!,
          'value': value,
          'operator': 'EQUAL_TO',
        });
      }
    });
    return {'filters': formattedFilters};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: const Text('Filters'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var filter in mainFilters) {
                  selectedSubFilters[filter] = [];
                  selectedDate = '';
                }
              });
            },
            child: Text(
              'Clear All',
              style: TextStyle(color: AppColor.black),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width * 0.35,
            color: AppColor.white,
            child: ListView.builder(
              itemCount: mainFilters.length,
              itemBuilder: (context, index) {
                final filter = mainFilters[index];
                final isSelected = selectedMainFilter == filter;
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMainFilter = filter;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColor.grey : AppColor.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        filter,
                        style: txt_17_500.copyWith(
                          color: isSelected ? AppColor.white : AppColor.black,
                        ),
                      ),
                    ));
              },
            ),
          ),
          Expanded(
            child: Container(
              color: AppColor.white,
              padding: const EdgeInsets.all(16.0),
              child: selectedMainFilter != null
                  ? ListView.builder(
                      itemCount: filterOptions[selectedMainFilter]!.length,
                      itemBuilder: (context, index) {
                        final subFilter =
                            filterOptions[selectedMainFilter]![index];

                        if (selectedMainFilter == 'Date') {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              CustomDatePicker(
                                format: 'YYYY-MM',
                                onDateSelected: onDateSelected,
                                minDate: DateTime(
                                    2023, 1, 1), 
                                showYearMonth:true,
                                initialDate: selectedDate,
                              ),
                            ],
                          );
                        } else {
                          final isSelected =
                              selectedSubFilters[selectedMainFilter]!
                                  .contains(subFilter['value']);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColor.grey1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                value: isSelected,
                                activeColor: AppColor.blue,
                                onChanged: (value) {
                                  toggleSubFilter(
                                      selectedMainFilter!, subFilter['value']!);
                                },
                              ),
                              title: Text(subFilter['label']!),
                              onTap: () {
                                toggleSubFilter(
                                    selectedMainFilter!, subFilter['value']!);
                              },
                            ),
                          );
                        }
                      },
                    )
                  : const Center(
                      child: Text('Select a filter to view options'),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50, right: 20, left: 20),
        child: CustomizedButton(
          label: 'Apply Filters',
          style: txt_11_500.copyWith(color: AppColor.white),
          onPressed: () {
            final formattedFilters = formatFilters();
            widget.onApplyFilters(formattedFilters);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
