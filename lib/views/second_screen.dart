import 'dart:math';

import 'package:count_app/views/login_screen.dart';
import 'package:count_app/widgets/app_drawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  int _personCount = 0;
  String _timestamp = '';
  String _imageUrl = '';
  List<PersonCountData> _personCountData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await Supabase.instance.client
        .from('count')
        .select('person, time, image_url')
        .order('time', ascending: false)
        .limit(1)
        .single();

    debugPrint('Response: $response');

    setState(() {
      _personCount = response['person'] as int;
      _timestamp = response['time'] as String;
      _imageUrl = response['image_url'] as String;
    });

    final countResponse = await Supabase.instance.client
        .from('count')
        .select('person, time')
        .order('time', ascending: false)
        .limit(24);

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
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('研究室の人数'),
          actions: [
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (_) {
                        return const LogoutDialog();
                      });
                }),
          ],
        ),
        drawer: const AppDrawer(), // ここでAppDrawerを追加

        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildCurrentCount(),
                  const SizedBox(height: 20),
                  _buildTimestamp(),
                  const SizedBox(height: 20),
                  _buildImage(),
                  const SizedBox(height: 20),
                  _buildGraph(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentCount() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(
              Icons.person,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              '現在の人数',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            Text(
              '$_personCount人',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimestamp() {
    return Text(
      'タイムスタンプ: $_timestamp',
      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildImage() {
    if (_imageUrl.isEmpty) {
      return const SizedBox();
    }

    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          _imageUrl,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
      onTap: () {
        showGeneralDialog(
          context: context,
          transitionDuration: const Duration(milliseconds: 300),
          barrierDismissible: true,
          barrierLabel: '',
          pageBuilder: (context, animation1, animation2) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SingleChildScrollView(
                    child: InteractiveViewer(
                      minScale: 0.1,
                      maxScale: 5,
                      child: Image.network(_imageUrl),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGraph() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '過去24時間の人数変動',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: max(MediaQuery.of(context).size.width - 32, 600),
                height: 300,
                child: BarChart(
                  BarChartData(
                    barGroups: _personCountData.reversed
                        .toList()
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final data = entry.value;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: data.count.toDouble(),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.blue, Colors.blueAccent],
                            ),
                            width: 16,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4)),
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
                            if (index >= 0 && index < _personCountData.length) {
                              final date = _personCountData.reversed
                                  .toList()[index]
                                  .time;
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
                          interval: 1,
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
            ),
          ],
        ),
      ),
    );
  }
}

class PersonCountData {
  final DateTime time;
  final int count;

  PersonCountData(this.time, this.count);
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('注意', textAlign: TextAlign.center),
      content: const Text('ログアウトしても大丈夫そ？', textAlign: TextAlign.center),
      actions: <Widget>[
        GestureDetector(
          child: const Text('いいえ'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: const Text('はい大丈夫そ'),
          onTap: () {
            Supabase.instance.client.auth.signOut();
            const SnackBar(content: Text('ログアウトしました'));

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
              return const LoginScreen();
            }));
          },
        )
      ],
    );
  }
}
