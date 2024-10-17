// lib/controllers/second_screen_controller.dart
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/person_count_data.dart';

class SecondScreenController {
  Future<Map<String, dynamic>> fetchLatestData() async {
    final response = await Supabase.instance.client
        .from('count')
        .select('person, time, image_url')
        .order('time', ascending: false)
        .limit(1)
        .single();
    return response;
  }

  Future<List<PersonCountData>> fetchPersonCountData() async {
    final countResponse = await Supabase.instance.client
        .from('count')
        .select('person, time')
        .order('time', ascending: false)
        .limit(24);

    return countResponse
        .map<PersonCountData>((item) => PersonCountData(
              DateTime.parse(item['time'] as String),
              item['person'] as int,
            ))
        .toList();
  }
}
