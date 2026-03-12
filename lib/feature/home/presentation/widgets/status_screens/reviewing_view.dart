import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/viewmodel/reviewing_view_model.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/model/room.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewingView extends ConsumerWidget {
  final Room room;

  const ReviewingView({super.key, required this.room});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reviewingViewModelProvider);

    return Container(
      color: const Color(0xFF0E0818),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedRotation(
                turns: state.rotationTurns.toDouble(),
                duration: const Duration(seconds: 3),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFFD700).withAlpha(77),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Color(0xFFFFD700),
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              const Text(
                'UNDER REVIEW',
                style: TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'コードを審査中です...',
                style: TextStyle(
                  color: Colors.white.withAlpha(102),
                  fontSize: 13,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 48),
              _DetailChip(label: room.language),
              const SizedBox(height: 8),
              _DetailChip(label: room.level),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final String label;

  const _DetailChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFD700).withAlpha(77)),
        color: const Color(0xFFFFD700).withAlpha(20),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFFFFD700),
          fontSize: 12,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
