class NotificationModel {
  final String id; // بيتستخدم في الـ read بس، ومش بيظهر في الـ UI
  final String notificationText;
  final DateTime createdAt;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.notificationText,
    required this.createdAt,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'],
        notificationText: json['notificationText'] ?? '',
        createdAt: DateTime.parse(json['createdAt']),
        isRead: json['isRead'] ?? false,
      );

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
        id: id,
        notificationText: notificationText,
        createdAt: createdAt,
        isRead: isRead ?? this.isRead,
      );
}