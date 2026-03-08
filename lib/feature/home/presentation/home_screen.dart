import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/usecase/home_use_case.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/viewmodel/home_screen_view_model.dart';
import 'package:flutter_alarm_clock_crap_code/feature/qr_scan/presentation/qr_scan_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeScreenViewModelProvider);
    final isSessionActive = homeState.isSessionActive;
    final isAlarmActive = homeState.isAlarmActive;
    final roomStatus = homeState.roomStatus;
    final useCase = HomeUseCase();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isSessionActive ? 'Session Active' : 'Session Inactive'),
            const SizedBox(height: 8),
            Text('Status: ${useCase.statusLabel(roomStatus)}'),
            const SizedBox(height: 16),
            if (isSessionActive && isAlarmActive)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await ref
                      .read(homeScreenViewModelProvider.notifier)
                      .onTapEmergencyButton();
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
