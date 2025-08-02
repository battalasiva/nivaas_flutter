import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/screens/gate-management/configuredVisitors/bloc/configured_visitors_bloc.dart';
import 'package:nivaas/screens/gate-management/configuredVisitors/configured_visitors_list.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../data/models/gateManagement/configured_visitor_invites_model.dart';

class ConfiguredVisitors extends StatefulWidget {
  final int apartmentId, flatId;
  const ConfiguredVisitors({super.key, required this.apartmentId, required this.flatId});

  @override
  State<ConfiguredVisitors> createState() => _ConfiguredVisitorsState();
}

class _ConfiguredVisitorsState extends State<ConfiguredVisitors> {
  bool showAll = false;
  final int pageSize = 20;
  int pageNo =0;
  List<VisitorRequest> allVisitors = [];

  @override
  void initState() {
    super.initState();
    _fetchVisitors();
    pageNo =0;
  }
  void _fetchVisitors(){
    context.read<ConfiguredVisitorsBloc>().add(FetchConfiguredVisitorsEvent(
      apartmentId: widget.apartmentId, flatId: widget.flatId, 
      pageNo: pageNo, pageSize: pageSize,
    ));
  }
  String getInitials(String text) {
    List<String> words = text.split(' ');

    if (words.length > 1) {
      return words[0][0].toUpperCase() + words[1][0].toUpperCase();
    } else {
      return words[0][0].toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfiguredVisitorsBloc, ConfiguredVisitorsState>(
      builder: (context, state) {
        print(state);
        if(state is ConfiguredVisitorsLoading){
          return SizedBox();
        }else if (state is ConfiguredVisitorsFailure) {
          print(state.message);
          // return Center(child: Text(state.message));
        } else if (state is ConfiguredVisitorsLoaded) {
          if(pageNo==0 && state.details.content.isEmpty){
            return SizedBox();
          }
          if (pageNo ==0) {
            allVisitors = state.details.content;
          }else{
            allVisitors.addAll(state.details.content);
          }
          if (pageNo < state.details.totalPages - 1){
            pageNo++;
            print('pageNo --------- $pageNo');
            _fetchVisitors();
          }
          final visitorsList = allVisitors.expand((item) => item.visitors).toList();
          final displayList = visitorsList.take(4).toList();
          return Row(
            children: [
              SizedBox(
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    final visitorName = displayList[index].name;
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColor.white,
                            child: Text(getInitials(visitorName)),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            (visitorName.length > 8) ? '${visitorName.substring(0, 5)}...'
                                                      : visitorName,
                            style: txt_12_500.copyWith(color: AppColor.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (visitorsList.length > 4)
                Padding(
                  padding: const EdgeInsets.only(left: 12,),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfiguredVisitorsList(details: allVisitors,),
                            ),
                          ),
                    child: Column(
                      children: [
                        Image.asset(viewMore),
                        SizedBox(height: 8,),
                        Text('View', style: txt_12_500.copyWith(color: AppColor.white),),
                      ],
                    ),
                  ),
                ),
            ],
          );
        }
        return Text('');
      },
    );
  }
}

