import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

// MainAppStateクラス: MainAppウィジェットの状態を管理
class MainAppState extends State<MainApp> {
  // 人数を保持する変数を宣言し、初期値を0に設定
  int _personCount = 0;
  // タイムスタンプを保持する変数を宣言し、初期値を空文字列に設定
  String _timestamp = '';
  // 画像のURLを保持する変数を宣言し、初期値を空文字列に設定
  String _imageUrl = '';
  // 24時間分の人数データを保持するリストを宣言
  List<PersonCountData> _personCountData = [];

  @override
  void initState() {
    super.initState();
    // ウィジェットの初期化時にデータベースから人数、タイムスタンプ、画像URL、24時間分の人数データを取得
    _fetchData();
  }

// データベースからデータを取得するメソッド
  Future<void> _fetchData() async {
    // Supabaseクライアントを使用して、countテーブルからpersonカラム、timeカラム、image_urlカラムの最新の値を取得
    final response = await Supabase.instance.client
        .from('count')
        .select('person, time, image_url')
        .order('time', ascending: false)
        .limit(1)
        .single();

    // 取得したレスポンスの内容をコンソールに出力
    debugPrint('Response: $response');

    // 取得した人数、時刻、画像URLを変数に設定し、UIを更新
    setState(() {
      _personCount = response['person'] as int;
      _timestamp = response['time'] as String;
      _imageUrl = response['image_url'] as String;
    });

    // Supabaseクライアントを使用して、countテーブルから過去24時間分の人数データを取得
    final countResponse = await Supabase.instance.client
        .from('count')
        .select('person, time')
        .order('time', ascending: false)
        .limit(24);

    // 取得した人数データをリストに変換し、_personCountDataに設定
    setState(() {
      _personCountData = countResponse
          .map<PersonCountData>((item) => PersonCountData(
                DateTime.parse(item['time'] as String),
                item['person'] as int,
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 24時間分の人数データからグラフ用のデータを作成
    _personCountData
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.count.toDouble(),
            ))
        .toList();

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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person,
                  size: 100,
                ),
                Text(
                  '今研究室にいる人数は\n $_personCount人\nです',
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'タイムスタンプ: $_timestamp',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                _imageUrl.isNotEmpty
                    ? Image.network(
                        _imageUrl,
                        height: 200,
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      barGroups: _personCountData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final data = entry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: data.count.toDouble(),
                              color: Colors.blue,
                              width: 22,
                            ),
                          ],
                        );
                      }).toList(),
                      alignment: BarChartAlignment.spaceAround,
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              final index = value.toInt();
                              if (index >= 0 &&
                                  index < _personCountData.length) {
                                final date = _personCountData[index].time;
                                final format = DateFormat('HH');
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(format.format(date)),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Text(value.toInt().toString());
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.withOpacity(0.2),
                            strokeWidth: 1,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 人数データを表すクラス
class PersonCountData {
  final DateTime time;
  final int count;

  PersonCountData(this.time, this.count);
}
