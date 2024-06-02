import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  late String baseUrl = "127.0.0.1"; // Update this if your API is hosted elsewhere

  ApiService({required this.baseUrl});

  // Example function to get data from your API
  Future<List<String>> fetchRecommendations(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/recommend/$userId'),
    );
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<String> recommendations = jsonResponse.cast<String>();
      print(recommendations);
      return recommendations;
    } else {
      // If the server returns an error response, throw an exception.
      throw Exception('Failed to load recommendations');
    }
  }
}

void main() async {
  try {
    final ApiService apiService = ApiService(baseUrl: "http://192.168.1.3:8000");
    List<String> recommendations = await apiService.fetchRecommendations('qSvKfNU9VNVzB2cf0qygxQtuWQ52');
    print('Recommendations: $recommendations');
  } catch (e) {
    print('Error: $e');
  }
}