import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cleared_view_model.freezed.dart';
part 'cleared_view_model.g.dart';

@freezed
class ClearedState with _$ClearedState {
  const factory ClearedState({
    @Default(false) bool isGlowIntense,
  }) = _ClearedState;
}

@riverpod
class ClearedViewModel extends _$ClearedViewModel {
  Timer? _timer;

  @override
  ClearedState build() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      state = state.copyWith(isGlowIntense: !state.isGlowIntense);
    });
    ref.onDispose(() => _timer?.cancel());
    return const ClearedState();
  }
}
