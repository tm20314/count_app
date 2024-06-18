import 'package:count_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

import 'env/env.dart';

Future<void> main() async {
  // Flutterエンジンを初期化
  WidgetsFlutterBinding.ensureInitialized();

  // SupabaseクライアントをURLとアノニマスキーで初期化
  await Supabase.initialize(url: Env.key1, anonKey: Env.key2);

  // MainAppウィジェットを使用してアプリケーションを開始
  runApp(const MainApp());
}

// MainAppクラス: アプリケーションの状態を管理するStatefulWidget
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
