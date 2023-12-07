import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/news_model.dart';

class ApiService {
  static const String apiUrl = 'https://www.kalbela.com/json-feed/national.json';
  static const String storageKey = 'api_data';

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<List<NewsItem>> fetchData() async {
    try {
      // Check if data is stored in secure storage
      String? storedData = await _secureStorage.read(key: storageKey);
      if (storedData != null) {
        // If data is found, parse and return it
        final List<dynamic> parsedData = json.decode(storedData);
        List<NewsItem> newsList = parsedData.map((item) => NewsItem.fromJson(item)).toList();
        return newsList;
      }

      // If no stored data, fetch from API
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> data = json.decode(response.body);

        // Convert the data to a list of NewsItem
        List<NewsItem> newsList = [];

        data.forEach((key, value) {
          if (value is Map<String, dynamic>) {
            newsList.add(NewsItem.fromJson(value));
          }
        });

        // Save the data to secure storage for future use
        await _secureStorage.write(key: storageKey, value: json.encode(newsList));

        return newsList;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
