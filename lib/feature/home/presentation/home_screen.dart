import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/viewmodel/home_screen_view_model.dart';
import 'package:flutter_alarm_clock_crap_code/feature/qr_scan/presentation/qr_scan_screen.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/model/room.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/provider/room_id_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _statusLabel(RoomStatus? status) {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeScreenViewModelProvider);
    final isSessionActive = homeState.isSessionActive;
    final isAlarmActive = homeState.isAlarmActive;
    final roomStatus = homeState.roomStatus;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isSessionActive ? 'Session Active' : 'Session Inactive'),
            const SizedBox(height: 8),
            Text('Status: ${_statusLabel(roomStatus)}'),
            const SizedBox(height: 16),
            if (isSessionActive && isAlarmActive)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  final roomId = ref.read(roomIdProvider);
                  if (roomId != null) {
                    await Supabase.instance.client
                        .from('rooms')
                        .update({'status': 'force_stopped'})
                        .eq('id', roomId);
                  }
                },
                child: const Text('Emergency Stop'),
              ),
          ],
        ),
      ),
      floatingActionButton: isSessionActive
          ? null
          : FloatingActionButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const QrScanScreen(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Icon(Icons.qr_code_scanner),
            ),
    );
  }
}
