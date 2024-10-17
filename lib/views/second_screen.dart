// lib/views/second_screen.dart
import 'package:count_app/views/widgets/app_drawer.dart';
import 'package:count_app/views/widgets/current_count_widget.dart';
import 'package:count_app/views/widgets/graph_widget.dart';
import 'package:count_app/views/widgets/image_widget.dart';
import 'package:count_app/views/widgets/location_title_card_widget.dart';
import 'package:count_app/views/widgets/logout-widget.dart';
import 'package:flutter/material.dart';

import '../controllers/second_screen_controller.dart';
import '../models/person_count_data.dart';
import 'widgets/radial_gauge_widget.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  final SecondScreenController _controller = SecondScreenController();
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
    final response = await _controller.fetchLatestData();
    setState(() {
      _personCount = response['person'] as int;
      _timestamp = response['time'] as String;
      _imageUrl = response['image_url'] as String;
    });

    final countData = await _controller.fetchPersonCountData();
    setState(() {
      _personCountData = countData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: const AppDrawer(),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 2024 ||
                  orientation == Orientation.landscape) {
                // 画面幅が2024以上または横向きの場合
                return Wrap(
                  children: [
                    LocationTitleCard(timestamp: _timestamp),
                    CurrentCountWidget(personCount: _personCount),
                    ImageWidget(imageUrl: _imageUrl),
                    RadialGaugeWidget(personCount: _personCount),
                    GraphWidget(personCountData: _personCountData),
                  ],
                );
              } else {
                // 画面幅が2024以下の場合
                return ListView(
                  children: [
                    LocationTitleCard(timestamp: _timestamp),
                    CurrentCountWidget(personCount: _personCount),
                    ImageWidget(imageUrl: _imageUrl),
                    RadialGaugeWidget(personCount: _personCount),
                    GraphWidget(personCountData: _personCountData),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
