import 'dart:developer';
import 'package:aura_maison_e_commerce/features/notification/data/repo/notification_repo.dart';
import 'package:aura_maison_e_commerce/features/notification/presentation/cubit/notification_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  final NotificationRepo repo = NotificationRepo();

  NotificationCubit() : super(NotificationInitialState());

  Future<void> getNotifications() async {
    emit(NotificationLoadingState());
    try {
      final items = await repo.getNotifications();
      log('Api Run Success');
      emit(NotificationSuccessState(items: items));
    } catch (err) {
      log('Api Run Error');
      emit(NotificationErrorState(err.toString()));
    }
  }
}
