import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AiChatController extends GetxController {
  var messages = <Map<String, String>>[].obs;
  var isLoading = false.obs;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    messages.add({'role': 'user', 'text': text});
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/ai/chat'), // Đổi thành IP backend nếu test thiết bị thật
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': text}),
      );
      final data = jsonDecode(response.body);
      messages.add({'role': 'bot', 'text': data['reply'] ?? 'Không có phản hồi.'});
    } catch (e) {
      messages.add({'role': 'bot', 'text': 'Lỗi kết nối AI.'});
    } finally {
      isLoading.value = false;
    }
  }
} 