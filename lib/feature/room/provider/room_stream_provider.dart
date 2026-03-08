import 'package:flutter_alarm_clock_crap_code/feature/room/model/room.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/provider/room_id_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'room_stream_provider.g.dart';

@riverpod
Stream<Room> roomStream(Ref ref) {
  final roomId = ref.watch(roomIdProvider);
  if (roomId == null) {
    return const Stream.empty();
  }

  final supabase = Supabase.instance.client;
  return supabase
      .from('rooms')
      .stream(primaryKey: ['id'])
      .eq('id', roomId)
      .map((data) => Room.fromJson(data.first));
}
