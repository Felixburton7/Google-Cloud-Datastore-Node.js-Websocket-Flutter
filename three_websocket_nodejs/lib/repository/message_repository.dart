import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message_model.dart';

class MessageRepository {
  final String baseUrl;

  MessageRepository({required this.baseUrl});

  Future<List<Message>> fetchMessages() async {
    final response = await http.get(Uri.parse('$baseUrl/data'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load messages. Status code: ${response.statusCode}');
    }
  }

  Future<void> addMessage(Message message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/data'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(message.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception(
          'Failed to add message. Status code: ${response.statusCode}');
    }
  }
}
