import 'dart:convert';
import 'package:http/http.dart' as http;

/// API Service for Medical Chatbot + Symptom Checker
/// 
/// Connects to combined Flask backend on single port
/// - Chat: /get, /clear
/// - Symptom Checker: /start_assessment, /submit_answer, /get_diagnosis
class ApiService {
  // ⚠️ CHANGE THIS TO YOUR IP/URL
  // For Android Emulator: 'http://10.0.2.2:8080'
  // For iOS Simulator: 'http://localhost:8080'
  // For Chrome/Web: 'http://localhost:8080'
  // For Real Device: 'http://YOUR_COMPUTER_IP:8080'
  static const String baseUrl = 'http://10.0.2.2:8080';

  // ============================================================================
  // HEALTH CHECK
  // ============================================================================

  /// Test connection to Flask backend
  static Future<bool> testConnection() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
      ).timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }

  // ============================================================================
  // CHAT (Option 1)
  // ============================================================================

  /// Send a chat message and get AI response
  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/get'),
        body: {'msg': message},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          return data['answer'] ?? response.body;
        } catch (e) {
          // Response is plain text
          return response.body;
        }
      } else if (response.statusCode == 429) {
        return 'Rate limit exceeded. Please wait a moment and try again.';
      } else {
        return 'Error: Server returned ${response.statusCode}';
      }
    } catch (e) {
      print('Chat error: $e');
      return 'Error: Could not connect to server. Is Flask running?';
    }
  }

  /// Clear chat conversation history
  static Future<bool> clearConversation() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/clear'),
      ).timeout(const Duration(seconds: 10));
      return response.statusCode == 200;
    } catch (e) {
      print('Clear conversation error: $e');
      return false;
    }
  }

  // ============================================================================
  // SYMPTOM CHECKER (Option 3)
  // ============================================================================

  /// Start a new symptom assessment
  static Future<Map<String, dynamic>> startAssessment() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/start_assessment'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': 'error',
          'message': 'Failed to start assessment: ${response.statusCode}'
        };
      }
    } catch (e) {
      print('Start assessment error: $e');
      return {
        'status': 'error',
        'message': 'Could not connect to server'
      };
    }
  }

  /// Submit an answer to a question
  static Future<Map<String, dynamic>> submitAnswer(
    String questionId,
    dynamic answer,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/submit_answer'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'question_id': questionId,
          'answer': answer,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': 'error',
          'message': 'Failed to submit answer: ${response.statusCode}'
        };
      }
    } catch (e) {
      print('Submit answer error: $e');
      return {
        'status': 'error',
        'message': 'Could not connect to server'
      };
    }
  }

  /// Get diagnosis based on submitted answers
/// Now sends answers directly in request body
static Future<Map<String, dynamic>> getDiagnosis(Map<String, dynamic> answers) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/get_diagnosis'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'answers': answers}),
    ).timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {
        'status': 'error',
        'message': 'Failed to get diagnosis: ${response.statusCode}'
      };
    }
  } catch (e) {
    print('Get diagnosis error: $e');
    return {
      'status': 'error',
      'message': 'Could not connect to server'
    };
  }
}

  /// Get all assessment questions (optional - for dynamic loading)
  static Future<List<Map<String, dynamic>>> getQuestions() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_questions'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['questions']);
      } else {
        return [];
      }
    } catch (e) {
      print('Get questions error: $e');
      return [];
    }
  }

  // ============================================================================
  // API CHAT (Alternative JSON endpoint)
  // ============================================================================

  /// Send chat message via API endpoint (JSON request)
  static Future<Map<String, dynamic>> apiChat(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'error': 'Server returned ${response.statusCode}'
        };
      }
    } catch (e) {
      print('API chat error: $e');
      return {
        'error': 'Could not connect to server'
      };
    }
  }
}