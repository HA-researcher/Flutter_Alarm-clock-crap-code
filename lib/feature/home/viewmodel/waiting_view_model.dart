import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'waiting_view_model.freezed.dart';
part 'waiting_view_model.g.dart';

@freezed
class WaitingState with _$WaitingState {
  const factory WaitingState({
    @Default(0) int dotCount,
  }) = _WaitingState;
}

@riverpod
class WaitingViewModel extends _$WaitingViewModel {
  Timer? _timer;

  @override
  WaitingState build() {
    _timer = Timer.periodic(const Duration(milliseconds: 600), (_) {
      state = state.copyWith(dotCount: (state.dotCount + 1) % 4);
    });
    ref.onDispose(() => _timer?.cancel());
    return const WaitingState();
  }
}
