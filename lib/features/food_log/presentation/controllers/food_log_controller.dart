import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/claude_vision_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/entities/food_analysis_entity.dart';
import '../../../home/domain/entities/food_entry_entity.dart';

enum FoodLogState { idle, picking, analyzing, result, error }

class FoodLogController extends GetxController {
  final ClaudeVisionService _claudeService = ClaudeVisionService();
  final StorageService _storage = Get.find();
  final ImagePicker _picker = ImagePicker();

  final state = FoodLogState.idle.obs;
  final selectedImage = Rxn<File>();
  final analysisResult = Rxn<FoodAnalysisEntity>();
  final errorMessage = ''.obs;

  bool get isMockMode => _claudeService.isMockMode;
  String get todayKey => DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> pickImage(ImageSource source) async {
    try {
      state.value = FoodLogState.picking;
      final xFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1024,
      );
      if (xFile == null) {
        state.value = FoodLogState.idle;
        return;
      }
      selectedImage.value = File(xFile.path);
      await _analyzeImage(selectedImage.value!);
    } catch (e) {
      errorMessage.value = 'food_log_error_pickup'.tr;
      state.value = FoodLogState.error;
    }
  }

  Future<void> _analyzeImage(File image) async {
    state.value = FoodLogState.analyzing;
    try {
      final result = await _claudeService.analyzeFood(image);
      analysisResult.value = result;
      state.value = FoodLogState.result;
    } catch (e) {
      errorMessage.value = 'food_log_error_api'.tr;
      state.value = FoodLogState.error;
    }
  }

  Future<void> saveEntry() async {
    final analysis = analysisResult.value;
    if (analysis == null) return;

    final entry = FoodEntryEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      foodName: analysis.foodName,
      foodNameTh: analysis.foodNameTh,
      calories: analysis.estimatedCalories,
      proteinG: analysis.proteinG,
      carbsG: analysis.carbsG,
      fatG: analysis.fatG,
      servingSize: analysis.servingSize,
      loggedAt: DateTime.now(),
    );

    await _storage.addFoodEntry(todayKey, entry.toJson());
    Get.back(result: true);
  }

  void retake() {
    selectedImage.value = null;
    analysisResult.value = null;
    state.value = FoodLogState.idle;
  }
}
