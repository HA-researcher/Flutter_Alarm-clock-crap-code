import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/model/room.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/provider/room_id_provider.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/provider/room_stream_provider.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/repository/local_room_repository.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/service/alarm_foreground_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_screen_view_model.freezed.dart';
part 'home_screen_view_model.g.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({
    @Default(false) bool isSessionActive,
    @Default(false) bool isAlarmActive,
    RoomStatus? roomStatus,
  }) = _HomeScreenState;

  factory HomeScreenState.fromJson(Map<String, Object?> json) =>
      _$HomeScreenStateFromJson(json);
}

@riverpod
class HomeScreenViewModel extends _$HomeScreenViewModel {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  HomeScreenState build() {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.onPlayerComplete.listen((s) {
      setAlarmActive(false);
    });

    // バックグラウンド isolate からのメッセージ受信
    void onTaskData(Object data) {
      if (data is Map && data['action'] == 'exit_room') {
        _exitRoom();
      }
    }
    FlutterForegroundTask.addTaskDataCallback(onTaskData);
    ref.onDispose(() => FlutterForegroundTask.removeTaskDataCallback(onTaskData));

    // roomId がセットされたらローカル保存 + フォアグラウンドサービス起動
    ref.listen(roomIdProvider, (prev, next) {
      if (next != null && prev == null) {
        ref.read(localRoomRepositoryProvider.notifier).saveRoomId(next);
        AlarmForegroundService.start();
      }
    });

    ref.listen(roomStreamProvider, (prev, next) {
      final room = next.valueOrNull;
      if (room == null) return;

      state = state.copyWith(roomStatus: room.status);

      switch (room.status) {
        case RoomStatus.alarming:
        case RoomStatus.penalty:
          if (!state.isAlarmActive) {
            playAlarm();
          }
        case RoomStatus.coding:
          if (state.isAlarmActive) {
            setAlarmActive(false);
          }
        case RoomStatus.cleared:
        case RoomStatus.forceStopped:
          if (state.isAlarmActive) {
            setAlarmActive(false);
          }
          _exitRoom();
        case RoomStatus.waiting:
        case RoomStatus.reviewing:
          break;
      }
    });

    return const HomeScreenState();
  }

  void setSessionActive(bool isActive) {
    state = state.copyWith(isSessionActive: isActive);
  }

  void setAlarmActive(bool isActive) async {
    state = state.copyWith(isAlarmActive: isActive);
    if (state.isAlarmActive == false) {
      await _audioPlayer.stop();
    }
  }

  void playAlarm() async {
    setAlarmActive(true);
    await _audioPlayer.play(AssetSource('audio/alarm.mp3'));
  }

  void _exitRoom() {
    state = state.copyWith(isSessionActive: false, roomStatus: null);
    ref.read(localRoomRepositoryProvider.notifier).clearRoomId();
    AlarmForegroundService.stop();
    ref.read(roomIdProvider.notifier).clear();
  }

  Future<void> onTapEmergencyButton() async {
    final roomId = ref.read(roomIdProvider);
    if (roomId != null) {
      await Supabase.instance.client
          .from('rooms')
          .update({'status': 'force_stopped'})
          .eq('id', roomId);
    }
  }
}
