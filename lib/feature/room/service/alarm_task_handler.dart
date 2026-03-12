import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/repository/local_room_repository.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(AlarmTaskHandler());
}

class AlarmTaskHandler implements TaskHandler {
  StreamSubscription<List<Map<String, dynamic>>>? _subscription;
  AudioPlayer? _audioPlayer;
  bool _isAlarmPlaying = false;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    final url = await LocalRoomRepository.getSupabaseUrl();
    final anonKey = await LocalRoomRepository.getSupabaseAnonKey();
    final roomId = await LocalRoomRepository.getRoomId();

    if (url == null || anonKey == null || roomId == null) {
      await FlutterForegroundTask.stopService();
      return;
    }

    await Supabase.initialize(url: url, anonKey: anonKey);
    _audioPlayer = AudioPlayer();
    await _audioPlayer!.setReleaseMode(ReleaseMode.loop);

    _subscription = Supabase.instance.client
        .from('rooms')
        .stream(primaryKey: ['id'])
        .eq('id', roomId)
        .listen((data) async {
          if (data.isEmpty) return;
          final status = data.first['status'] as String?;
          switch (status) {
            case 'alarming':
            case 'penalty':
              if (!_isAlarmPlaying) {
                _isAlarmPlaying = true;
                await _audioPlayer!.play(AssetSource('audio/alarm.mp3'));
                await FlutterForegroundTask.updateService(
                  notificationTitle: '⚠ アラーム',
                  notificationText: 'アラームが発動しました',
                );
              }
            case 'cleared':
            case 'force_stopped':
              await _audioPlayer!.stop();
              _isAlarmPlaying = false;
              FlutterForegroundTask.sendDataToMain({'action': 'exit_room'});
              await FlutterForegroundTask.stopService();
            default:
              if (_isAlarmPlaying) {
                await _audioPlayer!.stop();
                _isAlarmPlaying = false;
              }
          }
        });
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    await _subscription?.cancel();
    await _audioPlayer?.stop();
    await _audioPlayer?.dispose();
    _audioPlayer = null;
  }

  @override
  void onReceiveData(Object data) {}

  @override
  void onNotificationButtonPressed(String id) {}

  @override
  void onNotificationPressed() {}

  @override
  void onNotificationDismissed() {}
}
