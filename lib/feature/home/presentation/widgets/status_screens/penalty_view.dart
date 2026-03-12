import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/viewmodel/penalty_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PenaltyView extends ConsumerWidget {
  final VoidCallback onEmergencyStop;

  const PenaltyView({super.key, required this.onEmergencyStop});

  static const _orange = Color(0xFFFF6600);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(penaltyViewModelProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: state.isBgFlash ? const Color(0xFF1A0A00) : Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            AnimatedScale(
              scale: state.isPulseLarge ? 1.1 : 0.9,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _orange, width: 3),
                  color: _orange.withAlpha(26),
                  boxShadow: [
                    BoxShadow(
                      color: _orange.withAlpha(102),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: _orange,
                  size: 72,
                ),
              ),
            ),
            const SizedBox(height: 40),
            AnimatedOpacity(
              opacity: state.isTextVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              child: const Text(
                '⚡  PENALTY  ⚡',
                style: TextStyle(
                  color: _orange,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 6,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'ペナルティタイムです',
              style: TextStyle(
                color: _orange.withAlpha(179),
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
                    color: _orange,
                    boxShadow: [
                      BoxShadow(
                        color: _orange.withAlpha(128),
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
