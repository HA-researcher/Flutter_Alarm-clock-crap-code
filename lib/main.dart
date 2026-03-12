import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock_crap_code/feature/home/presentation/home_screen.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/repository/local_room_repository.dart';
import 'package:flutter_alarm_clock_crap_code/feature/room/service/alarm_foreground_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  final url = dotenv.env['NEXT_PUBLIC_SUPABASE_URL']!;
  final anonKey = dotenv.env['NEXT_PUBLIC_SUPABASE_ANON_KEY']!;

  await Supabase.initialize(url: url, anonKey: anonKey);
  await LocalRoomRepository.saveSupabaseCredentials(url, anonKey);
  AlarmForegroundService.initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    );
  }
}
