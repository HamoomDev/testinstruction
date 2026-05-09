import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/util/calorie_calculator.dart';
import '../../../../app/routes/app_routes.dart';
import '../../domain/entities/user_profile_entity.dart';

class OnboardingController extends GetxController {
  final StorageService _storage = Get.find();

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final targetWeightController = TextEditingController();

  final isMale = true.obs;
  final selectedActivity = 'moderate'.obs;
  final isLoading = false.obs;

  final activityOptions = [
    'sedentary',
    'light',
    'moderate',
    'active',
    'very_active',
  ];

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    targetWeightController.dispose();
    super.onClose();
  }

  void setGender(bool male) => isMale.value = male;
  void setActivity(String level) => selectedActivity.value = level;

  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation_required'.tr;
    }
    return null;
  }

  String? validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation_required'.tr;
    }
    if (double.tryParse(value) == null) {
      return 'validation_number'.tr;
    }
    return null;
  }

  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    final profile = UserProfileEntity(
      name: nameController.text.trim(),
      isMale: isMale.value,
      age: int.parse(ageController.text.trim()),
      heightCm: double.parse(heightController.text.trim()),
      weightKg: double.parse(weightController.text.trim()),
      targetWeightKg: double.parse(targetWeightController.text.trim()),
      activityLevel: selectedActivity.value,
    );

    final dailyGoal = CalorieCalculator.calculateDailyGoal(
      weightKg: profile.weightKg,
      heightCm: profile.heightCm,
      age: profile.age,
      isMale: profile.isMale,
      activityLevel: profile.activityLevel,
    );

    await _storage.saveUserProfile(profile.toJson());
    await _storage.saveDailyGoal(dailyGoal);

    isLoading.value = false;
    Get.offAllNamed(AppRoutes.home);
  }
}
