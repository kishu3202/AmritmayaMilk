class NotificationDataModel {
  String message;
  bool success;
  List<NotificationList> notificationList;
  int count;

  NotificationDataModel({
    required this.message,
    required this.success,
    required this.notificationList,
    required this.count,
  });
}

class NotificationList {
  String id;
  String customerId;
  String title;
  String description;
  String status;

  NotificationList({
    required this.id,
    required this.customerId,
    required this.title,
    required this.description,
    required this.status,
  });
}
