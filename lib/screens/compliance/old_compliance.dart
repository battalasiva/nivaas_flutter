import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/screens/compliance/bloc/compliance_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/short_button.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../widgets/elements/button.dart';
import '../../widgets/elements/points_list_form.dart';
import '../../widgets/elements/top_bar.dart';

class OldCompliance extends StatefulWidget {
  final bool isAdmin;
  final int apartmentId;
  const OldCompliance(
      {super.key, required this.isAdmin, required this.apartmentId});

  @override
  State<OldCompliance> createState() => _OldComplianceState();
}

class _OldComplianceState extends State<OldCompliance> {
  bool isEditable = false;

  final List<TextEditingController> _dosControllers = [];
  final List<TextEditingController> _dontsControllers = [];
  final List<String> _dosPoints = [];
  final List<String> _dontsPoints = [];
  final _formKeyDos = GlobalKey<FormState>();
  final _formKeyDonts = GlobalKey<FormState>();
  bool isEmptyData = true;

  @override
  void initState() {
    super.initState();
    _dosControllers.add(TextEditingController());
    _dontsControllers.add(TextEditingController());
    _dosPoints.add('');
    _dontsPoints.add('');
    context
        .read<ComplianceBloc>()
        .add(GetCompliancesEvent(apartmentId: widget.apartmentId));
  }

  @override
  void dispose() {
    for (var controller in _dosControllers) {
      controller.dispose();
    }
    for (var controller in _dontsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeControllers(List<String> dos, List<String> donts) {
    _dosControllers.clear();
    _dontsControllers.clear();

    for (var point in dos) {
      _dosControllers.add(TextEditingController(text: point));
      _dosPoints.add(point);
    }

    for (var point in donts) {
      _dontsControllers.add(TextEditingController(text: point));
      _dontsPoints.add(point);
    }
  }

  void _addDosNewPoint() {
    if (_formKeyDos.currentState?.validate() ?? false) {
      setState(() {
        _dosControllers.add(TextEditingController());
        _dosPoints.add('');
         print("Added new Do point, Total points: ${_dosPoints.length}");
      });
    }
  }

  void _addDontsNewPoint() {
    if (_formKeyDonts.currentState?.validate() ?? false) {
      setState(() {
        _dontsControllers.add(TextEditingController());
        _dontsPoints.add('');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(title: 'Compliance Details'),
        body: BlocBuilder<ComplianceBloc, ComplianceState>(
          builder: (context, state) {
            if (state is ComplianceLoading) {
              return AppLoader();
            } else if(state is ComplianceFailure){
              return Text(state.message);
            } else if(state is ComplianceListLoaded){
              if (state.details.dos.isEmpty && state.details.donts.isEmpty)  
              { 
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Do's", style: txt_14_600.copyWith(color: AppColor.black2),),
                      PointsListForm(
                        formKey: _formKeyDos, 
                        controllers: _dosControllers, 
                        labelText: 'Enter point', 
                        validationMessage: 'Please fill in the current point', 
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ShortButton(
                          label: 'Add Next Point', 
                          onPressed: _addDosNewPoint, 
                          style: txt_14_600.copyWith(color: AppColor.white1), 
                          color: AppColor.primaryColor1
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text("Dont's", style: txt_14_600.copyWith(color: AppColor.black2),),
                      PointsListForm(
                        formKey: _formKeyDonts, 
                        controllers: _dontsControllers, 
                        labelText: 'Enter point', 
                        validationMessage: 'Please fill in the current point', 
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ShortButton(
                          label: 'Add Next Point', 
                          onPressed: _addDontsNewPoint, 
                          style: txt_14_600.copyWith(color: AppColor.white1), 
                          color: AppColor.primaryColor1
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: CustomizedButton(
                          label: 'Save',
                          onPressed: (){
                            if (_dosControllers.isNotEmpty || _dontsControllers.isNotEmpty) {
                              List<String> dos = _dosControllers.map((controller) => controller.text).toList();
                              List<String> donts = _dontsControllers.map((controller) => controller.text).toList();
                              context.read<ComplianceBloc>().add(UpdateComplianceEvent(
                                apartmentId: widget.apartmentId, 
                                dos: dos, 
                                donts: donts)
                              );
                            }
                          },
                          style: txt_14_600.copyWith(color: AppColor.white1)
                        )
                      ),
                    ],
                  ),
                );
              } else {
                isEmptyData = false;
                if(isEditable) {
                  _initializeControllers(state.details.dos, state.details.donts);
                }
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.details.dos.isNotEmpty) ...[
                        Text(
                          "Do's",
                          style: txt_16_600.copyWith(color: AppColor.black2),
                        ),
                      // for (var i = 0; i < state.details.dos.length; i++) ...[
                      //   isEditable
                      //       ? 
                      //       PointsListForm(
                      //         formKey: _formKeyDos,
                      //         controllers: _dosControllers,
                      //         labelText: 'Edit point', 
                      //         validationMessage: 'Please fill in the current point',
                      //         onChanged: (value) {
                      //           setState(() {
                      //             state.details.dos[i] = value; 
                      //           });
                      //         },
                      //       )
                      //       : Padding(
                      //           padding: const EdgeInsets.symmetric(vertical: 5),
                      //           child: Text(
                      //             '${i+1}. ${state.details.dos[i]}',
                      //             style: txt_14_500.copyWith(color: AppColor.black1),
                      //           ),
                      //         ),
                      // ],
                      isEditable ? 
                        Form(
                          key: _formKeyDos,
                          child: Expanded(
                            child: ListView.builder(
                              itemCount: _dosControllers.length,
                              itemBuilder: (context, index) {
                                return TextFormField(
                                  controller: _dosControllers[index],
                                  onChanged: (value) {
                                    state.details.dos[index] = value; 
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter a valid point";
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                          ),
                        ) :
                        Expanded(
                          child: ListView.builder
                          (itemCount: state.details.dos.length,
                              itemBuilder: (context, index) {
                                    return ListTile(title: Text(state.details.dos[index]));
                              },),
                        ),
                      if(isEditable)
                      Center(
                        child: ShortButton(
                          label: 'Add Next Point', 
                          onPressed: _addDosNewPoint, 
                          style: txt_14_600.copyWith(color: AppColor.white1), 
                          color: AppColor.primaryColor1
                        ),
                      ),
                    ],
                    SizedBox(height: 50,),

                    if (state.details.donts.isNotEmpty) ...[
                      Text(
                        "Dont's",
                        style: txt_16_600.copyWith(color: AppColor.black2),
                      ),
                      for (var i = 0; i < state.details.donts.length; i++) ...[
                        isEditable
                            ? 
                            PointsListForm(
                              formKey: _formKeyDonts,
                              controllers: _dontsControllers,
                              labelText: 'Edit point', 
                              validationMessage: 'Please fill in the current point',
                              onChanged: (value) {
                                setState(() {
                                  state.details.donts[i] = value; 
                                });
                              },
                            )
                            : Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  '${i+1}. ${state.details.donts[i]}',
                                  style: txt_14_500.copyWith(color: AppColor.black1),
                                ),
                              ),
                      ],
                       if(isEditable)
                       Center(
                    child: ShortButton(
                      label: 'Add Next Point', 
                      onPressed: _addDontsNewPoint, 
                      style: txt_14_600.copyWith(color: AppColor.white1), 
                      color: AppColor.primaryColor1
                    ),
                  ),
                    ],
                    Spacer(),
                    Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: CustomizedButton(
                        label: 'Save',
                        onPressed: (){
                          if (_dosControllers.isNotEmpty || _dontsControllers.isNotEmpty) {
                            List<String> dos = _dosControllers.map((controller) => controller.text).toList();
                            List<String> donts = _dontsControllers.map((controller) => controller.text).toList();
                            context.read<ComplianceBloc>().add(UpdateComplianceEvent(
                              apartmentId: widget.apartmentId, 
                              dos: dos, 
                              donts: donts)
                            );
                          }
                        },
                        style: txt_14_600.copyWith(color: AppColor.white1)
                      )
                    ),
                  ],
                ),
              ); 
              } 
              
            } return SizedBox();
          },
        ),
        floatingActionButton: (widget.isAdmin )
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    isEditable = true;
                  });
                },
                child: Icon(Icons.edit),
                backgroundColor: Colors.blue,
              )
            : null,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndFloat
    );
  }
}
