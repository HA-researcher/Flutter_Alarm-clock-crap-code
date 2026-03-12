import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reviewing_view_model.freezed.dart';
part 'reviewing_view_model.g.dart';

@freezed
class ReviewingState with _$ReviewingState {
  const factory ReviewingState({
    @Default(0) int rotationTurns,
  }) = _ReviewingState;
}

@riverpod
class ReviewingViewModel extends _$ReviewingViewModel {
  Timer? _timer;

  @override
  ReviewingState build() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      state = state.copyWith(rotationTurns: state.rotationTurns + 1);
    });
    ref.onDispose(() => _timer?.cancel());
    return const ReviewingState();
  }
}
