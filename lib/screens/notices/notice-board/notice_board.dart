import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/gradients.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/notices/create-post/create_post.dart';
import 'package:nivaas/screens/notices/notice-board/bloc/notice_board_bloc.dart';
import 'package:nivaas/widgets/cards/noticeboard_card.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class NoticeBoard extends StatefulWidget {
  final int? apartmentId;
  final bool? isAdmin,isLeftSelected,isOwner;
  const NoticeBoard({super.key, this.apartmentId, this.isAdmin,this.isLeftSelected,this.isOwner});

  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> with WidgetsBindingObserver {
  int pageNo = 0;
  final int pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  List<dynamic> notices = [];
  bool isLoadingMore = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); 
    _fetchNotices();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshNotices();
    }
  }

  void _refreshNotices() {
    setState(() {
      pageNo = 0;
      notices.clear();
      hasMore = true;
    });
    _fetchNotices();
  }

  void _fetchNotices() {
    if (widget.apartmentId == null || isLoadingMore || !hasMore) return;

    setState(() {
      isLoadingMore = true;
    });

    context.read<NoticeBoardBloc>().add(
          FetchNoticeBoard(widget.apartmentId!, pageNo, pageSize),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !isLoadingMore &&
        hasMore) {
      pageNo++;
      _fetchNotices();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: const TopBar(
          title: 'Notice Board',
        ),
        body: BlocConsumer<NoticeBoardBloc, NoticeBoardState>(
          listener: (context, state) {
            if (state is NoticeBoardLoaded) {
              setState(() {
                notices.addAll(state.noticeBoard.data ?? []);
                hasMore = (state.noticeBoard.data ?? []).length == pageSize;
                isLoadingMore = false;
              });
            } else if (state is NoticeBoardError) {
              setState(() {
                isLoadingMore = false;
                hasMore = false;
              });
            }
          },
          builder: (context, state) {
            if (state is NoticeBoardLoading && notices.isEmpty) {
              return const Center(child: AppLoader());
            }
            if (notices.isEmpty) {
              return const Center(child: Text('Notices Not Available'));
            }
            return ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(bottom: getHeight(context) * 0.1),
              itemCount: notices.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == notices.length) {
                  return const Center(child: AppLoader());
                }
                final notice = notices[index];
                return Padding(
                  padding:
                       EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: NoticeboardCard(
                    date: notice.publishTime ?? '',
                    title: notice.title ?? '',
                    msg: notice.body ?? '',
                    role: notice.postedBy ?? '',
                    id: notice.id ?? 0,
                    apartmentId: widget.apartmentId!,
                    isAdmin: widget.isAdmin,
                    isLeftSelected:widget.isLeftSelected,
                    isOwner:widget.isOwner,
                    onNavigateCallback: () {
                      _refreshNotices();
                    },
                  ),
                );
              },
            );
          },
        ),
        bottomSheet: widget.isAdmin!
            ? Container(
                width: double.infinity,
                height: getHeight(context) * 0.1,
                decoration: BoxDecoration(
                  gradient: AppGradients.gradient1,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: TextButton(
                  onPressed: () {
                    if (widget.apartmentId != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreatePost(
                              apartmentId: widget.apartmentId!,
                              isAdmin:widget.isAdmin,
                              type: 'CREATE_NOTICE',
                              isLeftSelected: false,),
                        ),
                      ).then((result) {
                        if (result == true) {
                          _refreshNotices();
                        }
                      });
                    } else {
                      CustomSnackbarWidget(
                          context: context,
                          title: "Apartment Id not Available",
                          backgroundColor: AppColor.green);
                    }
                  },
                  child: Text(
                    'Create a Post',
                    style: txt_14_500.copyWith(color: AppColor.white1),
                  ),
                ),
              )
            : SizedBox());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }
}
