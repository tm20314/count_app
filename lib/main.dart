import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

Future<void> main() async {
  // Flutterエンジンを初期化
  WidgetsFlutterBinding.ensureInitialized();

  // SupabaseクライアントをURLとアノニマスキーで初期化
  await Supabase.initialize(
    url: 'https://ycnpvgqdogzhjhiilvbs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InljbnB2Z3Fkb2d6aGpoaWlsdmJzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTU3MDkxMDksImV4cCI6MjAzMTI4NTEwOX0.w32xNB9Wv81yD5X3mvvSUuKb2ydvMrqvDXFg7DWa0L0',
  );

  // MainAppウィジェットを使用してアプリケーションを開始
  runApp(const MainApp());
}

// MainAppクラス: アプリケーションの状態を管理するStatefulWidget
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

// _MainAppStateクラス: MainAppウィジェットの状態を管理
class MainAppState extends State<MainApp> {
// 人数を保持する変数を宣言し、初期値を0に設定
  int _personCount = 0;
// タイムスタンプを保持する変数を宣言し、初期値を空文字列に設定
  String _timestamp = '';
  @override
  void initState() {
    super.initState();
    // ウィジェットの初期化時にデータベースから人数を取得
    _fetchPersonCount();
  }

  // データベースから人数を取得するメソッド
// データベースから人数とタイムスタンプを取得するメソッド
  Future<void> _fetchPersonCount() async {
    // Supabaseクライアントを使用して、countテーブルからpersonカラムとtimeカラムの値を取得
    final response = await Supabase.instance.client
        .from('count')
        .select('person, time')
        .single();

    // 取得した人数と時刻を変数に設定し、UIを更新
    setState(() {
      _personCount = response['person'] as int;
      _timestamp = response['time'] as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    // アプリケーションのUIを構築
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
            GoogleFonts.sawarabiGothicTextTheme(Theme.of(context).textTheme),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('研究室の人数'),
        ),
        body: Center(
          // 取得した人数とタイムスタンプを表示するテキストウィジェット
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 100,
              ),
              Text(
                '今研究室にいる人数は\n $_personCount人\nです',
                style: const TextStyle(fontSize: 74),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'タイムスタンプ: $_timestamp',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
