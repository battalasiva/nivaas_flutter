import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/screens/notices/notifications/bloc/notifications_bloc.dart';
import 'package:nivaas/screens/notices/notifications/bloc/notifications_event.dart';
import 'package:nivaas/screens/notices/notifications/bloc/notifications_state.dart';
import 'package:nivaas/widgets/cards/notification_card.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/ConfirmationDialog.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();
  int pageNo = 0;
  final int pageSize = 10;
  bool isLoadingMore = false;
  bool hasMore = true;
  List<dynamic> notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
    _scrollController.addListener(_onScroll);
  }

  void _fetchNotifications() {
    if (isLoadingMore || !hasMore) return;

    setState(() {
      isLoadingMore = true;
    });

    context
        .read<GetNotificationsBloc>()
        .add(FetchNotificationsEvent(pageNo, pageSize));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !isLoadingMore &&
        hasMore) {
      pageNo++;
      _fetchNotifications();
    }
  }

  void _deleteAllNotifications() {
    context.read<GetNotificationsBloc>().add(ClearAllNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Notifications'),
      body: BlocConsumer<GetNotificationsBloc, GetNotificationsState>(
        listener: (context, state) {
          if (state is GetNotificationsLoaded) {
            setState(() {
              notifications.addAll(state.notifications.data as Iterable);
              hasMore = state.notifications.data?.length == pageSize;
              isLoadingMore = false;
            });
          } else if (state is GetNotificationsError) {
            setState(() {
              isLoadingMore = false;
              hasMore = false;
            });
          } else if (state is DeleteNotificationSuccess) {
            setState(() {
              notifications.clear();
              pageNo = 0;
              hasMore = true;
            });
            CustomSnackbarWidget(
              context: context,
              title: 'All notifications deleted successfully.',
              backgroundColor: AppColor.green,
            );
            Navigator.of(context).pop();
          } else if (state is DeleteNotificationError) {
            CustomSnackbarWidget(
              context: context,
              title: 'Error in deleting Notifications',
              backgroundColor: AppColor.red,
            );
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is GetNotificationsLoading && notifications.isEmpty) {
            return const Center(child: AppLoader());
          }
          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications available.'));
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: notifications.length + (isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == notifications.length) {
                return const Center(child: AppLoader());
              }
              final notification = notifications[index];
              return NotificationCard(
                date: notification.creationTime!.split('T')[0],
                title: capitalizeFirstLetter(notification.type),
                msg: notification.message ?? '',
                role: notification.userId.toString(),
              );
            },
          );
        },
      ),
      floatingActionButton: notifications.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ConfirmationDialog(
                  title: 'Are you sure you want to Delete all notifications?',
                  onConfirm: () => _deleteAllNotifications(),
                  onCancel: () => Navigator.of(context).pop(),
                ),
              ),
              backgroundColor: AppColor.blueShade,
              child: const Icon(Icons.delete),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
