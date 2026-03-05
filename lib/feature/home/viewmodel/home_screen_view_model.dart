import 'package:audioplayers/audioplayers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen_view_model.freezed.dart';
part 'home_screen_view_model.g.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({
    @Default(false) bool isSessionActive,
    @Default(false) bool isAlarmActive,
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
}
