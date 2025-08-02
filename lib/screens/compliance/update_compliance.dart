import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../widgets/elements/button.dart';
import '../../widgets/elements/top_bar.dart';
import 'bloc/compliance_bloc.dart';

class UpdateCompliance extends StatefulWidget {
  final int apartmentId;
  final List<String> dos;
  final List<String> donts;
  const UpdateCompliance({super.key, required this.apartmentId, required this.dos, required this.donts});

  @override
  State<UpdateCompliance> createState() => _UpdateComplianceState();
}

class _UpdateComplianceState extends State<UpdateCompliance> {
  List<TextEditingController> dosControllers = [TextEditingController()];
  List<TextEditingController> dontsControllers = [TextEditingController()];
  List<Widget> dosTextFields = [];
  List<Widget> dontsTextFields = [];
  final GlobalKey<FormState> _dosformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dontsFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dosControllers = widget.dos.map((e) => TextEditingController(text: e)).toList();
    dontsControllers = widget.donts.map((e) => TextEditingController(text: e)).toList();
    _updateDosTextFields();
    _updateDontsTextFields();
  }

  void _updateDosTextFields() {
    dosTextFields.clear();
    for (int i = 0; i < dosControllers.length; i++) {
      dosTextFields.add(
        ReorderableItem(
          key: ValueKey(i),
          controller: dosControllers[i],
          onDelete: () => _deleteDosTextField(i),
          onAdd: () => _addDosTextField(),
          isOnlyOneTextField: dosControllers.length == 1,
          isLastTextField: i == dosControllers.length - 1,
        ),
      );
    }
  }

  void _updateDontsTextFields() {
    dontsTextFields.clear();
    for (int i = 0; i < dontsControllers.length; i++) {
      dontsTextFields.add(
        ReorderableItem(
          key: ValueKey(i),
          controller: dontsControllers[i],
          onDelete: () => _deleteDontsTextField(i),
          onAdd: () => _addDontsTextField(),
          isOnlyOneTextField: dontsControllers.length == 1,
          isLastTextField: i == dontsControllers.length - 1,
        ),
      );
    }
  }

  void _addDosTextField() {
    if (_dosformKey.currentState?.validate() ?? false) {
      setState(() {
        dosControllers.add(TextEditingController());
        _updateDosTextFields();
      });
    }
  }

  void _deleteDosTextField(int index) {
    setState(() {
      dosControllers.removeAt(index);
      _updateDosTextFields();
    });
  }

  void _addDontsTextField() {
    if (_dontsFormKey.currentState?.validate() ?? false) {
      setState(() {
        dontsControllers.add(TextEditingController());
        _updateDontsTextFields();
      });
    }
  }

  void _deleteDontsTextField(int index) {
    setState(() {
      dontsControllers.removeAt(index);
      _updateDontsTextFields();
    });
  }
   bool validateForm() {
    bool isValid = true;

    for (int i = 1; i < dosControllers.length; i++) {
      if (dosControllers[i].text.isEmpty) {
        isValid = false;
        break;
      }
    }
    for (int i = 1; i < dontsControllers.length; i++) {
      if (dontsControllers[i].text.isEmpty) {
        isValid = false;
        break;
      }
    }
    return isValid;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Update Compliance'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Form(
                    key: _dosformKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Do's",
                          style: txt_14_700.copyWith(color: AppColor.black2),
                        ),
                        ReorderableListView(
                          shrinkWrap: true,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final controller = dosControllers.removeAt(oldIndex);
                              dosControllers.insert(newIndex, controller);
                              _updateDosTextFields();
                            });
                          },
                          children: dosTextFields,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12,),
                  Form(
                    key: _dontsFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Don'ts",
                          style: txt_14_700.copyWith(color: AppColor.black2),
                        ),
                        ReorderableListView(
                          shrinkWrap: true,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final controller =
                                  dontsControllers.removeAt(oldIndex);
                              dontsControllers.insert(newIndex, controller);
                              _updateDontsTextFields();
                            });
                          },
                          children: dontsTextFields,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if(widget.dos.length <4 && widget.donts.length < 4)
                SizedBox(height: 100,),
              BlocListener<ComplianceBloc, ComplianceState>(
                listener: (context, state) {
                  if (state is ComplianceUpdated) {
                    Navigator.of(context).pop(true);
                  } else if(state is ComplianceFailure){
                    print(state.message);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60, top: 50),
                  child: CustomizedButton(
                      label: 'Save',
                      onPressed: () {
                        if (validateForm()) {
                        List<String> dos = dosControllers
                            .map((controller) => controller.text)
                            .toList();
                        List<String> donts = dontsControllers
                            .map((controller) => controller.text)
                            .toList();

                        context.read<ComplianceBloc>().add(
                              UpdateComplianceEvent(
                                apartmentId: widget.apartmentId,
                                dos: dos,
                                donts: donts,
                              ),
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill in all fields.')),
                        );
                      }
                    },
                      style: txt_14_500.copyWith(color: AppColor.white1)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReorderableItem extends StatelessWidget {
  final Key key;
  final TextEditingController controller;
  final VoidCallback onDelete;
  final VoidCallback onAdd;
  final bool isOnlyOneTextField;
  final bool isLastTextField;

  ReorderableItem(
      {required this.key,
      required this.controller,
      required this.onDelete,
      required this.onAdd,
      required this.isOnlyOneTextField,
      required this.isLastTextField
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListTile(
        key: key,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please fill in the current point';
                  }
                  return null;
                },
              ),
            ),
            if (!isOnlyOneTextField)
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: onDelete,
                padding: EdgeInsets.zero,
              ),
            if(isLastTextField)
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: onAdd,
                padding: EdgeInsets.zero,
              ),
          ],
        ),
      ),
    );
  }
}