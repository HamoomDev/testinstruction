import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../../features/food_log/domain/entities/food_analysis_entity.dart';

class ClaudeVisionService {
  String get _apiKey => dotenv.env['ANTHROPIC_API_KEY'] ?? '';

  bool get isMockMode => _apiKey.isEmpty || _apiKey == 'your_api_key_here';

  Future<FoodAnalysisEntity> analyzeFood(File imageFile) async {
    if (isMockMode) {
      return _mockAnalysis();
    }

    final imageBytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(imageBytes);
    final ext = imageFile.path.split('.').last.toLowerCase();
    final mediaType = ext == 'png' ? 'image/png' : 'image/jpeg';

    final body = jsonEncode({
      'model': AppConstants.claudeModel,
      'max_tokens': 1024,
      'messages': [
        {
          'role': 'user',
          'content': [
            {
              'type': 'image',
              'source': {
                'type': 'base64',
                'media_type': mediaType,
                'data': base64Image,
              },
            },
            {
              'type': 'text',
              'text': '''Analyze this food image and estimate its nutritional content.
Respond with ONLY a valid JSON object in this exact format (no markdown, no extra text):
{
  "foodName": "Name of the food in English",
  "foodNameTh": "ชื่ออาหารเป็นภาษาไทย",
  "estimatedCalories": 350,
  "protein_g": 12.5,
  "carbs_g": 45.0,
  "fat_g": 8.0,
  "servingSize": "1 serving (approximately)",
  "confidence": "high"
}
Use realistic nutritional values. confidence can be "high", "medium", or "low".''',
            },
          ],
        },
      ],
    });

    try {
      final response = await http.post(
        Uri.parse(AppConstants.apiBaseUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': _apiKey,
          'anthropic-version': AppConstants.apiVersion,
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final text = decoded['content'][0]['text'] as String;
        final jsonText = _extractJson(text);
        final data = jsonDecode(jsonText) as Map<String, dynamic>;
        return FoodAnalysisEntity.fromJson(data);
      } else {
        throw Exception('API error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Analysis failed: $e');
    }
  }

  String _extractJson(String text) {
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start != -1 && end != -1) {
      return text.substring(start, end + 1);
    }
    return text;
  }

  FoodAnalysisEntity _mockAnalysis() {
    return const FoodAnalysisEntity(
      foodName: 'Fried Rice (Mock)',
      foodNameTh: 'ข้าวผัด (โหมดทดลอง)',
      estimatedCalories: 450,
      proteinG: 15.0,
      carbsG: 65.0,
      fatG: 12.0,
      servingSize: '1 plate (~300g)',
      confidence: 'high',
    );
  }
}
