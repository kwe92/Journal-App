import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

// TODO: edit comments

class NotificationService extends ChangeNotifier {
  final channelGroupKey = "basic_group_channel";

  final instance = AwesomeNotifications();

  final channelKey = "basic_channel";

  Future<void> initializeNotificationChannels() async {
    await instance.initialize(
      null, // default icon path, if null then will use a generic flutter icon
      // list of notification channels
      [
        // cannel values can be whatever you want them to be
        NotificationChannel(
          channelGroupKey: channelGroupKey,
          channelKey: channelKey,
          channelName: "basic_notifications",
          channelDescription: "basic notification channel",
        ),
      ],
      // group notifications
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: channelGroupKey,
          channelGroupName: "basic_group",
        ),
      ],
    );
  }

  // check if notifications are allowed and if not then request to allow notifications
  Future<void> checkNotificationPermissions() async {
    bool isAllowedToSendNotification = await instance.isNotificationAllowed();

    if (!isAllowedToSendNotification) {
      instance.requestPermissionToSendNotifications();
    }
  }

  // listen to events and trigger callback functions
  // required to be static and to set at least one callback for the awesome package to work correctly
  void setNotificationListeners() {
    instance.setListeners(
      onActionReceivedMethod: NotificationService.onNotifcationSelected,
      onNotificationCreatedMethod: NotificationService.onNotifcationCreated,
      onDismissActionReceivedMethod: NotificationService.onNotifcationDismissed,
      onNotificationDisplayedMethod: NotificationService.onNotifcationDisplayed,
    );
  }

  // detects new and and scheduled notification is created
  static Future<void> onNotifcationCreated(ReceivedNotification receivedNotification) async {
    // TODO: implement
  }

  static Future<void> onNotifcationDisplayed(ReceivedNotification receivedNotification) async {
    // TODO: implement
  }

  static Future<void> onNotifcationDismissed(ReceivedNotification receivedNotification) async {
    // TODO: implement
  }

  static Future<void> onNotifcationSelected(ReceivedNotification receivedNotification) async {
    // TODO: implement
  }
}
