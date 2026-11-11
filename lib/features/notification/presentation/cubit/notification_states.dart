import 'package:aura_maison_e_commerce/features/notification/data/models/notification_model.dart';

abstract class NotificationStates {}

class NotificationInitialState extends NotificationStates {}

class NotificationLoadingState extends NotificationStates {}

class NotificationSuccessState extends NotificationStates {
  List<NotificationModel>items;

NotificationSuccessState({required this.items});
}

class NotificationErrorState extends NotificationStates {
  final String error;

  NotificationErrorState(this.error);
}

