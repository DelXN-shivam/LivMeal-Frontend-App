import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mess_model.dart';

class MessApiService {
  static const String baseUrl = 'https://liv-meal-backend.vercel.app/api/v1';
  static const Duration _timeoutDuration = Duration(seconds: 10);
  
  // Cache for storing API responses
  static MessApiResponse? _cachedMesses;
  static DateTime? _lastFetchTime;
  static const Duration _cacheValidityDuration = Duration(minutes: 5);
  
  // Get all messes with caching
  static Future<MessApiResponse> getAllMesses({bool forceRefresh = false}) async {
    // Check if we have valid cached data and don't need to force refresh
    if (!forceRefresh && _cachedMesses != null && _lastFetchTime != null) {
      final timeSinceLastFetch = DateTime.now().difference(_lastFetchTime!);
      if (timeSinceLastFetch < _cacheValidityDuration) {
        return _cachedMesses!;
      }
    }
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/mess/all'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(_timeoutDuration);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final messApiResponse = MessApiResponse.fromJson(jsonData);
        
        // Cache the response
        _cachedMesses = messApiResponse;
        _lastFetchTime = DateTime.now();
        
        return messApiResponse;
      } else {
        throw Exception('Failed to load messes: ${response.statusCode}');
      }
    } catch (e) {
      // If we have cached data and there's an error, return cached data
      if (_cachedMesses != null) {
        return _cachedMesses!;
      }
      throw Exception('Error fetching messes: $e');
    }
  }
  
  // Clear cache method
  static void clearCache() {
    _cachedMesses = null;
    _lastFetchTime = null;
  }

  // Get mess by ID (if needed for future use)
  static Future<MessModel> getMessById(String messId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/mess/$messId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return MessModel.fromJson(jsonData['data']);
      } else {
        throw Exception('Failed to load mess: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching mess: $e');
    }
  }
}
