import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/law_update.dart';

class ApiService {
  // Use environment variable for production URL, fallback to localhost for dev
  static const String baseUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'http://127.0.0.1:8000',
  );

  /// Triggers the scraper in background
  static Future<bool> triggerScrape() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/trigger-scrape'),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error triggering scrape: $e');
      return false;
    }
  }

  /// Fetches latest updates from the backend
  static Future<List<LawUpdate>> getUpdates({int limit = 50}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/updates?limit=$limit'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => LawUpdate.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load updates');
      }
    } catch (e) {
      print('Error fetching updates: $e');
      return [];
    }
  }
}
