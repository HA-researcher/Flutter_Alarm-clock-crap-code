import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'room_id_provider.g.dart';

@riverpod
class RoomId extends _$RoomId {
  @override
  String? build() => null;

  void set(String roomId) {
    state = roomId;
  }

  void clear() {
    state = null;
  }
}
