import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coding_view_model.freezed.dart';
part 'coding_view_model.g.dart';

@freezed
class CodingState with _$CodingState {
  const factory CodingState({
    @Default(true) bool isCursorVisible,
  }) = _CodingState;
}

@riverpod
class CodingViewModel extends _$CodingViewModel {
  Timer? _timer;

  @override
  CodingState build() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      state = state.copyWith(isCursorVisible: !state.isCursorVisible);
    });
    ref.onDispose(() => _timer?.cancel());
    return const CodingState();
  }
}
