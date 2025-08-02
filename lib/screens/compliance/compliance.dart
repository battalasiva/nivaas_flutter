import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/screens/compliance/add_compliance.dart';
import 'package:nivaas/screens/compliance/bloc/compliance_bloc.dart';
import 'package:nivaas/screens/compliance/update_compliance.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../widgets/elements/button.dart';
import '../../widgets/elements/top_bar.dart';

class Compliance extends StatefulWidget {
  final bool isAdmin;
  final int apartmentId;
  const Compliance(
      {super.key, required this.isAdmin, required this.apartmentId});

  @override
  State<Compliance> createState() => _ComplianceState();
}

class _ComplianceState extends State<Compliance> {

  @override
  void initState() {
    super.initState();
    context
        .read<ComplianceBloc>()
        .add(GetCompliancesEvent(apartmentId: widget.apartmentId));
  }
  void _fetchCompliance(){
    context
      .read<ComplianceBloc>()
      .add(GetCompliancesEvent(apartmentId: widget.apartmentId));
  }

  Future<void> _refreshCompliance() async{
    _fetchCompliance();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshCompliance,
      child: Scaffold(
        backgroundColor: AppColor.white,
          appBar: TopBar(title: 'Compliance Details'),
          body: BlocBuilder<ComplianceBloc, ComplianceState>(
            builder: (context, state) {
              if (state is ComplianceLoading) {
                return AppLoader();
              } else if(state is ComplianceFailure){
                print(state.message);
                return Center(child: Text(state.message));
              } else if(state is ComplianceListLoaded){
                  if (state.details.dos.isEmpty && state.details.donts.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                      child: Column(
                        children: [
                          Center(child: Text("No Compliances")),
                          Spacer(),
                          if(widget.isAdmin)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
                            child: CustomizedButton(
                              label: 'Add Compliance', 
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>AddCompliance(apartmentId: widget.apartmentId,) 
                                )).then((result) {
                              if (result == true) {
                                _fetchCompliance();
                              }
                            });
                              }, 
                              style: txt_13_500.copyWith(color: AppColor.white1)
                            ),
                          )
                        ],
                      ),
                    );
                  } 
      
                  List<String> dos = List<String>.from(state.details.dos);
                  List<String> donts = List<String>.from(state.details.donts);
                  return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Do's",
                        style: txt_17_800.copyWith(color: AppColor.black2),
                      ),
                      SizedBox(height: 10),
                      if (dos.isNotEmpty)
                        InkWell(
                          onTap: () {
                            if(widget.isAdmin) {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> 
                              UpdateCompliance(apartmentId: widget.apartmentId, dos: dos,donts: donts,)
                            )).then((result) {
                              if (result == true) {
                                _fetchCompliance();
                              }
                            });
                            }
                          },
                          child: Container(
                            color: AppColor.blueShade,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: dos.length,
                              itemBuilder: (context, index) {
                                if (dos.length == 1 && dos[index] == "") {
                                  return Center(child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text("No points available in Do's section."),
                                  ));
                                }
                                return ListTile(
                                  title: Text('${index + 1}. ${dos[index]}'),
                                );
                              },
                            ),
                          ),
                        )
                      else
                        Text("No points available in Do's section."),
                      SizedBox(height: 20),
                      Text(
                        "Don'ts",
                        style: txt_17_800.copyWith(color: AppColor.black2),
                      ),
                      SizedBox(height: 10),
                      if (donts.isNotEmpty)
                        InkWell(
                          onTap: () {
                            if(widget.isAdmin) {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> 
                              UpdateCompliance(apartmentId: widget.apartmentId, dos: dos,donts: donts,)
                            )).then((result) {
                              if (result == true) {
                                _fetchCompliance();
                              }
                            });
                            }
                          },
                          child: Container(
                            color: AppColor.blueShade,
                            padding: EdgeInsets.all(6),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: donts.length,
                              itemBuilder: (context, index) {
                                if (donts.length == 1 && donts[index] == "") {
                                  return Center(child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text("No points available in Don'ts section."),
                                  ));
                                }
                                return ListTile(
                                  title: Text('${index + 1}. ${donts[index]}'),
                                );
                              },
                            ),
                          ),
                        )
                      else
                        Text("No points available in Don'ts section."),
                    ],
                  ),
                );
              } return SizedBox();
            },
          ),
      ),
    );
  }
}
