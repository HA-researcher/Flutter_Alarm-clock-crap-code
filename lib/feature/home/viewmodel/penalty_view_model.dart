import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'penalty_view_model.freezed.dart';
part 'penalty_view_model.g.dart';

@freezed
class PenaltyState with _$PenaltyState {
  const factory PenaltyState({
    @Default(true) bool isTextVisible,
    @Default(false) bool isPulseLarge,
    @Default(false) bool isBgFlash,
  }) = _PenaltyState;
}

@riverpod
class PenaltyViewModel extends _$PenaltyViewModel {
  Timer? _blinkTimer;
  Timer? _pulseTimer;
  Timer? _flashTimer;

  @override
  PenaltyState build() {
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 400), (_) {
      state = state.copyWith(isTextVisible: !state.isTextVisible);
    });
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 700), (_) {
      state = state.copyWith(isPulseLarge: !state.isPulseLarge);
    });
    _flashTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      state = state.copyWith(isBgFlash: !state.isBgFlash);
    });
    ref.onDispose(() {
      _blinkTimer?.cancel();
      _pulseTimer?.cancel();
      _flashTimer?.cancel();
    });
    return const PenaltyState();
  }
}
