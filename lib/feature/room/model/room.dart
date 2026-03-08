import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

enum RoomStatus {
  @JsonValue('waiting')
  waiting,
  @JsonValue('alarming')
  alarming,
  @JsonValue('coding')
  coding,
  @JsonValue('reviewing')
  reviewing,
  @JsonValue('cleared')
  cleared,
  @JsonValue('penalty')
  penalty,
  @JsonValue('force_stopped')
  forceStopped,
}

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    @JsonKey(name: 'target_time') required String targetTime,
    required String language,
    required String level,
    @JsonKey(name: 'custom_level_prompt') String? customLevelPrompt,
    @JsonKey(name: 'is_sleep_detection_on') required bool isSleepDetectionOn,
    required RoomStatus status,
    @JsonKey(name: 'current_code') String? currentCode,
  }) = _Room;

  factory Room.fromJson(Map<String, Object?> json) => _$RoomFromJson(json);
}
