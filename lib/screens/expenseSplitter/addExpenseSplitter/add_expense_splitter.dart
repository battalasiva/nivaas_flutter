import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/data/provider/network/api/expenseSplitter/add_expense_splitter_datasource.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';
import 'package:nivaas/data/repository-impl/expenseSplitter/add_expense_splitter_repositoryimpl.dart';
import 'package:nivaas/domain/usecases/expenseSplitter/add_expense_splitter_usecase.dart';
import 'package:nivaas/screens/expenseSplitter/addExpenseSplitter/add_split_share.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/option_button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import 'bloc/add_expense_splitter_bloc.dart';

class AddExpenseSplitter extends StatefulWidget {
  final int apartmentId;
  const AddExpenseSplitter({super.key, required this.apartmentId});

  @override
  State<AddExpenseSplitter> createState() => _AddExpenseSplitterState();
}

class _AddExpenseSplitterState extends State<AddExpenseSplitter> {
  late String selectedOption, status;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedOption = 'Split Once';
    status = selectedOption;
  }

  void updateSelectedOption(String option) {
    setState(() {
      selectedOption = option;
      status = selectedOption;
    });
  }

    String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Expense Splitter'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                OptionButton(
                    label: 'Split Once',
                    selectedOption: selectedOption,
                    onPressed: updateSelectedOption),
                OptionButton(
                    label: 'Split Monthly',
                    selectedOption: selectedOption,
                    onPressed: updateSelectedOption)
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white2,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColor.grey),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            bill,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(
                                hintText: 'Enter title',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.black2),
                                ),
                              contentPadding: EdgeInsets.all(10)
                            ),
                            validator: validateTitle,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white2,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColor.grey),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            onlinePayment,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: amountController,
                            decoration: InputDecoration(
                                hintText: 'Enter Amount',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.black2),
                                ),
                              contentPadding: EdgeInsets.all(10)
                            ),
                            validator: validateAmount,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            CustomizedButton(
                label: 'Split Between Flats',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => AddExpenseSplitterBloc(AddExpenseSplitterUsecase(repository: 
                                    AddExpenseSplitterRepositoryimpl(datasource: AddExpenseSplitterDatasource(apiClient: 
                                    ApiClient())))),
                                  child: AddSplitShare(
                                      expenseTitle: titleController.text,
                                      splitType: selectedOption== 'Split Once' ? 'ONCE' :'MONTHLY',
                                      amount: double.parse(amountController.text),
                                      apartmentId: widget.apartmentId),
                                )));
                  }
                },
                style: txt_16_500.copyWith(color: AppColor.white1))
          ],
        ),
      ),
    );
  }
}
