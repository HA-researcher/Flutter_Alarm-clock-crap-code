import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarming_view_model.freezed.dart';
part 'alarming_view_model.g.dart';

@freezed
class AlarmingState with _$AlarmingState {
  const factory AlarmingState({
    @Default(true) bool isTextVisible,
    @Default(false) bool isPulseLarge,
    @Default(false) bool isBgFlash,
  }) = _AlarmingState;
}

@riverpod
class AlarmingViewModel extends _$AlarmingViewModel {
  Timer? _blinkTimer;
  Timer? _pulseTimer;
  Timer? _flashTimer;

  @override
  AlarmingState build() {
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      state = state.copyWith(isTextVisible: !state.isTextVisible);
    });
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 800), (_) {
      state = state.copyWith(isPulseLarge: !state.isPulseLarge);
    });
    _flashTimer = Timer.periodic(const Duration(milliseconds: 400), (_) {
      state = state.copyWith(isBgFlash: !state.isBgFlash);
    });
    ref.onDispose(() {
      _blinkTimer?.cancel();
      _pulseTimer?.cancel();
      _flashTimer?.cancel();
    });
    return const AlarmingState();
  }
}
