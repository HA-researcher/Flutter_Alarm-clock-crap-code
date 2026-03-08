import 'package:flutter_alarm_clock_crap_code/feature/room/model/room.dart';

class HomeUseCase {
  String statusLabel(RoomStatus? status) {
    return switch (status) {
      RoomStatus.waiting => 'Waiting',
      RoomStatus.alarming => 'Alarming',
      RoomStatus.coding => 'Coding',
      RoomStatus.reviewing => 'Reviewing',
      RoomStatus.cleared => 'Cleared',
      RoomStatus.penalty => 'Penalty',
      RoomStatus.forceStopped => 'Force Stopped',
      null => 'No Room',
    };
  }
}
