import 'dart:convert';
import 'package:http/http.dart' as http;
import "../Models/article_model.dart";

class ApiService {
  static const _apiKey = 'fbf6bbd6d9ee4ad6878e22030e55fe08'; 
  static const _baseUrl =
    'https://newsapi.org/v2/everything?q=indonesia&apiKey=$_apiKey';
  Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> articlesJson = json['articles'];
        return articlesJson.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      throw Exception('Gagal terhubung ke Server: $e');
    }
  }
}