import 'package:flutter_alarm_clock_crap_code/feature/room/service/alarm_task_handler.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class AlarmForegroundService {
  AlarmForegroundService._();

  static void initialize() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'alarm_monitor',
        channelName: 'アラーム監視',
        channelDescription: 'セッションのアラーム状態を監視しています',
        channelImportance: NotificationChannelImportance.HIGH,
        priority: NotificationPriority.HIGH,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.nothing(),
        autoRunOnBoot: false,
        allowWakeLock: true,
      ),
    );
  }

  static Future<void> start() async {
    await FlutterForegroundTask.requestNotificationPermission();

    if (await FlutterForegroundTask.isRunningService) {
      return;
    }

    await FlutterForegroundTask.startService(
      serviceId: 1001,
      notificationTitle: '監視中',
      notificationText: 'アラームを監視しています',
      callback: startCallback,
    );
  }

  static Future<void> stop() async {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
    }
  }
}
