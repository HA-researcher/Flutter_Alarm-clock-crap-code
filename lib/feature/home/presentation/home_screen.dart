import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/presentation/widgets/status_screens/alarming_view.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/presentation/widgets/status_screens/cleared_view.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/presentation/widgets/status_screens/coding_view.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/presentation/widgets/status_screens/no_room_view.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/presentation/widgets/status_screens/penalty_view.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/presentation/widgets/status_screens/reviewing_view.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/presentation/widgets/status_screens/waiting_view.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/viewmodel/home_screen_view_model.dart';
import 'package:flutter_alarm_clock_crap_code/feature/qr_scan/presentation/qr_scan_screen.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/model/room.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/provider/room_stream_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeScreenViewModelProvider);
    final roomAsync = ref.watch(roomStreamProvider);
    final room = roomAsync.valueOrNull;

    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _buildContent(
          context,
          ref,
          homeState.roomStatus,
          room,
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    RoomStatus? status,
    Room? room,
  ) {
    if (status == null || room == null) {
      return NoRoomView(
        key: const ValueKey('no_room'),
        onScanQr: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const QrScanScreen(),
              fullscreenDialog: true,
            ),
          );
        },
      );
    }

    return switch (status) {
      RoomStatus.waiting => WaitingView(key: const ValueKey('waiting'), room: room),
      RoomStatus.coding => CodingView(key: const ValueKey('coding'), room: room),
      RoomStatus.reviewing => ReviewingView(key: const ValueKey('reviewing'), room: room),
      RoomStatus.alarming => AlarmingView(
          key: const ValueKey('alarming'),
          onEmergencyStop: () => ref
              .read(homeScreenViewModelProvider.notifier)
              .onTapEmergencyButton(),
        ),
      RoomStatus.penalty => PenaltyView(
          key: const ValueKey('penalty'),
          onEmergencyStop: () => ref
              .read(homeScreenViewModelProvider.notifier)
              .onTapEmergencyButton(),
        ),
      RoomStatus.cleared => const ClearedView(key: ValueKey('cleared')),
      RoomStatus.forceStopped =>
        const ClearedView(key: ValueKey('force_stopped'), isForceStopped: true),
    };
  }
}
