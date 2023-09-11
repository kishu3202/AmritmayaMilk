import 'package:amritmaya_milk/provider/userProvider/notification_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  final String customerId;

  const NotificationScreen({
    Key? key,
    required this.customerId,
  }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String notificationId = '';
  @override
  void initState() {
    super.initState();
    getNotificationData();
  }

  void getNotificationData() async {
    final notificationProvider =
    Provider.of<NotificationProvider>(context, listen: false);
    try {
      await notificationProvider.fetchNotification(widget.customerId);
      showNotificationAlert(payload: 'notification_data_here');
    } catch (error) {
      print('Error fetching notifications: $error');
    }
  }

  Future<String?> getNotificationStatus(String notificationId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("notification_$notificationId");
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider =
    Provider.of<NotificationProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: notificationProvider.notificationIdList.length,
            itemBuilder: (context, index) {
              final notificationId =
              notificationProvider.notificationIdList[index];
              final title = notificationProvider.notificationTitleList[index];
              final description =
              notificationProvider.notificationDescriptionList[index];
              final status = notificationProvider.notificationStatusList[index];

              return FutureBuilder<String?>(
                future: getNotificationStatus(notificationId),
                builder: (context, snapshot) {
                  // final notificationStatus = snapshot.data ?? "unread";
                  // final bool isRead = notificationStatus == "read";

                  // Check if the notification is read or unread
                  final isRead = status == "1";

                  return NotificationCard(
                    title: title,
                    description: description,
                    isRead: isRead,
                    onTap: () {
                      if (!isRead) {
                        notificationProvider
                            .markNotificationAsRead(notificationId);
                        setState(() {
                          notificationProvider.notificationStatusList[index] =
                          "1";
                        });
                      }
                    },
                  );
                },
              );
            }));
  }

  void showNotificationAlert({required String payload}) {}
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationCard({
    required this.title,
    required this.description,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isRead ? Colors.white : Colors.deepPurple.shade50,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        onTap: onTap,
        leading: isRead
            ? null
            : CircleAvatar(
          radius: 4,
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}