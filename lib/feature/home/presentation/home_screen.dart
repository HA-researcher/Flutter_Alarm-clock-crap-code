import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/viewmodel/home_screen_view_model.dart';
import 'package:flutter_alarm_clock_crap_code/feature/qr_scan/presentation/qr_scan_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSessionActive = ref
        .watch(homeScreenViewModelProvider)
        .isSessionActive;
    final isAlarmActive = ref.watch(homeScreenViewModelProvider).isAlarmActive;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isSessionActive ? 'Session Active' : 'Session Inactive'),
            ElevatedButton(
              onPressed: isAlarmActive
                  ? () {
                      ref
                          .read(homeScreenViewModelProvider.notifier)
                          .setAlarmActive(false);
                    }
                  : () {
                      ref
                          .read(homeScreenViewModelProvider.notifier)
                          .playAlarm();
                    },
              child: Text(isAlarmActive ? 'End Session' : 'Start Session'),
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
              child: Icon(Icons.play_arrow),
            ),
    );
  }
}
