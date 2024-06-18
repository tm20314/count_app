import 'package:count_app/screens/login_screen.dart';
import 'package:count_app/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthState, Supabase;

Future<void> main() async {
  // Flutterエンジンを初期化
  WidgetsFlutterBinding.ensureInitialized();

  // SupabaseクライアントをURLとアノニマスキーで初期化
  await Supabase.initialize(
      url: 'https://ycnpvgqdogzhjhiilvbs.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InljbnB2Z3Fkb2d6aGpoaWlsdmJzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTU3MDkxMDksImV4cCI6MjAzMTI4NTEwOX0.w32xNB9Wv81yD5X3mvvSUuKb2ydvMrqvDXFg7DWa0L0');

  // MainAppウィジェットを使用してアプリケーションを開始
  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

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
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else {
          final session = snapshot.data?.session;
          if (session != null) {
            return const SecondScreen();
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }
}
