import 'package:flutter/material.dart';

import '../models/count_model.dart';
import '../services/supabase_service.dart';

class CountController extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  int _personCount = 0;
  String _timestamp = '';
  String _imageUrl = '';
  List<PersonCountData> _personCountData = [];

  int get personCount => _personCount;
  String get timestamp => _timestamp;
  String get imageUrl => _imageUrl;
  List<PersonCountData> get personCountData => _personCountData;

  Future<void> fetchData() async {
    final response = await _supabaseService.fetchLatestCount();
    _personCount = response['person'] as int;
    _timestamp = response['time'] as String;
    _imageUrl = response['image_url'] as String;

    final countResponse = await _supabaseService.fetchCountData();
    _personCountData = countResponse
        .map<PersonCountData>((item) => PersonCountData.fromJson(item))
        .toList();

    notifyListeners();
  }
}
