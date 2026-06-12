import 'dart:convert';

import 'package:find_me_app/features/cases_map/data/models/location_result.dart';
import 'package:http/http.dart' as http;

class LocationSearchService {
  static Future<List<LocationResult>> searchMultiple(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=jsonv2&countrycodes=eg&limit=5',
    );

    try {
      final response = await http.get(
        url,
        headers: {'User-Agent': 'find_me_app'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((e) => LocationResult.fromJson(e)).toList();
      }
    } catch (_) {}

    return [];
  }
}
