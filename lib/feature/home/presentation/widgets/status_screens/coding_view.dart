import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/viewmodel/coding_view_model.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/model/room.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CodingView extends ConsumerWidget {
  final Room room;

  const CodingView({super.key, required this.room});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(codingViewModelProvider);

    return Container(
      color: const Color(0xFF0D1117),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00FF41).withAlpha(26),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFF00FF41).withAlpha(77)),
                ),
                child: const Text(
                  'CODING',
                  style: TextStyle(
                    color: Color(0xFF00FF41),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '> ${room.language}',
                style: const TextStyle(
                  color: Color(0xFF00FF41),
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '> level: ${room.level}',
                style: TextStyle(
                  color: const Color(0xFF00FF41).withAlpha(153),
                  fontSize: 16,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '> target: ${room.targetTime}',
                style: TextStyle(
                  color: const Color(0xFF00FF41).withAlpha(153),
                  fontSize: 16,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '> _',
                    style: TextStyle(
                      color: const Color(0xFF00FF41).withAlpha(153),
                      fontSize: 16,
                      fontFamily: 'monospace',
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: state.isCursorVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: 10,
                      height: 18,
                      color: const Color(0xFF00FF41),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 1,
                color: const Color(0xFF00FF41).withAlpha(51),
              ),
              const SizedBox(height: 12),
              Text(
                '// コーディング中 — 集中してください',
                style: TextStyle(
                  color: Colors.white.withAlpha(38),
                  fontSize: 12,
                  fontFamily: 'monospace',
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
