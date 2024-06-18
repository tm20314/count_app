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
    _personCountData
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.count.toDouble(),
            ))
        .toList();

    return Scaffold(
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
                            if (index >= 0 && index < _personCountData.length) {
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
    );
  }
}

class PersonCountData {
  final DateTime time;
  final int count;

  PersonCountData(this.time, this.count);
}
