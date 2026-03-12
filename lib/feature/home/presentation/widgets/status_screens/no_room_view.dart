import 'package:flutter/material.dart';

class NoRoomView extends StatelessWidget {
  final VoidCallback onScanQr;

  const NoRoomView({super.key, required this.onScanQr});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A0A0F),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24, width: 2),
                color: Colors.white.withAlpha(13),
              ),
              child: const Icon(
                Icons.alarm,
                size: 52,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'ALARM CLOCK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: 6,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'スキャンしてセッションに参加',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 13,
                letterSpacing: 1,
              ),
            ),
            const Spacer(flex: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: GestureDetector(
                onTap: onScanQr,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white30, width: 1.5),
                    color: Colors.white.withAlpha(20),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_scanner, color: Colors.white70, size: 24),
                      SizedBox(width: 12),
                      Text(
                        'QR コードをスキャン',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
