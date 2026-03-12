import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/viewmodel/waiting_view_model.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/model/room.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WaitingView extends ConsumerWidget {
  final Room room;

  const WaitingView({super.key, required this.room});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(waitingViewModelProvider);
    final dots = '.' * state.dotCount;

    return Container(
      color: const Color(0xFF050D1A),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  color: Color(0xFF00FFFF),
                  strokeWidth: 2,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'WAITING FOR SESSION$dots',
                style: const TextStyle(
                  color: Color(0xFF00FFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 48),
              _InfoRow(label: 'LANGUAGE', value: room.language.toUpperCase()),
              const SizedBox(height: 12),
              _InfoRow(label: 'LEVEL', value: room.level.toUpperCase()),
              const SizedBox(height: 12),
              _InfoRow(label: 'TARGET', value: room.targetTime),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label  ',
          style: const TextStyle(
            color: Colors.white30,
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
