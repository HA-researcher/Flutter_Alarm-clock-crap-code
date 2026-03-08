import 'package:flutter_alarm_clock_crap_code/feature/home/viewmodel/home_screen_view_model.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/provider/room_id_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qr_scan_screen_view_model.freezed.dart';
part 'qr_scan_screen_view_model.g.dart';

@freezed
class QrScanScreenState with _$QrScanScreenState {
  const factory QrScanScreenState({@Default('') String detectedValue}) =
      _QrScanScreenState;

  factory QrScanScreenState.fromJson(Map<String, Object?> json) =>
      _$QrScanScreenStateFromJson(json);
}

@riverpod
MobileScannerController qrScannerController(Ref ref) {
  final controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const <BarcodeFormat>[BarcodeFormat.qrCode],
  );

  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
}

@riverpod
class QrScanScreenViewModel extends _$QrScanScreenViewModel {
  @override
  QrScanScreenState build() {
    return const QrScanScreenState();
  }

  Future<void> onDetectHoge(BarcodeCapture capture) async {
    if (capture.barcodes.isEmpty) {
      return;
    }
    final roomId = capture.barcodes.first.rawValue;
    if (roomId == null || roomId.isEmpty) {
      return;
    }
    ref.read(roomIdProvider.notifier).set(roomId);
    ref.read(homeScreenViewModelProvider.notifier).setSessionActive(true);
  }
}
