import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/search-community/flat_list_model.dart';
import 'package:nivaas/screens/search-community/apartment_details/bloc/flat_bloc.dart';
import 'package:nivaas/widgets/cards/FlatReadingCard.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class AddPreviousMeterReading extends StatefulWidget {
  final int? apartmentId;

  const AddPreviousMeterReading({Key? key, this.apartmentId}) : super(key: key);

  @override
  State<AddPreviousMeterReading> createState() =>
      _AddPreviousMeterReadingState();
}

class _AddPreviousMeterReadingState extends State<AddPreviousMeterReading> {
  final Map<int, String> _readings = {};
  int pageNo = 0, pageSize = 9;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  List<FlatContent> flats = [];
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    _fetchFlats();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !isLoadingMore &&
          pageNo < totalPages - 1) {
        _loadMoreFlats();
      }
    });

    Future.delayed(const Duration(seconds: 5), () {
      CustomSnackbarWidget(
        context: context,
        title: '0 will be posted if you don’t enter a previous reading',
        backgroundColor: AppColor.primaryColor1,
      );
    });
  }

  void _fetchFlats() {
    context
        .read<FlatBloc>()
        .add(FetchFlats('', widget.apartmentId ?? 0, pageNo, pageSize));
  }

  void _loadMoreFlats() {
    setState(() {
      isLoadingMore = true;
      if (pageNo == 0) {
        pageNo++;
        context
            .read<FlatBloc>()
            .add(FetchFlats('', widget.apartmentId ?? 0, pageNo, pageSize));
      } else {
        pageNo = totalPages - 1;
        context.read<FlatBloc>().add(FetchFlats(
            '', widget.apartmentId ?? 0, pageNo, pageSize * totalPages));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Add Meter Readings'),
      body: Padding(
        padding: EdgeInsets.all(getWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Flat Numbers',
                    style: txt_14_600.copyWith(color: AppColor.black1)),
                Text('Previous Meter Reading',
                    style: txt_14_600.copyWith(color: AppColor.black1)),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocListener<FlatBloc, FlatState>(
                listener: (context, state) {
                  if (state is FlatLoaded) {
                    setState(() {
                      flats.addAll(state.flats.content);
                      totalPages = state.flats.totalPages;
                      isLoadingMore = false;
                    });
                  } else if (state is FlatFailure) {
                    setState(() => isLoadingMore = false);
                  }
                },
                child: BlocBuilder<FlatBloc, FlatState>(
                  builder: (context, state) {
                    if (state is FlatLoading && flats.isEmpty) {
                      return const Center(child: AppLoader());
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: flats.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == flats.length && isLoadingMore) {
                          return const Center(
                              child: AppLoader());
                        }
                        final flat = flats[index];
                        return FlatReadingCard(
                          flatNumber: flat.flatNo,
                          initialValue: _readings[flat.id] ?? '',
                          onChanged: (value) {
                            setState(() => _readings[flat.id] = value);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: CustomizedButton(
          label: 'Save',
          style: txt_11_500.copyWith(color: AppColor.white),
          onPressed: () {
            final result = flats.map((flat) {
              return {
                'flatId': flat.id,
                'readingValue': int.tryParse(_readings[flat.id] ?? '0') ??
                    0, 
              };
            }).toList();
            Navigator.pop(context, result);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
