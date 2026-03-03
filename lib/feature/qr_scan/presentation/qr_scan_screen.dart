import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/qr_scan/viewmodel/qr_scan_screen_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanScreen extends ConsumerWidget {
  const QrScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(qrScanScreenViewModelProvider);
    final viewModel = ref.read(qrScanScreenViewModelProvider.notifier);
    final controller = ref.watch(qrScannerControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: <Widget>[
          MobileScanner(
            controller: controller,
            onDetect: (capture) async {
              await viewModel.onDetectHoge(capture);
              if (!context.mounted) {
                return;
              }
              Navigator.pop(context);
            },
          ),
          Center(
            child: IgnorePointer(
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
