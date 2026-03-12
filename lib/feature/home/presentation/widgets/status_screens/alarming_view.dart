import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/viewmodel/alarming_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmingView extends ConsumerWidget {
  final VoidCallback onEmergencyStop;

  const AlarmingView({super.key, required this.onEmergencyStop});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(alarmingViewModelProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      color: state.isBgFlash ? const Color(0xFF1A0000) : Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            AnimatedScale(
              scale: state.isPulseLarge ? 1.15 : 0.85,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 3),
                  color: Colors.red.withAlpha(26),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withAlpha(102),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 72,
                ),
              ),
            ),
            const SizedBox(height: 40),
            AnimatedOpacity(
              opacity: state.isTextVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: const Text(
                '⚠  ALARM  ⚠',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 8,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'アラームが鳴っています',
              style: TextStyle(
                color: Colors.red.withAlpha(179),
                fontSize: 14,
                letterSpacing: 2,
              ),
            ),
            const Spacer(flex: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: GestureDetector(
                onTap: onEmergencyStop,
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withAlpha(128),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.stop_circle_outlined, color: Colors.white, size: 28),
                      SizedBox(width: 12),
                      Text(
                        'EMERGENCY STOP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
