import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_room_repository.g.dart';

const _keyRoomId = 'room_id';
const _keySupabaseUrl = 'supabase_url';
const _keySupabaseAnonKey = 'supabase_anon_key';

@riverpod
class LocalRoomRepository extends _$LocalRoomRepository {
  @override
  void build() {}

  Future<void> saveRoomId(String roomId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyRoomId, roomId);
  }

  Future<void> clearRoomId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyRoomId);
  }

  static Future<void> saveSupabaseCredentials(
    String url,
    String anonKey,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySupabaseUrl, url);
    await prefs.setString(_keySupabaseAnonKey, anonKey);
  }

  static Future<String?> getRoomId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRoomId);
  }

  static Future<String?> getSupabaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keySupabaseUrl);
  }

  static Future<String?> getSupabaseAnonKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keySupabaseAnonKey);
  }
}
