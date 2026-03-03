import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen_view_model.freezed.dart';
part 'home_screen_view_model.g.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({@Default(false) bool isSessionActive}) =
      _HomeScreenState;

  factory HomeScreenState.fromJson(Map<String, Object?> json) =>
      _$HomeScreenStateFromJson(json);
}

@riverpod
class HomeScreenViewModel extends _$HomeScreenViewModel {
  @override
  HomeScreenState build() {
    return const HomeScreenState();
  }

  void setSessionActive(bool isActive) {
    state = state.copyWith(isSessionActive: isActive);
  }
}
