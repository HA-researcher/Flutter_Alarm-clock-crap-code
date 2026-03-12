import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/viewmodel/cleared_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClearedView extends ConsumerWidget {
  final bool isForceStopped;

  const ClearedView({super.key, this.isForceStopped = false});

  static const _green = Color(0xFF00FF41);
  static const _grey = Color(0xFF888888);

  Color get _accentColor => isForceStopped ? _grey : _green;
  String get _label => isForceStopped ? 'STOPPED' : 'CLEARED';
  String get _subLabel =>
      isForceStopped ? '強制停止されました' : 'セッションクリア！お疲れ様でした';
  IconData get _icon =>
      isForceStopped ? Icons.stop_circle_outlined : Icons.check_circle_outline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clearedViewModelProvider);
    final glowRadius = state.isGlowIntense ? 60.0 : 10.0;
    final glowSpread = state.isGlowIntense ? 10.0 : 2.0;

    return Container(
      color: const Color(0xFF050F05),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _accentColor.withAlpha(179), width: 2),
                  color: _accentColor.withAlpha(20),
                  boxShadow: [
                    BoxShadow(
                      color: _accentColor.withAlpha(100),
                      blurRadius: glowRadius,
                      spreadRadius: glowSpread,
                    ),
                  ],
                ),
                child: Icon(
                  _icon,
                  color: _accentColor,
                  size: 60,
                ),
              ),
              const SizedBox(height: 36),
              Text(
                _label,
                style: TextStyle(
                  color: _accentColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 8,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _subLabel,
                style: TextStyle(
                  color: Colors.white.withAlpha(102),
                  fontSize: 13,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
