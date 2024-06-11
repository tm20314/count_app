import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  _MainAppState createState() => _MainAppState();
}

// _MainAppStateクラス: MainAppウィジェットの状態を管理
class _MainAppState extends State<MainApp> {
  // 人数を保持する変数を宣言し、初期値を0に設定
  int _personCount = 0;

  @override
  void initState() {
    super.initState();
    // ウィジェットの初期化時にデータベースから人数を取得
    _fetchPersonCount();
  }

  // データベースから人数を取得するメソッド
  Future<void> _fetchPersonCount() async {
    // Supabaseクライアントを使用して、countテーブルからpersonカラムの値を取得
    final response =
        await Supabase.instance.client.from('count').select('person').single();

    // 取得した人数を_personCount変数に設定し、UIを更新
    setState(() {
      _personCount = response['person'] as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    // アプリケーションのUIを構築
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // 取得した人数を表示するテキストウィジェット
          child: Text('Person Count: $_personCount'),
        ),
      ),
    );
  }
}
