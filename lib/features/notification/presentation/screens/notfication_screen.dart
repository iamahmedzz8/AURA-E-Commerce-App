import 'package:aura_maison_e_commerce/features/notification/presentation/cubit/notification_cubot.dart';
import 'package:aura_maison_e_commerce/features/notification/presentation/cubit/notification_states.dart';
import 'package:aura_maison_e_commerce/features/notification/presentation/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NotficationScreen extends StatelessWidget {
  const NotficationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Notification')),
      body: BlocBuilder<NotificationCubit, NotificationStates>(
        builder: (context, state) {
          if (state is NotificationLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationErrorState) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.error),
                    const Gap(10),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<NotificationCubit>().getNotifications(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is NotificationSuccessState) {
            if (state.items.isEmpty) {
              return const Center(child: Text('No notifications yet'));
            }
            return RefreshIndicator(
              onRefresh: () =>
                  context.read<NotificationCubit>().getNotifications(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomScrollView(
                  slivers: [
                    SliverList.separated(
                      itemCount: state.items.length,
                      separatorBuilder: (context, index) => const Gap(10),
                      itemBuilder: (context, index) {
                        return NotificationItem(
                          notification: state.items[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
